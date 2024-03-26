import chisel3._
import chisel3.util._
import dataclass.data
import javax.xml.crypto.Data

// Asger Tester
class VendingMachine(maxCount: Int, c: Int) extends Module {  //MaxCount for displayMultiplexer, c for debouncer
  val io = IO(new Bundle {
    val price = Input(UInt(5.W))
    val coin2Raw = Input(Bool())
    val coin5Raw = Input(Bool())
    val buyRaw = Input(Bool())

    val releaseCan = Output(Bool())
    val alarm = Output(Bool())
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  val coin2 = WireDefault(false.B)
  val coin5 = WireDefault(false.B)
  val buy = WireDefault(false.B)

// Define debouncers
  val coin2Deb = Module(new Debouncer(c))
  coin2Deb.io.in := io.coin2Raw
  coin2 := coin2Deb.io.out

  val coin5Deb = Module(new Debouncer(c))
  coin5Deb.io.in := io.coin5Raw
  coin5 := coin5Deb.io.out
  
  val buyDeb = Module(new Debouncer(c))
  buyDeb.io.in := io.buyRaw
  buy := buyDeb.io.out

  // Define DataPath and fsm
  val dataPath = Module(new dataPath())
  val fsm = Module(new fsm())

  // Connect input pins to dataPath and fsm
  dataPath.io.price := io.price
  dataPath.io.coin2 := coin2
  dataPath.io.coin5 := coin5

  dataPath.io.sub := fsm.io.sub
  dataPath.io.add := fsm.io.add
  
  dataPath.io.alarm := fsm.io.alarm

  fsm.io.price := io.price
  fsm.io.buy := buy

  fsm.io.sum := dataPath.io.sum
  fsm.io.coin := dataPath.io.coin
  fsm.io.empty := dataPath.io.isEmpty
  
// Configure DisplayMultiplexer with input connections
  val dispMux = Module(new DisplayMultiplexer(maxCount))
  dispMux.io.price := io.price
  dispMux.io.sum := dataPath.io.sum
  dispMux.io.customIn := dataPath.io.customOut
  
// Connect output pins
  io.alarm := fsm.io.alarm
  io.releaseCan := fsm.io.releaseCan
  io.seg := dispMux.io.seg
  io.an := dispMux.io.an
}

// generate Verilog
object VendingMachine extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new VendingMachine(100_000, 10_000_000)) // (1kHz display, 0.1 s debounce)(maxCount max 130.000)
}