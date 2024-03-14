import chisel3._
import chisel3.util._

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


  // Define internal wires
  val sub = WireDefault(false.B)
  val add = WireDefault(false.B)
  val alarm = WireDefault(false.B)
  val releaseCan = WireDefault(false.B)
  val coinVal = WireDefault(0.U)
  val empty = WireDefault(false.B)

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


// Define sumReg 
  val sumReg = RegInit(0.U(7.W))

  // Define number of cans
  val numCanReg = RegInit(10.U(8.W))

// Configure DisplayMultiplexer with input connections
  val dispMux = Module(new DisplayMultiplexer(maxCount))
  for(i <- 0 until 4) {
    dispMux.io.customIn(i) := 0.U
  }
  dispMux.io.price := io.price
  dispMux.io.sum := sumReg

// Configure FSM with input and output connections
  val fsm = Module(new fsm())
// - input
  fsm.io.price := io.price
  fsm.io.sum := sumReg
  fsm.io.buy := buy
  fsm.io.coin := coin2 || coin5
  fsm.io.numOfCan := numCanReg

// - output
  sub := fsm.io.sub
  add := fsm.io.add
  alarm := fsm.io.alarm
  releaseCan := fsm.io.releaseCan
  empty := fsm.io.empty
  
// Configure MUX for wire coinVal
  when(coin2 === true.B){
    coinVal := 2.U
  } .elsewhen(coin5 === true.B){
    coinVal := 5.U
  }
  
  // Handle input from FSM
  when((sub === false.B)&&(add === false.B)){ //Idle
    sumReg := sumReg
  }.elsewhen(add === true.B){ //Add coin
    sumReg := sumReg + coinVal
  }.elsewhen(sub === true.B) { //Buy a can
    sumReg := sumReg - io.price
    numCanReg := numCanReg - 1.U
  }
  when(empty === true.B){ //Write Epty when empty
    dispMux.io.customIn(3) := "b1111001".U //E
    dispMux.io.customIn(2) := "b1110011".U //P
    dispMux.io.customIn(1) := "b1111000".U //t
    dispMux.io.customIn(0) := "b1101110".U //y

  }

// Connect output pins
  io.alarm := alarm
  io.releaseCan := releaseCan
  io.seg := dispMux.io.seg
  io.an := dispMux.io.an
}


class fsm extends Module{
  val io = IO(new Bundle{
    //input
    val price = Input(UInt(5.W))
    val sum = Input(UInt(8.W))
    val buy = Input(Bool())
    val coin = Input(Bool())
    val numOfCan = Input(UInt(8.W))
    //output
    val sub = Output(Bool())
    val add = Output(Bool())
    val alarm = Output(Bool())
    val releaseCan = Output(Bool())
    val empty = Output(Bool())
  })

  // The six states
  object State extends ChiselEnum {
  val default, buy, buyHold, alarm, add, addHold, empty = Value
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
      } .elsewhen(io.numOfCan === 0.U){
        stateReg := empty
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
    is(empty){
      //Do nothing
    }
  }

  // Output logic
  io.sub:= stateReg === buy
  io.add := stateReg === add
  io.alarm := stateReg === alarm
  io.releaseCan := (stateReg === buyHold)||(stateReg === buy)
  io.empty := stateReg === empty
}

// generate Verilog
object VendingMachine extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new VendingMachine(100_000, 10_000_000)) // (1kHz display, 0.1 s debounce)(maxCount max 130.000)
}


