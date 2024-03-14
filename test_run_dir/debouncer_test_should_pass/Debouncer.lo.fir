FIRRTL version 1.1.0
circuit Debouncer :
  module debounceFsm :
    input clock : Clock
    input reset : UInt<1>
    input io_din : UInt<1>
    input io_countReg : UInt<27>
    output io_dout : UInt<1>
    output io_runTimer : UInt<1>

    reg stateReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[Debouncer.scala 42:25]
    node _T = asUInt(UInt<1>("h0")) @[Debouncer.scala 45:19]
    node _T_1 = asUInt(stateReg) @[Debouncer.scala 45:19]
    node _T_2 = eq(_T, _T_1) @[Debouncer.scala 45:19]
    node _GEN_0 = mux(io_din, UInt<1>("h1"), stateReg) @[Debouncer.scala 47:19 48:18 42:25]
    node _T_3 = asUInt(UInt<1>("h1")) @[Debouncer.scala 45:19]
    node _T_4 = asUInt(stateReg) @[Debouncer.scala 45:19]
    node _T_5 = eq(_T_3, _T_4) @[Debouncer.scala 45:19]
    node _T_6 = eq(io_din, UInt<1>("h0")) @[Debouncer.scala 52:12]
    node _GEN_1 = mux(_T_6, UInt<2>("h2"), stateReg) @[Debouncer.scala 52:20 53:18 42:25]
    node _T_7 = asUInt(UInt<2>("h2")) @[Debouncer.scala 45:19]
    node _T_8 = asUInt(stateReg) @[Debouncer.scala 45:19]
    node _T_9 = eq(_T_7, _T_8) @[Debouncer.scala 45:19]
    node _T_10 = eq(io_countReg, UInt<2>("h3")) @[Debouncer.scala 60:29]
    node _GEN_2 = mux(_T_10, UInt<1>("h0"), stateReg) @[Debouncer.scala 60:41 61:18 42:25]
    node _GEN_3 = mux(io_din, UInt<1>("h1"), _GEN_2) @[Debouncer.scala 57:19 58:18]
    node _GEN_4 = mux(_T_9, _GEN_3, stateReg) @[Debouncer.scala 45:19 42:25]
    node _GEN_5 = mux(_T_5, _GEN_1, _GEN_4) @[Debouncer.scala 45:19]
    node _GEN_6 = mux(_T_2, _GEN_0, _GEN_5) @[Debouncer.scala 45:19]
    node _io_dout_T = eq(stateReg, UInt<1>("h1")) @[Debouncer.scala 66:23]
    node _io_dout_T_1 = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 66:45]
    node _io_dout_T_2 = or(_io_dout_T, _io_dout_T_1) @[Debouncer.scala 66:32]
    node _io_runTimer_T = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 67:27]
    io_dout <= _io_dout_T_2 @[Debouncer.scala 66:10]
    io_runTimer <= _io_runTimer_T @[Debouncer.scala 67:15]
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_6) @[Debouncer.scala 42:{25,25}]

  module Debouncer :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<1>
    output io_out : UInt<1>

    inst fsm of debounceFsm @[Debouncer.scala 12:21]
    reg countReg : UInt<27>, clock with :
      reset => (UInt<1>("h0"), countReg) @[Debouncer.scala 10:27]
    node _countReg_T = add(countReg, UInt<1>("h1")) @[Debouncer.scala 18:28]
    node _countReg_T_1 = tail(_countReg_T, 1) @[Debouncer.scala 18:28]
    node _GEN_0 = mux(fsm.io_runTimer, _countReg_T_1, UInt<1>("h0")) @[Debouncer.scala 17:26 18:16 20:16]
    io_out <= fsm.io_dout @[Debouncer.scala 15:12]
    countReg <= mux(reset, UInt<27>("h0"), _GEN_0) @[Debouncer.scala 10:{27,27}]
    fsm.clock <= clock
    fsm.reset <= reset
    fsm.io_din <= io_in @[Debouncer.scala 13:16]
    fsm.io_countReg <= countReg @[Debouncer.scala 14:21]
