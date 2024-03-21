import chisel3._
import chisel3.util._
import dataclass.data
import javax.xml.crypto.Data

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
  for(i <- 0 until 4) {
    dispMux.io.customIn(i) := 0.U
  }
  dispMux.io.price := io.price
  dispMux.io.sum := dataPath.io.sum
  dispMux.io.customIn := dataPath.io.customOut
  
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
    val alarm = Input(Bool())
    val sum = Output(UInt(7.W))
    val coin = Output(Bool())
    val isEmpty = Output(Bool())
    val customOut = Output(Vec(4, UInt(7.W)))
  })

  for(i <- 0 until 4) {
    io.customOut(i) := 0.U
  }
  // Define internal wires
  val coinVal = WireDefault(0.U)

// Define sumReg 
  val sumReg = RegInit(0.U(7.W))

  val numCanReg = RegInit(3.U(8.W))
// Configure MUX for wire coinVal
  when(io.coin2 === true.B){
    coinVal := 2.U
  } .elsewhen(io.coin5 === true.B){
    coinVal := 5.U
  }
  
  // Handle input from FSM
  when((io.sub === false.B)&&(io.add === false.B)){ //Idle
    sumReg := sumReg
  }.elsewhen(io.add === true.B){ //Add coin
    sumReg := sumReg + coinVal
  }.elsewhen(io.sub === true.B) { //Buy a can
    sumReg := sumReg - io.price
    numCanReg := numCanReg - 1.U
    println("numCanReg: " + numCanReg)
  }
  val scrollReg = RegInit(0.U(32.W))
  when(numCanReg === 0.U){ //Write nO CANS LEFt when empty
    io.isEmpty := true.B
    val selector1 = RegInit(0.U(4.W))
    val selector2 = RegInit(1.U(4.W))
    val selector3 = RegInit(2.U(4.W))
    val selector4 = RegInit(3.U(4.W))
    scrollReg := scrollReg + 1.U
    when(scrollReg === 50_000_000.U){
      scrollReg := 0.U
      selector1 := selector1 + 1.U
      selector2 := selector2 + 1.U
      selector3 := selector3 + 1.U
      selector4 := selector4 + 1.U
      when(selector1 === 16.U){selector1 := 0.U}
      when(selector2 === 16.U){selector2 := 0.U}
      when(selector3 === 16.U){selector3 := 0.U}
      when(selector4 === 16.U){selector4 := 0.U}
    }
    val EMPTYWORD = VecInit(Seq("b0000000".U,"b0000000".U,"b0000000".U,
                          "b1010100".U, "b0111111".U, "b0000000".U, //NO
                          "b0111001".U, "b1110111".U, "b1010100".U, "b1101101".U, "b0000000".U, //CANS
                          "b0111000".U, "b1111001".U, "b1110001".U, "b1111000".U)) //LEFT
    io.customOut(3) := EMPTYWORD(selector1)
    io.customOut(2) := EMPTYWORD(selector2)
    io.customOut(1) := EMPTYWORD(selector3)
    io.customOut(0) := EMPTYWORD(selector4)
  }.otherwise{
    io.isEmpty := false.B
  }
  when(io.alarm === true.B){
    val selector1 = RegInit(0.U(4.W))
    val selector2 = RegInit(1.U(4.W))
    val selector3 = RegInit(2.U(4.W))
    val selector4 = RegInit(3.U(4.W))
    scrollReg := scrollReg + 1.U
    when(scrollReg === 50_000_000.U){
      scrollReg := 0.U
      selector1 := selector1 + 1.U
      selector2 := selector2 + 1.U
      selector3 := selector3 + 1.U
      selector4 := selector4 + 1.U
      when(selector1 === 13.U){selector1 := 0.U}
      when(selector2 === 13.U){selector2 := 0.U}
      when(selector3 === 13.U){selector3 := 0.U}
      when(selector4 === 13.U){selector4 := 0.U}
    }
    val YOUPOORWORD = VecInit(Seq("b0000000".U,"b0000000".U,"b0000000".U,
                          "b1101110".U, "b0111111".U, "b0111110".U, "b0000000".U, //YOU
                          "b1110011".U, "b0111111".U, "b0111111".U, "b1010000".U, "b0001011".U)) //POOR?
    io.customOut(3) := YOUPOORWORD(selector1)
    io.customOut(2) := YOUPOORWORD(selector2)
    io.customOut(1) := YOUPOORWORD(selector3)
    io.customOut(0) := YOUPOORWORD(selector4)
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
    val empty = Input(Bool())
    //output
    val sub = Output(Bool())
    val add = Output(Bool())
    val alarm = Output(Bool())
    val releaseCan = Output(Bool())
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
      } .elsewhen(io.empty){
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
}

// generate Verilog
object VendingMachine extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new VendingMachine(100_000, 10_000_000)) // (1kHz display, 0.1 s debounce)(maxCount max 130.000)
}


