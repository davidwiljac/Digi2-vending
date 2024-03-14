import chisel3._
import chisel3.util._
import dataclass.data

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
  
  // Define internal wires for debounced button inputs
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

  fsm.io.price := io.price
  fsm.io.buy := buy

  fsm.io.sum := dataPath.io.sum
  fsm.io.coin := dataPath.io.coin


// Configure DisplayMultiplexer with input connections
  val dispMux = Module(new DisplayMultiplexer(maxCount))
  dispMux.io.price := io.price
  dispMux.io.sum := dataPath.io.sum
  

// Connect output pins
  io.alarm := fsm.io.alarm
  io.releaseCan := fsm.io.releaseCan
  io.seg := dispMux.io.seg
  io.an := dispMux.io.an
}


class dataPath() extends Module {  
  val io = IO(new Bundle {
    val price = Input(UInt(5.W))
    val coin2 = Input(Bool())
    val coin5 = Input(Bool())
    val sub = Input(Bool())
    val add = Input(Bool())

    val sum = Output(UInt(7.W))
    val coin = Output(Bool())
  })

  // Define internal wires
  val coinVal = WireDefault(0.U)

// Define sumReg 
  val sumReg = RegInit(0.U(7.W))

// Configure MUX for wire coinVal
  when(io.coin2 === true.B){
    coinVal := 2.U
  } .elsewhen(io.coin5 === true.B){
    coinVal := 5.U
  }
  
// Configure MUX for sumReg
  when((io.sub === false.B)&&(io.add === false.B)){
    sumReg := sumReg
  }.elsewhen(io.add === true.B){
    sumReg := sumReg + coinVal
  }.elsewhen(io.sub === true.B) {
    sumReg := sumReg - io.price
  } 

// Connect output pins
  io.sum := sumReg
  io.coin := (io.coin2 || io.coin5)

}

class fsm extends Module{
  val io = IO(new Bundle{
    //input
    val price = Input(UInt(5.W))
    val sum = Input(UInt(8.W))
    val buy = Input(Bool())
    val coin = Input(Bool())

    //output
    val sub = Output(Bool())
    val add = Output(Bool())
    val alarm = Output(Bool())
    val releaseCan = Output(Bool())
  })

  // The six states
  object State extends ChiselEnum {
  val default, buy, buyHold, alarm, add, addHold = Value
  }

  import State._
  // The state register
  val stateReg = RegInit(default)

  // Next state logic
  switch(stateReg){
    is(default){
      when(io.buy && (io.sum>=io.price)){
        stateReg := buy
      } .elsewhen(io.buy && (io.sum<io.price)){
        stateReg := alarm
      }.elsewhen(io.coin){
        stateReg := add
      }
    }
    is(buy){
      stateReg:=buyHold
    }
    is(buyHold){
      when(io.buy === false.B){
        stateReg:= default
      }
    }
    is(alarm){
      when(io.buy === false.B){
        stateReg:= default
      }
    }
    is(add){
      stateReg := addHold
    }
    is(addHold){
      when(io.coin === false.B){
        stateReg:= default
      }
    }
  }

  // Output logic
  io.sub:= stateReg === buy
  io.add := stateReg === add
  io.alarm := stateReg === alarm
  io.releaseCan := (stateReg === buyHold)||(stateReg === buy)
}

// generate Verilog
object VendingMachine extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new VendingMachine(100000, 10000000)) // (1kHz display, 0.1 s debounce)(maxCount max 130.000)
}


