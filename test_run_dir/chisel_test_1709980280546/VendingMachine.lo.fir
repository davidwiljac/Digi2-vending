FIRRTL version 1.1.0
circuit VendingMachine :
  module fsm :
    input clock : Clock
    input reset : UInt<1>
    input io_price : UInt<5>
    input io_sum : UInt<8>
    input io_buy : UInt<1>
    input io_coin : UInt<1>
    output io_sub : UInt<1>
    output io_add : UInt<1>
    output io_alarm : UInt<1>
    output io_releaseCan : UInt<1>

    reg stateReg : UInt<3>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[VendingMachine.scala 95:25]
    node _T = asUInt(UInt<1>("h0")) @[VendingMachine.scala 97:19]
    node _T_1 = asUInt(stateReg) @[VendingMachine.scala 97:19]
    node _T_2 = eq(_T, _T_1) @[VendingMachine.scala 97:19]
    node _T_3 = geq(io_sum, io_price) @[VendingMachine.scala 99:29]
    node _T_4 = and(io_buy, _T_3) @[VendingMachine.scala 99:19]
    node _T_5 = lt(io_sum, io_price) @[VendingMachine.scala 101:36]
    node _T_6 = and(io_buy, _T_5) @[VendingMachine.scala 101:26]
    node _GEN_0 = mux(io_coin, UInt<3>("h4"), stateReg) @[VendingMachine.scala 103:26 104:18 95:25]
    node _GEN_1 = mux(_T_6, UInt<2>("h3"), _GEN_0) @[VendingMachine.scala 101:47 102:18]
    node _GEN_2 = mux(_T_4, UInt<1>("h1"), _GEN_1) @[VendingMachine.scala 100:18 99:41]
    node _T_7 = asUInt(UInt<1>("h1")) @[VendingMachine.scala 97:19]
    node _T_8 = asUInt(stateReg) @[VendingMachine.scala 97:19]
    node _T_9 = eq(_T_7, _T_8) @[VendingMachine.scala 97:19]
    node _T_10 = asUInt(UInt<2>("h2")) @[VendingMachine.scala 97:19]
    node _T_11 = asUInt(stateReg) @[VendingMachine.scala 97:19]
    node _T_12 = eq(_T_10, _T_11) @[VendingMachine.scala 97:19]
    node _T_13 = eq(io_buy, UInt<1>("h0")) @[VendingMachine.scala 111:19]
    node _GEN_3 = mux(_T_13, UInt<1>("h0"), stateReg) @[VendingMachine.scala 111:31 112:17 95:25]
    node _T_14 = asUInt(UInt<2>("h3")) @[VendingMachine.scala 97:19]
    node _T_15 = asUInt(stateReg) @[VendingMachine.scala 97:19]
    node _T_16 = eq(_T_14, _T_15) @[VendingMachine.scala 97:19]
    node _T_17 = eq(io_buy, UInt<1>("h0")) @[VendingMachine.scala 116:19]
    node _GEN_4 = mux(_T_17, UInt<1>("h0"), stateReg) @[VendingMachine.scala 116:31 117:17 95:25]
    node _T_18 = asUInt(UInt<3>("h4")) @[VendingMachine.scala 97:19]
    node _T_19 = asUInt(stateReg) @[VendingMachine.scala 97:19]
    node _T_20 = eq(_T_18, _T_19) @[VendingMachine.scala 97:19]
    node _T_21 = asUInt(UInt<3>("h5")) @[VendingMachine.scala 97:19]
    node _T_22 = asUInt(stateReg) @[VendingMachine.scala 97:19]
    node _T_23 = eq(_T_21, _T_22) @[VendingMachine.scala 97:19]
    node _T_24 = eq(io_coin, UInt<1>("h0")) @[VendingMachine.scala 124:20]
    node _GEN_5 = mux(_T_24, UInt<1>("h0"), stateReg) @[VendingMachine.scala 124:32 125:17 95:25]
    node _GEN_6 = mux(_T_23, _GEN_5, stateReg) @[VendingMachine.scala 97:19 95:25]
    node _GEN_7 = mux(_T_20, UInt<3>("h5"), _GEN_6) @[VendingMachine.scala 121:16 97:19]
    node _GEN_8 = mux(_T_16, _GEN_4, _GEN_7) @[VendingMachine.scala 97:19]
    node _GEN_9 = mux(_T_12, _GEN_3, _GEN_8) @[VendingMachine.scala 97:19]
    node _GEN_10 = mux(_T_9, UInt<2>("h2"), _GEN_9) @[VendingMachine.scala 108:15 97:19]
    node _GEN_11 = mux(_T_2, _GEN_2, _GEN_10) @[VendingMachine.scala 97:19]
    node _io_sub_T = eq(stateReg, UInt<1>("h1")) @[VendingMachine.scala 130:21]
    node _io_add_T = eq(stateReg, UInt<3>("h4")) @[VendingMachine.scala 131:22]
    node _io_alarm_T = eq(stateReg, UInt<2>("h3")) @[VendingMachine.scala 132:24]
    node _io_releaseCan_T = eq(stateReg, UInt<2>("h2")) @[VendingMachine.scala 133:30]
    node _io_releaseCan_T_1 = eq(stateReg, UInt<1>("h1")) @[VendingMachine.scala 133:54]
    node _io_releaseCan_T_2 = or(_io_releaseCan_T, _io_releaseCan_T_1) @[VendingMachine.scala 133:42]
    io_sub <= _io_sub_T @[VendingMachine.scala 130:9]
    io_add <= _io_add_T @[VendingMachine.scala 131:10]
    io_alarm <= _io_alarm_T @[VendingMachine.scala 132:12]
    io_releaseCan <= _io_releaseCan_T_2 @[VendingMachine.scala 133:17]
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_11) @[VendingMachine.scala 95:{25,25}]

  module SevenSegDec :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<4>
    output io_out : UInt<7>

    node _T = eq(UInt<1>("h0"), io_in) @[SevenSegDec.scala 13:17]
    node _T_1 = eq(UInt<1>("h1"), io_in) @[SevenSegDec.scala 13:17]
    node _T_2 = eq(UInt<2>("h2"), io_in) @[SevenSegDec.scala 13:17]
    node _T_3 = eq(UInt<2>("h3"), io_in) @[SevenSegDec.scala 13:17]
    node _T_4 = eq(UInt<3>("h4"), io_in) @[SevenSegDec.scala 13:17]
    node _T_5 = eq(UInt<3>("h5"), io_in) @[SevenSegDec.scala 13:17]
    node _T_6 = eq(UInt<3>("h6"), io_in) @[SevenSegDec.scala 13:17]
    node _T_7 = eq(UInt<3>("h7"), io_in) @[SevenSegDec.scala 13:17]
    node _T_8 = eq(UInt<4>("h8"), io_in) @[SevenSegDec.scala 13:17]
    node _T_9 = eq(UInt<4>("h9"), io_in) @[SevenSegDec.scala 13:17]
    node _T_10 = eq(UInt<4>("ha"), io_in) @[SevenSegDec.scala 13:17]
    node _T_11 = eq(UInt<4>("hb"), io_in) @[SevenSegDec.scala 13:17]
    node _T_12 = eq(UInt<4>("hc"), io_in) @[SevenSegDec.scala 13:17]
    node _T_13 = eq(UInt<4>("hd"), io_in) @[SevenSegDec.scala 13:17]
    node _T_14 = eq(UInt<4>("he"), io_in) @[SevenSegDec.scala 13:17]
    node _T_15 = eq(UInt<4>("hf"), io_in) @[SevenSegDec.scala 13:17]
    node _GEN_0 = mux(_T_15, UInt<7>("h71"), UInt<7>("h0")) @[SevenSegDec.scala 13:17 29:23 10:27]
    node _GEN_1 = mux(_T_14, UInt<7>("h79"), _GEN_0) @[SevenSegDec.scala 13:17 28:23]
    node _GEN_2 = mux(_T_13, UInt<7>("h5e"), _GEN_1) @[SevenSegDec.scala 13:17 27:23]
    node _GEN_3 = mux(_T_12, UInt<6>("h39"), _GEN_2) @[SevenSegDec.scala 13:17 26:23]
    node _GEN_4 = mux(_T_11, UInt<7>("h7c"), _GEN_3) @[SevenSegDec.scala 13:17 25:23]
    node _GEN_5 = mux(_T_10, UInt<7>("h77"), _GEN_4) @[SevenSegDec.scala 13:17 24:23]
    node _GEN_6 = mux(_T_9, UInt<7>("h67"), _GEN_5) @[SevenSegDec.scala 13:17 23:22]
    node _GEN_7 = mux(_T_8, UInt<7>("h7f"), _GEN_6) @[SevenSegDec.scala 13:17 22:22]
    node _GEN_8 = mux(_T_7, UInt<3>("h7"), _GEN_7) @[SevenSegDec.scala 13:17 21:22]
    node _GEN_9 = mux(_T_6, UInt<7>("h7d"), _GEN_8) @[SevenSegDec.scala 13:17 20:22]
    node _GEN_10 = mux(_T_5, UInt<7>("h6d"), _GEN_9) @[SevenSegDec.scala 13:17 19:22]
    node _GEN_11 = mux(_T_4, UInt<7>("h66"), _GEN_10) @[SevenSegDec.scala 13:17 18:22]
    node _GEN_12 = mux(_T_3, UInt<7>("h4f"), _GEN_11) @[SevenSegDec.scala 13:17 17:22]
    node _GEN_13 = mux(_T_2, UInt<7>("h5b"), _GEN_12) @[SevenSegDec.scala 13:17 16:22]
    node _GEN_14 = mux(_T_1, UInt<6>("h30"), _GEN_13) @[SevenSegDec.scala 13:17 15:22]
    node _GEN_15 = mux(_T, UInt<6>("h3f"), _GEN_14) @[SevenSegDec.scala 13:17 14:22]
    node sevSeg = _GEN_15 @[SevenSegDec.scala 10:27]
    node _io_out_T = not(sevSeg) @[SevenSegDec.scala 33:13]
    io_out <= _io_out_T @[SevenSegDec.scala 33:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : UInt<1>
    input io_sum : UInt<8>
    input io_price : UInt<8>
    output io_seg : UInt<7>
    output io_an : UInt<4>

    inst decoder of SevenSegDec @[DisplayMultiplexer.scala 17:23]
    reg select : UInt<4>, clock with :
      reset => (UInt<1>("h0"), select) @[DisplayMultiplexer.scala 13:23]
    reg tickCounterReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), tickCounterReg) @[DisplayMultiplexer.scala 21:32]
    node tick = eq(tickCounterReg, UInt<5>("h13")) @[DisplayMultiplexer.scala 22:29]
    node _tickCounterReg_T = add(tickCounterReg, UInt<1>("h1")) @[DisplayMultiplexer.scala 23:36]
    node _tickCounterReg_T_1 = tail(_tickCounterReg_T, 1) @[DisplayMultiplexer.scala 23:36]
    node _T = eq(UInt<1>("h1"), select) @[DisplayMultiplexer.scala 27:20]
    node _T_1 = eq(UInt<2>("h2"), select) @[DisplayMultiplexer.scala 27:20]
    node _T_2 = eq(UInt<3>("h4"), select) @[DisplayMultiplexer.scala 27:20]
    node _T_3 = eq(UInt<4>("h8"), select) @[DisplayMultiplexer.scala 27:20]
    node _GEN_0 = mux(_T_3, UInt<1>("h1"), select) @[DisplayMultiplexer.scala 27:20 13:23 31:29]
    node _GEN_1 = mux(_T_2, UInt<4>("h8"), _GEN_0) @[DisplayMultiplexer.scala 27:20 30:29]
    node _GEN_2 = mux(_T_1, UInt<3>("h4"), _GEN_1) @[DisplayMultiplexer.scala 27:20 29:29]
    node _GEN_3 = mux(_T, UInt<2>("h2"), _GEN_2) @[DisplayMultiplexer.scala 27:20 28:29]
    node _GEN_4 = mux(tick, UInt<1>("h0"), _tickCounterReg_T_1) @[DisplayMultiplexer.scala 25:15 23:18 26:20]
    node _GEN_5 = mux(tick, _GEN_3, select) @[DisplayMultiplexer.scala 25:15 13:23]
    node _T_4 = eq(UInt<1>("h1"), select) @[DisplayMultiplexer.scala 35:18]
    node _decoder_io_in_T = bits(io_price, 3, 0) @[DisplayMultiplexer.scala 36:45]
    node _T_5 = eq(UInt<2>("h2"), select) @[DisplayMultiplexer.scala 35:18]
    node _decoder_io_in_T_1 = bits(io_price, 7, 4) @[DisplayMultiplexer.scala 37:45]
    node _T_6 = eq(UInt<3>("h4"), select) @[DisplayMultiplexer.scala 35:18]
    node _decoder_io_in_T_2 = bits(io_sum, 3, 0) @[DisplayMultiplexer.scala 38:43]
    node _T_7 = eq(UInt<4>("h8"), select) @[DisplayMultiplexer.scala 35:18]
    node _decoder_io_in_T_3 = bits(io_sum, 7, 4) @[DisplayMultiplexer.scala 39:43]
    node _GEN_6 = mux(_T_7, _decoder_io_in_T_3, UInt<1>("h0")) @[DisplayMultiplexer.scala 18:17 35:18 39:34]
    node _GEN_7 = mux(_T_6, _decoder_io_in_T_2, _GEN_6) @[DisplayMultiplexer.scala 35:18 38:34]
    node _GEN_8 = mux(_T_5, _decoder_io_in_T_1, _GEN_7) @[DisplayMultiplexer.scala 35:18 37:34]
    node _GEN_9 = mux(_T_4, _decoder_io_in_T, _GEN_8) @[DisplayMultiplexer.scala 35:18 36:34]
    node _io_an_T = not(select) @[DisplayMultiplexer.scala 45:12]
    node sevSeg = decoder.io_out @[DisplayMultiplexer.scala 12:27 19:10]
    io_seg <= sevSeg @[DisplayMultiplexer.scala 44:10]
    io_an <= _io_an_T @[DisplayMultiplexer.scala 45:9]
    select <= mux(reset, UInt<4>("h1"), _GEN_5) @[DisplayMultiplexer.scala 13:{23,23}]
    decoder.clock <= clock
    decoder.reset <= reset
    decoder.io_in <= _GEN_9
    tickCounterReg <= mux(reset, UInt<32>("h0"), _GEN_4) @[DisplayMultiplexer.scala 21:{32,32}]

  module VendingMachine :
    input clock : Clock
    input reset : UInt<1>
    input io_price : UInt<5>
    input io_coin2 : UInt<1>
    input io_coin5 : UInt<1>
    input io_buy : UInt<1>
    output io_releaseCan : UInt<1>
    output io_alarm : UInt<1>
    output io_seg : UInt<7>
    output io_an : UInt<4>

    inst fsm of fsm @[VendingMachine.scala 26:19]
    inst dispMux of DisplayMultiplexer @[VendingMachine.scala 48:23]
    node _coin_T = or(io_coin2, io_coin5) @[VendingMachine.scala 34:20]
    reg sumReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), sumReg) @[VendingMachine.scala 38:23]
    node sub = fsm.io_sub @[VendingMachine.scala 21:24 28:7]
    node _T = eq(sub, UInt<1>("h0")) @[VendingMachine.scala 52:13]
    node add = fsm.io_add @[VendingMachine.scala 22:24 29:7]
    node _T_1 = eq(add, UInt<1>("h0")) @[VendingMachine.scala 52:32]
    node _T_2 = and(_T, _T_1) @[VendingMachine.scala 52:25]
    node _T_3 = eq(add, UInt<1>("h1")) @[VendingMachine.scala 54:18]
    node _T_5 = eq(io_coin2, UInt<1>("h1")) @[VendingMachine.scala 60:17]
    node _T_6 = eq(io_coin5, UInt<1>("h1")) @[VendingMachine.scala 62:24]
    node _GEN_3 = mux(_T_6, UInt<3>("h5"), UInt<1>("h0")) @[VendingMachine.scala 62:35 63:13 36:28]
    node _GEN_4 = mux(_T_5, UInt<2>("h2"), _GEN_3) @[VendingMachine.scala 60:28 61:13]
    node coinVal = _GEN_4 @[VendingMachine.scala 36:28]
    node _sumReg_T = add(sumReg, coinVal) @[VendingMachine.scala 55:22]
    node _sumReg_T_1 = tail(_sumReg_T, 1) @[VendingMachine.scala 55:22]
    node _T_4 = eq(sub, UInt<1>("h1")) @[VendingMachine.scala 56:18]
    node _sumReg_T_2 = sub(sumReg, io_price) @[VendingMachine.scala 57:22]
    node _sumReg_T_3 = tail(_sumReg_T_2, 1) @[VendingMachine.scala 57:22]
    node _GEN_0 = mux(_T_4, _sumReg_T_3, sumReg) @[VendingMachine.scala 56:30 57:12 38:23]
    node _GEN_1 = mux(_T_3, _sumReg_T_1, _GEN_0) @[VendingMachine.scala 54:29 55:12]
    node _GEN_2 = mux(_T_2, sumReg, _GEN_1) @[VendingMachine.scala 52:45 53:12]
    node alarm = fsm.io_alarm @[VendingMachine.scala 23:26 30:9]
    node releaseCan = fsm.io_releaseCan @[VendingMachine.scala 24:31 31:14]
    node coin = _coin_T @[VendingMachine.scala 33:25 34:8]
    io_releaseCan <= releaseCan @[VendingMachine.scala 67:17]
    io_alarm <= alarm @[VendingMachine.scala 66:12]
    io_seg <= dispMux.io_seg @[VendingMachine.scala 68:10]
    io_an <= dispMux.io_an @[VendingMachine.scala 69:9]
    fsm.clock <= clock
    fsm.reset <= reset
    fsm.io_price <= io_price @[VendingMachine.scala 41:16]
    fsm.io_sum <= sumReg @[VendingMachine.scala 42:14]
    fsm.io_buy <= io_buy @[VendingMachine.scala 43:14]
    fsm.io_coin <= coin @[VendingMachine.scala 44:15]
    sumReg <= mux(reset, UInt<8>("h0"), _GEN_2) @[VendingMachine.scala 38:{23,23}]
    dispMux.clock <= clock
    dispMux.reset <= reset
    dispMux.io_sum <= sumReg @[VendingMachine.scala 50:18]
    dispMux.io_price <= pad(io_price, 8) @[VendingMachine.scala 49:20]
