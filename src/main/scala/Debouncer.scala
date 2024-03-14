import chisel3._
import chisel3.util._


class Debouncer(c: Int) extends Module { // c kan maksimalt være 100E6 (svarer til 1 sekund)
  val io = IO(new Bundle {
    val in = Input(Bool())
    val out = Output(Bool())
  })
    val countReg = RegInit(0.U(27.W))

    val fsm = Module(new debounceFsm(c))
    fsm.io.din := io.in
    fsm.io.countReg := countReg
    io.out := fsm.io.dout

    when(fsm.io.runTimer){
      countReg := countReg + 1.U
    }.otherwise{
      countReg := 0.U
    }
}


class debounceFsm(c: Int) extends Module{  
  val io = IO(new Bundle{
    //input
    val din = Input(Bool())
    val countReg = Input(UInt(27.W))
    //output
    val dout = Output(Bool())
    val runTimer = Output(Bool())
  })

  // The six states
  object State extends ChiselEnum {
  val sOff, sOn, sTime = Value
  }

  import State._
  // The state register
  val stateReg = RegInit(sOff)

  // Next state logic
  switch(stateReg){
    is(sOff){
      when(io.din){
        stateReg := sOn
      }
    }
    is(sOn){
      when(!io.din){
        stateReg := sTime
      }
    }
    is(sTime){
      when(io.din){
        stateReg := sOn
      }
      .elsewhen(io.countReg === (c-2).U){
        stateReg := sOff
      }
    }
  }
  // Output logic
  io.dout:= (stateReg === sOn) || (stateReg === sTime)
  io.runTimer := stateReg === sTime
}