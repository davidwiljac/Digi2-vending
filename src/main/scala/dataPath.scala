import chisel3._
import chisel3.util._
import dataclass.data
import javax.xml.crypto.Data

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
      when(selector1 === 14.U){selector1 := 0.U}
      when(selector2 === 14.U){selector2 := 0.U}
      when(selector3 === 14.U){selector3 := 0.U}
      when(selector4 === 14.U){selector4 := 0.U}
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
      when(selector1 === 11.U){selector1 := 0.U}
      when(selector2 === 11.U){selector2 := 0.U}
      when(selector3 === 11.U){selector3 := 0.U}
      when(selector4 === 11.U){selector4 := 0.U}
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