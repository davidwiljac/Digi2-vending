FIRRTL version 1.1.0
circuit VendingMachine :
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
    node _T_10 = eq(io_countReg, UInt<6>("h3a")) @[Debouncer.scala 60:29]
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

  module dataPath :
    input clock : Clock
    input reset : UInt<1>
    input io_price : UInt<5>
    input io_coin2 : UInt<1>
    input io_coin5 : UInt<1>
    input io_sub : UInt<1>
    input io_add : UInt<1>
    output io_sum : UInt<7>
    output io_coin : UInt<1>
    output io_customOut_0 : UInt<7>
    output io_customOut_1 : UInt<7>
    output io_customOut_2 : UInt<7>
    output io_customOut_3 : UInt<7>

    reg sumReg : UInt<7>, clock with :
      reset => (UInt<1>("h0"), sumReg) @[VendingMachine.scala 95:23]
    reg numCanReg : UInt<8>, clock with :
      reset => (UInt<1>("h0"), numCanReg) @[VendingMachine.scala 97:26]
    node _T = eq(io_coin2, UInt<1>("h1")) @[VendingMachine.scala 99:17]
    node _T_1 = eq(io_coin5, UInt<1>("h1")) @[VendingMachine.scala 101:24]
    node _GEN_0 = mux(_T_1, UInt<3>("h5"), UInt<1>("h0")) @[VendingMachine.scala 101:35 102:13 92:28]
    node _GEN_1 = mux(_T, UInt<2>("h2"), _GEN_0) @[VendingMachine.scala 100:13 99:28]
    node _T_2 = eq(io_sub, UInt<1>("h0")) @[VendingMachine.scala 106:16]
    node _T_3 = eq(io_add, UInt<1>("h0")) @[VendingMachine.scala 106:38]
    node _T_4 = and(_T_2, _T_3) @[VendingMachine.scala 106:28]
    node _T_5 = eq(io_add, UInt<1>("h1")) @[VendingMachine.scala 108:21]
    node coinVal = _GEN_1 @[VendingMachine.scala 92:28]
    node _sumReg_T = add(sumReg, coinVal) @[VendingMachine.scala 109:22]
    node _sumReg_T_1 = tail(_sumReg_T, 1) @[VendingMachine.scala 109:22]
    node _T_6 = eq(io_sub, UInt<1>("h1")) @[VendingMachine.scala 110:21]
    node _sumReg_T_2 = sub(sumReg, io_price) @[VendingMachine.scala 111:22]
    node _sumReg_T_3 = tail(_sumReg_T_2, 1) @[VendingMachine.scala 111:22]
    node _numCanReg_T = sub(numCanReg, UInt<1>("h1")) @[VendingMachine.scala 112:28]
    node _numCanReg_T_1 = tail(_numCanReg_T, 1) @[VendingMachine.scala 112:28]
    node _GEN_2 = mux(_T_6, _sumReg_T_3, sumReg) @[VendingMachine.scala 110:33 111:12 95:23]
    node _GEN_3 = mux(_T_6, _numCanReg_T_1, numCanReg) @[VendingMachine.scala 110:33 112:15 97:26]
    node _GEN_4 = mux(_T_5, _sumReg_T_1, _GEN_2) @[VendingMachine.scala 108:32 109:12]
    node _GEN_5 = mux(_T_5, numCanReg, _GEN_3) @[VendingMachine.scala 108:32 97:26]
    node _GEN_6 = mux(_T_4, sumReg, _GEN_4) @[VendingMachine.scala 106:51 107:12]
    node _GEN_7 = mux(_T_4, numCanReg, _GEN_5) @[VendingMachine.scala 106:51 97:26]
    node _T_7 = eq(numCanReg, UInt<1>("h0")) @[VendingMachine.scala 114:18]
    reg scrollReg : UInt<23>, clock with :
      reset => (UInt<1>("h0"), scrollReg) @[VendingMachine.scala 115:28]
    reg selector1 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), selector1) @[VendingMachine.scala 116:28]
    reg selector2 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), selector2) @[VendingMachine.scala 117:28]
    reg selector3 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), selector3) @[VendingMachine.scala 118:28]
    reg selector4 : UInt<3>, clock with :
      reset => (UInt<1>("h0"), selector4) @[VendingMachine.scala 119:28]
    node _scrollReg_T = add(scrollReg, UInt<1>("h1")) @[VendingMachine.scala 120:28]
    node _scrollReg_T_1 = tail(_scrollReg_T, 1) @[VendingMachine.scala 120:28]
    node _T_8 = eq(scrollReg, UInt<1>("h0")) @[VendingMachine.scala 121:20]
    node _selector1_T = add(selector1, UInt<1>("h1")) @[VendingMachine.scala 122:30]
    node _selector1_T_1 = tail(_selector1_T, 1) @[VendingMachine.scala 122:30]
    node _selector2_T = add(selector2, UInt<1>("h1")) @[VendingMachine.scala 123:30]
    node _selector2_T_1 = tail(_selector2_T, 1) @[VendingMachine.scala 123:30]
    node _selector3_T = add(selector3, UInt<1>("h1")) @[VendingMachine.scala 124:30]
    node _selector3_T_1 = tail(_selector3_T, 1) @[VendingMachine.scala 124:30]
    node _selector4_T = add(selector4, UInt<1>("h1")) @[VendingMachine.scala 125:30]
    node _selector4_T_1 = tail(_selector4_T, 1) @[VendingMachine.scala 125:30]
    node _T_9 = eq(selector1, UInt<3>("h6")) @[VendingMachine.scala 126:22]
    node _GEN_8 = mux(_T_9, UInt<1>("h0"), _selector1_T_1) @[VendingMachine.scala 122:17 126:{30,41}]
    node _T_10 = eq(selector2, UInt<3>("h6")) @[VendingMachine.scala 127:22]
    node _GEN_9 = mux(_T_10, UInt<1>("h0"), _selector2_T_1) @[VendingMachine.scala 123:17 127:{30,41}]
    node _T_11 = eq(selector3, UInt<3>("h6")) @[VendingMachine.scala 128:22]
    node _GEN_10 = mux(_T_11, UInt<1>("h0"), _selector3_T_1) @[VendingMachine.scala 124:17 128:{30,41}]
    node _T_12 = eq(selector4, UInt<3>("h6")) @[VendingMachine.scala 129:22]
    node _GEN_11 = mux(_T_12, UInt<1>("h0"), _selector4_T_1) @[VendingMachine.scala 125:17 129:{30,41}]
    node _GEN_12 = mux(_T_8, _GEN_8, selector1) @[VendingMachine.scala 116:28 121:28]
    node _GEN_13 = mux(_T_8, _GEN_9, selector2) @[VendingMachine.scala 117:28 121:28]
    node _GEN_14 = mux(_T_8, _GEN_10, selector3) @[VendingMachine.scala 118:28 121:28]
    node _GEN_15 = mux(_T_8, _GEN_11, selector4) @[VendingMachine.scala 119:28 121:28]
    node word_0 = UInt<7>("h79") @[VendingMachine.scala 133:{23,23}]
    node _GEN_16 = validif(eq(UInt<1>("h0"), selector1), word_0) @[VendingMachine.scala 134:{21,21}]
    node word_1 = UInt<7>("h73") @[VendingMachine.scala 133:{23,23}]
    node _GEN_17 = mux(eq(UInt<1>("h1"), selector1), word_1, _GEN_16) @[VendingMachine.scala 134:{21,21}]
    node word_2 = UInt<7>("h78") @[VendingMachine.scala 133:{23,23}]
    node _GEN_18 = mux(eq(UInt<2>("h2"), selector1), word_2, _GEN_17) @[VendingMachine.scala 134:{21,21}]
    node word_3 = UInt<7>("h6e") @[VendingMachine.scala 133:{23,23}]
    node _GEN_19 = mux(eq(UInt<2>("h3"), selector1), word_3, _GEN_18) @[VendingMachine.scala 134:{21,21}]
    node word_4 = UInt<7>("h7f") @[VendingMachine.scala 133:{23,23}]
    node _GEN_20 = mux(eq(UInt<3>("h4"), selector1), word_4, _GEN_19) @[VendingMachine.scala 134:{21,21}]
    node _GEN_21 = validif(eq(UInt<1>("h0"), selector2), word_0) @[VendingMachine.scala 135:{21,21}]
    node _GEN_22 = mux(eq(UInt<1>("h1"), selector2), word_1, _GEN_21) @[VendingMachine.scala 135:{21,21}]
    node _GEN_23 = mux(eq(UInt<2>("h2"), selector2), word_2, _GEN_22) @[VendingMachine.scala 135:{21,21}]
    node _GEN_24 = mux(eq(UInt<2>("h3"), selector2), word_3, _GEN_23) @[VendingMachine.scala 135:{21,21}]
    node _GEN_25 = mux(eq(UInt<3>("h4"), selector2), word_4, _GEN_24) @[VendingMachine.scala 135:{21,21}]
    node _GEN_26 = validif(eq(UInt<1>("h0"), selector3), word_0) @[VendingMachine.scala 136:{21,21}]
    node _GEN_27 = mux(eq(UInt<1>("h1"), selector3), word_1, _GEN_26) @[VendingMachine.scala 136:{21,21}]
    node _GEN_28 = mux(eq(UInt<2>("h2"), selector3), word_2, _GEN_27) @[VendingMachine.scala 136:{21,21}]
    node _GEN_29 = mux(eq(UInt<2>("h3"), selector3), word_3, _GEN_28) @[VendingMachine.scala 136:{21,21}]
    node _GEN_30 = mux(eq(UInt<3>("h4"), selector3), word_4, _GEN_29) @[VendingMachine.scala 136:{21,21}]
    node _GEN_31 = validif(eq(UInt<1>("h0"), selector4), word_0) @[VendingMachine.scala 137:{21,21}]
    node _GEN_32 = mux(eq(UInt<1>("h1"), selector4), word_1, _GEN_31) @[VendingMachine.scala 137:{21,21}]
    node _GEN_33 = mux(eq(UInt<2>("h2"), selector4), word_2, _GEN_32) @[VendingMachine.scala 137:{21,21}]
    node _GEN_34 = mux(eq(UInt<2>("h3"), selector4), word_3, _GEN_33) @[VendingMachine.scala 137:{21,21}]
    node _GEN_35 = mux(eq(UInt<3>("h4"), selector4), word_4, _GEN_34) @[VendingMachine.scala 137:{21,21}]
    node _word_selector1 = _GEN_20 @[VendingMachine.scala 134:21]
    node _GEN_36 = mux(_T_7, _word_selector1, UInt<1>("h0")) @[VendingMachine.scala 114:26 134:21 89:21]
    node _word_selector2 = _GEN_25 @[VendingMachine.scala 135:21]
    node _GEN_37 = mux(_T_7, _word_selector2, UInt<1>("h0")) @[VendingMachine.scala 114:26 135:21 89:21]
    node _word_selector3 = _GEN_30 @[VendingMachine.scala 136:21]
    node _GEN_38 = mux(_T_7, _word_selector3, UInt<1>("h0")) @[VendingMachine.scala 114:26 136:21 89:21]
    node _word_selector4 = _GEN_35 @[VendingMachine.scala 137:21]
    node _GEN_39 = mux(_T_7, _word_selector4, UInt<1>("h0")) @[VendingMachine.scala 114:26 137:21 89:21]
    node _io_coin_T = or(io_coin2, io_coin5) @[VendingMachine.scala 148:24]
    io_sum <= sumReg @[VendingMachine.scala 147:10]
    io_coin <= _io_coin_T @[VendingMachine.scala 148:11]
    io_customOut_0 <= _GEN_39
    io_customOut_1 <= _GEN_38
    io_customOut_2 <= _GEN_37
    io_customOut_3 <= _GEN_36
    sumReg <= mux(reset, UInt<7>("h0"), _GEN_6) @[VendingMachine.scala 95:{23,23}]
    numCanReg <= mux(reset, UInt<8>("h3"), _GEN_7) @[VendingMachine.scala 97:{26,26}]
    scrollReg <= mux(reset, UInt<23>("h0"), _scrollReg_T_1) @[VendingMachine.scala 115:{28,28} 120:15]
    selector1 <= mux(reset, UInt<3>("h0"), _GEN_12) @[VendingMachine.scala 116:{28,28}]
    selector2 <= mux(reset, UInt<3>("h1"), _GEN_13) @[VendingMachine.scala 117:{28,28}]
    selector3 <= mux(reset, UInt<3>("h2"), _GEN_14) @[VendingMachine.scala 118:{28,28}]
    selector4 <= mux(reset, UInt<3>("h3"), _GEN_15) @[VendingMachine.scala 119:{28,28}]

  module fsm :
    input clock : Clock
    input reset : UInt<1>
    input io_price : UInt<5>
    input io_sum : UInt<8>
    input io_buy : UInt<1>
    input io_coin : UInt<1>
    input io_empty : UInt<1>
    output io_sub : UInt<1>
    output io_add : UInt<1>
    output io_alarm : UInt<1>
    output io_releaseCan : UInt<1>

    reg stateReg : UInt<3>, clock with :
      reset => (UInt<1>("h0"), stateReg) @[VendingMachine.scala 173:25]
    node _T = asUInt(UInt<1>("h0")) @[VendingMachine.scala 176:19]
    node _T_1 = asUInt(stateReg) @[VendingMachine.scala 176:19]
    node _T_2 = eq(_T, _T_1) @[VendingMachine.scala 176:19]
    node _T_3 = geq(io_sum, io_price) @[VendingMachine.scala 178:29]
    node _T_4 = and(io_buy, _T_3) @[VendingMachine.scala 178:19]
    node _T_5 = lt(io_sum, io_price) @[VendingMachine.scala 180:36]
    node _T_6 = and(io_buy, _T_5) @[VendingMachine.scala 180:26]
    node _GEN_0 = mux(io_empty, UInt<3>("h6"), stateReg) @[VendingMachine.scala 184:28 185:18 173:25]
    node _GEN_1 = mux(io_coin, UInt<3>("h4"), _GEN_0) @[VendingMachine.scala 182:26 183:18]
    node _GEN_2 = mux(_T_6, UInt<2>("h3"), _GEN_1) @[VendingMachine.scala 180:47 181:18]
    node _GEN_3 = mux(_T_4, UInt<1>("h1"), _GEN_2) @[VendingMachine.scala 178:41 179:18]
    node _T_7 = asUInt(UInt<1>("h1")) @[VendingMachine.scala 176:19]
    node _T_8 = asUInt(stateReg) @[VendingMachine.scala 176:19]
    node _T_9 = eq(_T_7, _T_8) @[VendingMachine.scala 176:19]
    node _T_10 = asUInt(UInt<2>("h2")) @[VendingMachine.scala 176:19]
    node _T_11 = asUInt(stateReg) @[VendingMachine.scala 176:19]
    node _T_12 = eq(_T_10, _T_11) @[VendingMachine.scala 176:19]
    node _T_13 = eq(io_buy, UInt<1>("h0")) @[VendingMachine.scala 192:19]
    node _GEN_4 = mux(_T_13, UInt<1>("h0"), stateReg) @[VendingMachine.scala 192:31 193:17 173:25]
    node _T_14 = asUInt(UInt<2>("h3")) @[VendingMachine.scala 176:19]
    node _T_15 = asUInt(stateReg) @[VendingMachine.scala 176:19]
    node _T_16 = eq(_T_14, _T_15) @[VendingMachine.scala 176:19]
    node _T_17 = eq(io_buy, UInt<1>("h0")) @[VendingMachine.scala 197:19]
    node _GEN_5 = mux(_T_17, UInt<1>("h0"), stateReg) @[VendingMachine.scala 197:31 198:17 173:25]
    node _T_18 = asUInt(UInt<3>("h4")) @[VendingMachine.scala 176:19]
    node _T_19 = asUInt(stateReg) @[VendingMachine.scala 176:19]
    node _T_20 = eq(_T_18, _T_19) @[VendingMachine.scala 176:19]
    node _T_21 = asUInt(UInt<3>("h5")) @[VendingMachine.scala 176:19]
    node _T_22 = asUInt(stateReg) @[VendingMachine.scala 176:19]
    node _T_23 = eq(_T_21, _T_22) @[VendingMachine.scala 176:19]
    node _T_24 = eq(io_coin, UInt<1>("h0")) @[VendingMachine.scala 205:20]
    node _GEN_6 = mux(_T_24, UInt<1>("h0"), stateReg) @[VendingMachine.scala 205:32 206:17 173:25]
    node _T_25 = asUInt(UInt<3>("h6")) @[VendingMachine.scala 176:19]
    node _T_26 = asUInt(stateReg) @[VendingMachine.scala 176:19]
    node _T_27 = eq(_T_25, _T_26) @[VendingMachine.scala 176:19]
    node _GEN_7 = mux(_T_23, _GEN_6, stateReg) @[VendingMachine.scala 176:19 173:25]
    node _GEN_8 = mux(_T_20, UInt<3>("h5"), _GEN_7) @[VendingMachine.scala 176:19 202:16]
    node _GEN_9 = mux(_T_16, _GEN_5, _GEN_8) @[VendingMachine.scala 176:19]
    node _GEN_10 = mux(_T_12, _GEN_4, _GEN_9) @[VendingMachine.scala 176:19]
    node _GEN_11 = mux(_T_9, UInt<2>("h2"), _GEN_10) @[VendingMachine.scala 176:19 189:15]
    node _GEN_12 = mux(_T_2, _GEN_3, _GEN_11) @[VendingMachine.scala 176:19]
    node _io_sub_T = eq(stateReg, UInt<1>("h1")) @[VendingMachine.scala 215:21]
    node _io_add_T = eq(stateReg, UInt<3>("h4")) @[VendingMachine.scala 216:22]
    node _io_alarm_T = eq(stateReg, UInt<2>("h3")) @[VendingMachine.scala 217:24]
    node _io_releaseCan_T = eq(stateReg, UInt<2>("h2")) @[VendingMachine.scala 218:30]
    node _io_releaseCan_T_1 = eq(stateReg, UInt<1>("h1")) @[VendingMachine.scala 218:54]
    node _io_releaseCan_T_2 = or(_io_releaseCan_T, _io_releaseCan_T_1) @[VendingMachine.scala 218:42]
    io_sub <= _io_sub_T @[VendingMachine.scala 215:9]
    io_add <= _io_add_T @[VendingMachine.scala 216:10]
    io_alarm <= _io_alarm_T @[VendingMachine.scala 217:12]
    io_releaseCan <= _io_releaseCan_T_2 @[VendingMachine.scala 218:17]
    stateReg <= mux(reset, UInt<1>("h0"), _GEN_12) @[VendingMachine.scala 173:{25,25}]

  module BcdTable :
    input clock : Clock
    input reset : UInt<1>
    input io_address : UInt<8>
    output io_data : UInt<8>

    node _io_data_T = bits(io_address, 6, 0)
    node table_0 = UInt<8>("h0") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_0 = validif(eq(UInt<1>("h0"), _io_data_T), table_0) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_1 = UInt<8>("h1") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_1 = mux(eq(UInt<1>("h1"), _io_data_T), table_1, _GEN_0) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_2 = UInt<8>("h2") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_2 = mux(eq(UInt<2>("h2"), _io_data_T), table_2, _GEN_1) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_3 = UInt<8>("h3") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_3 = mux(eq(UInt<2>("h3"), _io_data_T), table_3, _GEN_2) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_4 = UInt<8>("h4") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_4 = mux(eq(UInt<3>("h4"), _io_data_T), table_4, _GEN_3) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_5 = UInt<8>("h5") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_5 = mux(eq(UInt<3>("h5"), _io_data_T), table_5, _GEN_4) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_6 = UInt<8>("h6") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_6 = mux(eq(UInt<3>("h6"), _io_data_T), table_6, _GEN_5) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_7 = UInt<8>("h7") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_7 = mux(eq(UInt<3>("h7"), _io_data_T), table_7, _GEN_6) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_8 = UInt<8>("h8") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_8 = mux(eq(UInt<4>("h8"), _io_data_T), table_8, _GEN_7) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_9 = UInt<8>("h9") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_9 = mux(eq(UInt<4>("h9"), _io_data_T), table_9, _GEN_8) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_10 = UInt<8>("h10") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_10 = mux(eq(UInt<4>("ha"), _io_data_T), table_10, _GEN_9) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_11 = UInt<8>("h11") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_11 = mux(eq(UInt<4>("hb"), _io_data_T), table_11, _GEN_10) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_12 = UInt<8>("h12") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_12 = mux(eq(UInt<4>("hc"), _io_data_T), table_12, _GEN_11) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_13 = UInt<8>("h13") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_13 = mux(eq(UInt<4>("hd"), _io_data_T), table_13, _GEN_12) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_14 = UInt<8>("h14") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_14 = mux(eq(UInt<4>("he"), _io_data_T), table_14, _GEN_13) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_15 = UInt<8>("h15") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_15 = mux(eq(UInt<4>("hf"), _io_data_T), table_15, _GEN_14) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_16 = UInt<8>("h16") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_16 = mux(eq(UInt<5>("h10"), _io_data_T), table_16, _GEN_15) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_17 = UInt<8>("h17") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_17 = mux(eq(UInt<5>("h11"), _io_data_T), table_17, _GEN_16) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_18 = UInt<8>("h18") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_18 = mux(eq(UInt<5>("h12"), _io_data_T), table_18, _GEN_17) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_19 = UInt<8>("h19") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_19 = mux(eq(UInt<5>("h13"), _io_data_T), table_19, _GEN_18) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_20 = UInt<8>("h20") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_20 = mux(eq(UInt<5>("h14"), _io_data_T), table_20, _GEN_19) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_21 = UInt<8>("h21") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_21 = mux(eq(UInt<5>("h15"), _io_data_T), table_21, _GEN_20) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_22 = UInt<8>("h22") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_22 = mux(eq(UInt<5>("h16"), _io_data_T), table_22, _GEN_21) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_23 = UInt<8>("h23") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_23 = mux(eq(UInt<5>("h17"), _io_data_T), table_23, _GEN_22) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_24 = UInt<8>("h24") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_24 = mux(eq(UInt<5>("h18"), _io_data_T), table_24, _GEN_23) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_25 = UInt<8>("h25") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_25 = mux(eq(UInt<5>("h19"), _io_data_T), table_25, _GEN_24) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_26 = UInt<8>("h26") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), _io_data_T), table_26, _GEN_25) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_27 = UInt<8>("h27") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), _io_data_T), table_27, _GEN_26) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_28 = UInt<8>("h28") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), _io_data_T), table_28, _GEN_27) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_29 = UInt<8>("h29") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), _io_data_T), table_29, _GEN_28) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_30 = UInt<8>("h30") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), _io_data_T), table_30, _GEN_29) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_31 = UInt<8>("h31") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), _io_data_T), table_31, _GEN_30) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_32 = UInt<8>("h32") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_32 = mux(eq(UInt<6>("h20"), _io_data_T), table_32, _GEN_31) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_33 = UInt<8>("h33") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_33 = mux(eq(UInt<6>("h21"), _io_data_T), table_33, _GEN_32) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_34 = UInt<8>("h34") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_34 = mux(eq(UInt<6>("h22"), _io_data_T), table_34, _GEN_33) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_35 = UInt<8>("h35") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_35 = mux(eq(UInt<6>("h23"), _io_data_T), table_35, _GEN_34) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_36 = UInt<8>("h36") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_36 = mux(eq(UInt<6>("h24"), _io_data_T), table_36, _GEN_35) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_37 = UInt<8>("h37") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_37 = mux(eq(UInt<6>("h25"), _io_data_T), table_37, _GEN_36) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_38 = UInt<8>("h38") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_38 = mux(eq(UInt<6>("h26"), _io_data_T), table_38, _GEN_37) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_39 = UInt<8>("h39") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_39 = mux(eq(UInt<6>("h27"), _io_data_T), table_39, _GEN_38) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_40 = UInt<8>("h40") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_40 = mux(eq(UInt<6>("h28"), _io_data_T), table_40, _GEN_39) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_41 = UInt<8>("h41") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_41 = mux(eq(UInt<6>("h29"), _io_data_T), table_41, _GEN_40) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_42 = UInt<8>("h42") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_42 = mux(eq(UInt<6>("h2a"), _io_data_T), table_42, _GEN_41) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_43 = UInt<8>("h43") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_43 = mux(eq(UInt<6>("h2b"), _io_data_T), table_43, _GEN_42) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_44 = UInt<8>("h44") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_44 = mux(eq(UInt<6>("h2c"), _io_data_T), table_44, _GEN_43) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_45 = UInt<8>("h45") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_45 = mux(eq(UInt<6>("h2d"), _io_data_T), table_45, _GEN_44) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_46 = UInt<8>("h46") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_46 = mux(eq(UInt<6>("h2e"), _io_data_T), table_46, _GEN_45) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_47 = UInt<8>("h47") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_47 = mux(eq(UInt<6>("h2f"), _io_data_T), table_47, _GEN_46) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_48 = UInt<8>("h48") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_48 = mux(eq(UInt<6>("h30"), _io_data_T), table_48, _GEN_47) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_49 = UInt<8>("h49") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_49 = mux(eq(UInt<6>("h31"), _io_data_T), table_49, _GEN_48) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_50 = UInt<8>("h50") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_50 = mux(eq(UInt<6>("h32"), _io_data_T), table_50, _GEN_49) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_51 = UInt<8>("h51") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_51 = mux(eq(UInt<6>("h33"), _io_data_T), table_51, _GEN_50) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_52 = UInt<8>("h52") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_52 = mux(eq(UInt<6>("h34"), _io_data_T), table_52, _GEN_51) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_53 = UInt<8>("h53") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_53 = mux(eq(UInt<6>("h35"), _io_data_T), table_53, _GEN_52) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_54 = UInt<8>("h54") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_54 = mux(eq(UInt<6>("h36"), _io_data_T), table_54, _GEN_53) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_55 = UInt<8>("h55") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_55 = mux(eq(UInt<6>("h37"), _io_data_T), table_55, _GEN_54) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_56 = UInt<8>("h56") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_56 = mux(eq(UInt<6>("h38"), _io_data_T), table_56, _GEN_55) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_57 = UInt<8>("h57") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_57 = mux(eq(UInt<6>("h39"), _io_data_T), table_57, _GEN_56) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_58 = UInt<8>("h58") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_58 = mux(eq(UInt<6>("h3a"), _io_data_T), table_58, _GEN_57) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_59 = UInt<8>("h59") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_59 = mux(eq(UInt<6>("h3b"), _io_data_T), table_59, _GEN_58) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_60 = UInt<8>("h60") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_60 = mux(eq(UInt<6>("h3c"), _io_data_T), table_60, _GEN_59) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_61 = UInt<8>("h61") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_61 = mux(eq(UInt<6>("h3d"), _io_data_T), table_61, _GEN_60) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_62 = UInt<8>("h62") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_62 = mux(eq(UInt<6>("h3e"), _io_data_T), table_62, _GEN_61) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_63 = UInt<8>("h63") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_63 = mux(eq(UInt<6>("h3f"), _io_data_T), table_63, _GEN_62) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_64 = UInt<8>("h64") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_64 = mux(eq(UInt<7>("h40"), _io_data_T), table_64, _GEN_63) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_65 = UInt<8>("h65") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_65 = mux(eq(UInt<7>("h41"), _io_data_T), table_65, _GEN_64) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_66 = UInt<8>("h66") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_66 = mux(eq(UInt<7>("h42"), _io_data_T), table_66, _GEN_65) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_67 = UInt<8>("h67") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_67 = mux(eq(UInt<7>("h43"), _io_data_T), table_67, _GEN_66) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_68 = UInt<8>("h68") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_68 = mux(eq(UInt<7>("h44"), _io_data_T), table_68, _GEN_67) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_69 = UInt<8>("h69") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_69 = mux(eq(UInt<7>("h45"), _io_data_T), table_69, _GEN_68) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_70 = UInt<8>("h70") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_70 = mux(eq(UInt<7>("h46"), _io_data_T), table_70, _GEN_69) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_71 = UInt<8>("h71") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_71 = mux(eq(UInt<7>("h47"), _io_data_T), table_71, _GEN_70) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_72 = UInt<8>("h72") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_72 = mux(eq(UInt<7>("h48"), _io_data_T), table_72, _GEN_71) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_73 = UInt<8>("h73") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_73 = mux(eq(UInt<7>("h49"), _io_data_T), table_73, _GEN_72) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_74 = UInt<8>("h74") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_74 = mux(eq(UInt<7>("h4a"), _io_data_T), table_74, _GEN_73) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_75 = UInt<8>("h75") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_75 = mux(eq(UInt<7>("h4b"), _io_data_T), table_75, _GEN_74) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_76 = UInt<8>("h76") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_76 = mux(eq(UInt<7>("h4c"), _io_data_T), table_76, _GEN_75) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_77 = UInt<8>("h77") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_77 = mux(eq(UInt<7>("h4d"), _io_data_T), table_77, _GEN_76) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_78 = UInt<8>("h78") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_78 = mux(eq(UInt<7>("h4e"), _io_data_T), table_78, _GEN_77) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_79 = UInt<8>("h79") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_79 = mux(eq(UInt<7>("h4f"), _io_data_T), table_79, _GEN_78) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_80 = UInt<8>("h80") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_80 = mux(eq(UInt<7>("h50"), _io_data_T), table_80, _GEN_79) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_81 = UInt<8>("h81") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_81 = mux(eq(UInt<7>("h51"), _io_data_T), table_81, _GEN_80) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_82 = UInt<8>("h82") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_82 = mux(eq(UInt<7>("h52"), _io_data_T), table_82, _GEN_81) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_83 = UInt<8>("h83") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_83 = mux(eq(UInt<7>("h53"), _io_data_T), table_83, _GEN_82) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_84 = UInt<8>("h84") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_84 = mux(eq(UInt<7>("h54"), _io_data_T), table_84, _GEN_83) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_85 = UInt<8>("h85") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_85 = mux(eq(UInt<7>("h55"), _io_data_T), table_85, _GEN_84) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_86 = UInt<8>("h86") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_86 = mux(eq(UInt<7>("h56"), _io_data_T), table_86, _GEN_85) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_87 = UInt<8>("h87") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_87 = mux(eq(UInt<7>("h57"), _io_data_T), table_87, _GEN_86) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_88 = UInt<8>("h88") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_88 = mux(eq(UInt<7>("h58"), _io_data_T), table_88, _GEN_87) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_89 = UInt<8>("h89") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_89 = mux(eq(UInt<7>("h59"), _io_data_T), table_89, _GEN_88) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_90 = UInt<8>("h90") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_90 = mux(eq(UInt<7>("h5a"), _io_data_T), table_90, _GEN_89) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_91 = UInt<8>("h91") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_91 = mux(eq(UInt<7>("h5b"), _io_data_T), table_91, _GEN_90) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_92 = UInt<8>("h92") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_92 = mux(eq(UInt<7>("h5c"), _io_data_T), table_92, _GEN_91) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_93 = UInt<8>("h93") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_93 = mux(eq(UInt<7>("h5d"), _io_data_T), table_93, _GEN_92) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_94 = UInt<8>("h94") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_94 = mux(eq(UInt<7>("h5e"), _io_data_T), table_94, _GEN_93) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_95 = UInt<8>("h95") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_95 = mux(eq(UInt<7>("h5f"), _io_data_T), table_95, _GEN_94) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_96 = UInt<8>("h96") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_96 = mux(eq(UInt<7>("h60"), _io_data_T), table_96, _GEN_95) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_97 = UInt<8>("h97") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_97 = mux(eq(UInt<7>("h61"), _io_data_T), table_97, _GEN_96) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_98 = UInt<8>("h98") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_98 = mux(eq(UInt<7>("h62"), _io_data_T), table_98, _GEN_97) @[DisplayMultiplexer.scala 78:{11,11}]
    node table_99 = UInt<8>("h99") @[DisplayMultiplexer.scala 71:19 75:14]
    node _GEN_99 = mux(eq(UInt<7>("h63"), _io_data_T), table_99, _GEN_98) @[DisplayMultiplexer.scala 78:{11,11}]
    node _table_io_data_T = _GEN_99 @[DisplayMultiplexer.scala 78:11]
    io_data <= _table_io_data_T @[DisplayMultiplexer.scala 78:11]

  module SevenSegDec :
    input clock : Clock
    input reset : UInt<1>
    input io_in : UInt<4>
    output io_out : UInt<7>
    input io_custom : UInt<1>
    input io_customIn : UInt<7>

    node _T = eq(UInt<1>("h0"), io_in) @[SevenSegDec.scala 15:17]
    node _T_1 = eq(UInt<1>("h1"), io_in) @[SevenSegDec.scala 15:17]
    node _T_2 = eq(UInt<2>("h2"), io_in) @[SevenSegDec.scala 15:17]
    node _T_3 = eq(UInt<2>("h3"), io_in) @[SevenSegDec.scala 15:17]
    node _T_4 = eq(UInt<3>("h4"), io_in) @[SevenSegDec.scala 15:17]
    node _T_5 = eq(UInt<3>("h5"), io_in) @[SevenSegDec.scala 15:17]
    node _T_6 = eq(UInt<3>("h6"), io_in) @[SevenSegDec.scala 15:17]
    node _T_7 = eq(UInt<3>("h7"), io_in) @[SevenSegDec.scala 15:17]
    node _T_8 = eq(UInt<4>("h8"), io_in) @[SevenSegDec.scala 15:17]
    node _T_9 = eq(UInt<4>("h9"), io_in) @[SevenSegDec.scala 15:17]
    node _T_10 = eq(UInt<4>("ha"), io_in) @[SevenSegDec.scala 15:17]
    node _T_11 = eq(UInt<4>("hb"), io_in) @[SevenSegDec.scala 15:17]
    node _T_12 = eq(UInt<4>("hc"), io_in) @[SevenSegDec.scala 15:17]
    node _T_13 = eq(UInt<4>("hd"), io_in) @[SevenSegDec.scala 15:17]
    node _T_14 = eq(UInt<4>("he"), io_in) @[SevenSegDec.scala 15:17]
    node _T_15 = eq(UInt<4>("hf"), io_in) @[SevenSegDec.scala 15:17]
    node _GEN_0 = mux(_T_15, UInt<7>("h71"), UInt<7>("h0")) @[SevenSegDec.scala 15:17 31:23 12:27]
    node _GEN_1 = mux(_T_14, UInt<7>("h79"), _GEN_0) @[SevenSegDec.scala 15:17 30:23]
    node _GEN_2 = mux(_T_13, UInt<7>("h5e"), _GEN_1) @[SevenSegDec.scala 15:17 29:23]
    node _GEN_3 = mux(_T_12, UInt<6>("h39"), _GEN_2) @[SevenSegDec.scala 15:17 28:23]
    node _GEN_4 = mux(_T_11, UInt<7>("h7c"), _GEN_3) @[SevenSegDec.scala 15:17 27:23]
    node _GEN_5 = mux(_T_10, UInt<7>("h77"), _GEN_4) @[SevenSegDec.scala 15:17 26:23]
    node _GEN_6 = mux(_T_9, UInt<7>("h67"), _GEN_5) @[SevenSegDec.scala 15:17 25:22]
    node _GEN_7 = mux(_T_8, UInt<7>("h7f"), _GEN_6) @[SevenSegDec.scala 15:17 24:22]
    node _GEN_8 = mux(_T_7, UInt<3>("h7"), _GEN_7) @[SevenSegDec.scala 15:17 23:22]
    node _GEN_9 = mux(_T_6, UInt<7>("h7d"), _GEN_8) @[SevenSegDec.scala 15:17 22:22]
    node _GEN_10 = mux(_T_5, UInt<7>("h6d"), _GEN_9) @[SevenSegDec.scala 15:17 21:22]
    node _GEN_11 = mux(_T_4, UInt<7>("h66"), _GEN_10) @[SevenSegDec.scala 15:17 20:22]
    node _GEN_12 = mux(_T_3, UInt<7>("h4f"), _GEN_11) @[SevenSegDec.scala 15:17 19:22]
    node _GEN_13 = mux(_T_2, UInt<7>("h5b"), _GEN_12) @[SevenSegDec.scala 15:17 18:22]
    node _GEN_14 = mux(_T_1, UInt<6>("h30"), _GEN_13) @[SevenSegDec.scala 15:17 17:22]
    node _GEN_15 = mux(_T, UInt<6>("h3f"), _GEN_14) @[SevenSegDec.scala 15:17 16:22]
    node _T_16 = eq(io_custom, UInt<1>("h1")) @[SevenSegDec.scala 33:18]
    node _GEN_16 = mux(_T_16, io_customIn, _GEN_15) @[SevenSegDec.scala 33:{26,34}]
    node sevSeg = _GEN_16 @[SevenSegDec.scala 12:27]
    node _io_out_T = not(sevSeg) @[SevenSegDec.scala 36:13]
    io_out <= _io_out_T @[SevenSegDec.scala 36:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : UInt<1>
    input io_customIn_0 : UInt<7>
    input io_customIn_1 : UInt<7>
    input io_customIn_2 : UInt<7>
    input io_customIn_3 : UInt<7>
    input io_sum : UInt<7>
    input io_price : UInt<5>
    output io_seg : UInt<7>
    output io_an : UInt<4>

    inst table of BcdTable @[DisplayMultiplexer.scala 16:21]
    inst decoder of SevenSegDec @[DisplayMultiplexer.scala 19:23]
    reg selectReg : UInt<2>, clock with :
      reset => (UInt<1>("h0"), selectReg) @[DisplayMultiplexer.scala 14:26]
    reg tickCounterReg : UInt<17>, clock with :
      reset => (UInt<1>("h0"), tickCounterReg) @[DisplayMultiplexer.scala 25:32]
    node tick = eq(tickCounterReg, UInt<5>("h13")) @[DisplayMultiplexer.scala 26:29]
    node _tickCounterReg_T = add(tickCounterReg, UInt<1>("h1")) @[DisplayMultiplexer.scala 27:36]
    node _tickCounterReg_T_1 = tail(_tickCounterReg_T, 1) @[DisplayMultiplexer.scala 27:36]
    node _selectReg_T = add(selectReg, UInt<1>("h1")) @[DisplayMultiplexer.scala 31:28]
    node _selectReg_T_1 = tail(_selectReg_T, 1) @[DisplayMultiplexer.scala 31:28]
    node _GEN_0 = mux(tick, UInt<1>("h0"), _tickCounterReg_T_1) @[DisplayMultiplexer.scala 29:15 27:18 30:20]
    node _GEN_1 = mux(tick, _selectReg_T_1, selectReg) @[DisplayMultiplexer.scala 29:15 31:15 14:26]
    node _T = eq(UInt<1>("h0"), selectReg) @[DisplayMultiplexer.scala 34:21]
    node _decoder_io_in_T = bits(table.io_data, 3, 0) @[DisplayMultiplexer.scala 37:37]
    node _T_1 = eq(UInt<1>("h1"), selectReg) @[DisplayMultiplexer.scala 34:21]
    node _decoder_io_in_T_1 = bits(table.io_data, 7, 4) @[DisplayMultiplexer.scala 41:37]
    node _T_2 = eq(UInt<2>("h2"), selectReg) @[DisplayMultiplexer.scala 34:21]
    node _decoder_io_in_T_2 = bits(table.io_data, 3, 0) @[DisplayMultiplexer.scala 45:37]
    node _T_3 = eq(UInt<2>("h3"), selectReg) @[DisplayMultiplexer.scala 34:21]
    node _decoder_io_in_T_3 = bits(table.io_data, 7, 4) @[DisplayMultiplexer.scala 49:37]
    node _GEN_2 = mux(_T_3, io_sum, UInt<1>("h0")) @[DisplayMultiplexer.scala 17:20 34:21 48:24]
    node _GEN_3 = mux(_T_3, _decoder_io_in_T_3, UInt<1>("h0")) @[DisplayMultiplexer.scala 22:17 34:21 49:21]
    node _GEN_4 = mux(_T_2, io_sum, _GEN_2) @[DisplayMultiplexer.scala 34:21 44:24]
    node _GEN_5 = mux(_T_2, _decoder_io_in_T_2, _GEN_3) @[DisplayMultiplexer.scala 34:21 45:21]
    node _GEN_6 = mux(_T_1, io_price, _GEN_4) @[DisplayMultiplexer.scala 34:21 40:24]
    node _GEN_7 = mux(_T_1, _decoder_io_in_T_1, _GEN_5) @[DisplayMultiplexer.scala 34:21 41:21]
    node _GEN_8 = mux(_T, io_price, _GEN_6) @[DisplayMultiplexer.scala 34:21 36:24]
    node _GEN_9 = mux(_T, _decoder_io_in_T, _GEN_7) @[DisplayMultiplexer.scala 34:21 37:21]
    node _T_4 = neq(io_customIn_0, UInt<1>("h0")) @[DisplayMultiplexer.scala 54:24]
    node _T_5 = neq(io_customIn_1, UInt<1>("h0")) @[DisplayMultiplexer.scala 54:49]
    node _T_6 = or(_T_4, _T_5) @[DisplayMultiplexer.scala 54:32]
    node _T_7 = neq(io_customIn_2, UInt<1>("h0")) @[DisplayMultiplexer.scala 54:74]
    node _T_8 = or(_T_6, _T_7) @[DisplayMultiplexer.scala 54:57]
    node _T_9 = neq(io_customIn_3, UInt<1>("h0")) @[DisplayMultiplexer.scala 54:99]
    node _T_10 = or(_T_8, _T_9) @[DisplayMultiplexer.scala 54:82]
    node _GEN_10 = validif(eq(UInt<1>("h0"), selectReg), io_customIn_0) @[DisplayMultiplexer.scala 56:{25,25}]
    node _GEN_11 = mux(eq(UInt<1>("h1"), selectReg), io_customIn_1, _GEN_10) @[DisplayMultiplexer.scala 56:{25,25}]
    node _GEN_12 = mux(eq(UInt<2>("h2"), selectReg), io_customIn_2, _GEN_11) @[DisplayMultiplexer.scala 56:{25,25}]
    node _GEN_13 = mux(eq(UInt<2>("h3"), selectReg), io_customIn_3, _GEN_12) @[DisplayMultiplexer.scala 56:{25,25}]
    node _GEN_14 = mux(_T_10, UInt<1>("h1"), UInt<1>("h0")) @[DisplayMultiplexer.scala 54:107 20:21 55:23]
    node _io_customIn_selectReg = _GEN_13 @[DisplayMultiplexer.scala 56:25]
    node _GEN_15 = mux(_T_10, _io_customIn_selectReg, UInt<1>("h0")) @[DisplayMultiplexer.scala 54:107 21:23 56:25]
    node _io_an_T = dshl(UInt<1>("h1"), selectReg) @[DisplayMultiplexer.scala 61:18]
    node _io_an_T_1 = not(_io_an_T) @[DisplayMultiplexer.scala 61:12]
    node sevSeg = decoder.io_out @[DisplayMultiplexer.scala 13:27 23:10]
    io_seg <= sevSeg @[DisplayMultiplexer.scala 60:10]
    io_an <= _io_an_T_1 @[DisplayMultiplexer.scala 61:9]
    selectReg <= mux(reset, UInt<2>("h0"), _GEN_1) @[DisplayMultiplexer.scala 14:{26,26}]
    table.clock <= clock
    table.reset <= reset
    table.io_address <= pad(_GEN_8, 8)
    decoder.clock <= clock
    decoder.reset <= reset
    decoder.io_in <= _GEN_9
    decoder.io_custom <= _GEN_14
    decoder.io_customIn <= _GEN_15
    tickCounterReg <= mux(reset, UInt<17>("h0"), _GEN_0) @[DisplayMultiplexer.scala 25:{32,32}]

  module VendingMachine :
    input clock : Clock
    input reset : UInt<1>
    input io_price : UInt<5>
    input io_coin2Raw : UInt<1>
    input io_coin5Raw : UInt<1>
    input io_buyRaw : UInt<1>
    output io_releaseCan : UInt<1>
    output io_alarm : UInt<1>
    output io_seg : UInt<7>
    output io_an : UInt<4>

    inst coin2Deb of Debouncer @[VendingMachine.scala 25:24]
    inst coin5Deb of Debouncer @[VendingMachine.scala 29:24]
    inst buyDeb of Debouncer @[VendingMachine.scala 33:22]
    inst dataPath of dataPath @[VendingMachine.scala 38:24]
    inst fsm of fsm @[VendingMachine.scala 39:19]
    inst dispMux of DisplayMultiplexer @[VendingMachine.scala 60:23]
    node _T = neq(dataPath.io_customOut_3, UInt<1>("h0")) @[VendingMachine.scala 54:33]
    node _T_1 = neq(dataPath.io_customOut_2, UInt<1>("h0")) @[VendingMachine.scala 54:68]
    node _T_2 = or(_T, _T_1) @[VendingMachine.scala 54:41]
    node _T_3 = neq(dataPath.io_customOut_1, UInt<1>("h0")) @[VendingMachine.scala 54:103]
    node _T_4 = or(_T_2, _T_3) @[VendingMachine.scala 54:76]
    node _T_5 = neq(dataPath.io_customOut_0, UInt<1>("h0")) @[VendingMachine.scala 54:138]
    node _T_6 = or(_T_4, _T_5) @[VendingMachine.scala 54:111]
    node _GEN_0 = mux(_T_6, UInt<1>("h1"), UInt<1>("h0")) @[VendingMachine.scala 54:146 55:18 57:18]
    node empty = UInt<1>("h0") @[VendingMachine.scala 19:{26,26}]
    node coin2 = coin2Deb.io_out @[VendingMachine.scala 20:26 27:9]
    node coin5 = coin5Deb.io_out @[VendingMachine.scala 21:26 31:9]
    node buy = buyDeb.io_out @[VendingMachine.scala 22:24 35:7]
    io_releaseCan <= fsm.io_releaseCan @[VendingMachine.scala 70:17]
    io_alarm <= fsm.io_alarm @[VendingMachine.scala 69:12]
    io_seg <= dispMux.io_seg @[VendingMachine.scala 71:10]
    io_an <= dispMux.io_an @[VendingMachine.scala 72:9]
    coin2Deb.clock <= clock
    coin2Deb.reset <= reset
    coin2Deb.io_in <= io_coin2Raw @[VendingMachine.scala 26:18]
    coin5Deb.clock <= clock
    coin5Deb.reset <= reset
    coin5Deb.io_in <= io_coin5Raw @[VendingMachine.scala 30:18]
    buyDeb.clock <= clock
    buyDeb.reset <= reset
    buyDeb.io_in <= io_buyRaw @[VendingMachine.scala 34:16]
    dataPath.clock <= clock
    dataPath.reset <= reset
    dataPath.io_price <= io_price @[VendingMachine.scala 42:21]
    dataPath.io_coin2 <= coin2 @[VendingMachine.scala 43:21]
    dataPath.io_coin5 <= coin5 @[VendingMachine.scala 44:21]
    dataPath.io_sub <= fsm.io_sub @[VendingMachine.scala 46:19]
    dataPath.io_add <= fsm.io_add @[VendingMachine.scala 47:19]
    fsm.clock <= clock
    fsm.reset <= reset
    fsm.io_price <= io_price @[VendingMachine.scala 49:16]
    fsm.io_sum <= pad(dataPath.io_sum, 8) @[VendingMachine.scala 52:14]
    fsm.io_buy <= buy @[VendingMachine.scala 50:14]
    fsm.io_coin <= dataPath.io_coin @[VendingMachine.scala 53:15]
    fsm.io_empty <= _GEN_0
    dispMux.clock <= clock
    dispMux.reset <= reset
    dispMux.io_customIn_0 <= dataPath.io_customOut_0 @[VendingMachine.scala 66:23]
    dispMux.io_customIn_1 <= dataPath.io_customOut_1 @[VendingMachine.scala 66:23]
    dispMux.io_customIn_2 <= dataPath.io_customOut_2 @[VendingMachine.scala 66:23]
    dispMux.io_customIn_3 <= dataPath.io_customOut_3 @[VendingMachine.scala 66:23]
    dispMux.io_sum <= dataPath.io_sum @[VendingMachine.scala 65:18]
    dispMux.io_price <= io_price @[VendingMachine.scala 64:20]
