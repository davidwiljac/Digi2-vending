import chisel3._
import chisel3.util._

class DisplayMultiplexer(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val customIn = Input(Vec(4, UInt(7.W)))
    val sum = Input(UInt(7.W))
    val price = Input(UInt(5.W))
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  val sevSeg = WireDefault("b1111111".U(7.W))
  val selectReg = RegInit(0.U(2.W))

  val table = Module(new BcdTable())
  table.io.address := 0.U

  val decoder = Module(new SevenSegDec())
  decoder.io.custom := 0.U
  decoder.io.customIn := 0.U
  decoder.io.in := 0.U
  sevSeg := decoder.io.out

  val tickCounterReg = RegInit (0.U(17.W))
  val tick = tickCounterReg === (maxCount-1).U
  tickCounterReg := tickCounterReg + 1.U
  
  when (tick) {
    tickCounterReg := 0.U
    selectReg := selectReg + 1.U
  }

  switch(selectReg) {
    is(0.U) {
      table.io.address := io.price
      decoder.io.in := table.io.data(3,0)
    }
    is(1.U) {
      table.io.address := io.price
      decoder.io.in := table.io.data(7,4)
    }
    is(2.U) {
      table.io.address := io.sum
      decoder.io.in := table.io.data(3,0)
    }
    is(3.U) {
      table.io.address := io.sum
      decoder.io.in := table.io.data(7,4)
    }
  }

  // Handles custom input
  when (io.customIn(0) =/= 0.U | io.customIn(1) =/= 0.U | io.customIn(2) =/= 0.U | io.customIn(3) =/= 0.U){
    decoder.io.custom := 1.U
    decoder.io.customIn := io.customIn(selectReg)
  }
  // *** your code ends here

  io.seg := sevSeg
  io.an := ~(1.U << selectReg)
}

// BcdTable from Chisel book (10.4)
class BcdTable extends Module {
  val io = IO(new Bundle {
    val address = Input(UInt(8.W))
    val data = Output(UInt(8.W))
  })

  val table = Wire(Vec (100 , UInt (8.W)))

  // Convert binary to BCD
  for (i <- 0 until 100) {
    table(i) := (((i/10) <<4) + i%10).U
  }

  io.data := table(io.address)
}