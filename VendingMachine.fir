circuit VendingMachine :
  module debounceFsm :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<1>, flip countReg : UInt<27>, dout : UInt<1>, runTimer : UInt<1>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[Debouncer.scala 42:25]
    node _T = asUInt(UInt<1>("h0")) @[Debouncer.scala 45:19]
    node _T_1 = asUInt(stateReg) @[Debouncer.scala 45:19]
    node _T_2 = eq(_T, _T_1) @[Debouncer.scala 45:19]
    when _T_2 : @[Debouncer.scala 45:19]
      when io.din : @[Debouncer.scala 47:19]
        stateReg <= UInt<1>("h1") @[Debouncer.scala 48:18]
    else :
      node _T_3 = asUInt(UInt<1>("h1")) @[Debouncer.scala 45:19]
      node _T_4 = asUInt(stateReg) @[Debouncer.scala 45:19]
      node _T_5 = eq(_T_3, _T_4) @[Debouncer.scala 45:19]
      when _T_5 : @[Debouncer.scala 45:19]
        node _T_6 = eq(io.din, UInt<1>("h0")) @[Debouncer.scala 52:12]
        when _T_6 : @[Debouncer.scala 52:20]
          stateReg <= UInt<2>("h2") @[Debouncer.scala 53:18]
      else :
        node _T_7 = asUInt(UInt<2>("h2")) @[Debouncer.scala 45:19]
        node _T_8 = asUInt(stateReg) @[Debouncer.scala 45:19]
        node _T_9 = eq(_T_7, _T_8) @[Debouncer.scala 45:19]
        when _T_9 : @[Debouncer.scala 45:19]
          when io.din : @[Debouncer.scala 57:19]
            stateReg <= UInt<1>("h1") @[Debouncer.scala 58:18]
          else :
            node _T_10 = eq(io.countReg, UInt<24>("h98967e")) @[Debouncer.scala 60:29]
            when _T_10 : @[Debouncer.scala 60:41]
              stateReg <= UInt<1>("h0") @[Debouncer.scala 61:18]
    node _io_dout_T = eq(stateReg, UInt<1>("h1")) @[Debouncer.scala 66:23]
    node _io_dout_T_1 = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 66:45]
    node _io_dout_T_2 = or(_io_dout_T, _io_dout_T_1) @[Debouncer.scala 66:32]
    io.dout <= _io_dout_T_2 @[Debouncer.scala 66:10]
    node _io_runTimer_T = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 67:27]
    io.runTimer <= _io_runTimer_T @[Debouncer.scala 67:15]

  module Debouncer :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, out : UInt<1>}

    reg countReg : UInt<27>, clock with :
      reset => (reset, UInt<27>("h0")) @[Debouncer.scala 10:27]
    inst fsm of debounceFsm @[Debouncer.scala 12:21]
    fsm.clock <= clock
    fsm.reset <= reset
    fsm.io.din <= io.in @[Debouncer.scala 13:16]
    fsm.io.countReg <= countReg @[Debouncer.scala 14:21]
    io.out <= fsm.io.dout @[Debouncer.scala 15:12]
    when fsm.io.runTimer : @[Debouncer.scala 17:26]
      node _countReg_T = add(countReg, UInt<1>("h1")) @[Debouncer.scala 18:28]
      node _countReg_T_1 = tail(_countReg_T, 1) @[Debouncer.scala 18:28]
      countReg <= _countReg_T_1 @[Debouncer.scala 18:16]
    else :
      countReg <= UInt<1>("h0") @[Debouncer.scala 20:16]


  module debounceFsm_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<1>, flip countReg : UInt<27>, dout : UInt<1>, runTimer : UInt<1>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[Debouncer.scala 42:25]
    node _T = asUInt(UInt<1>("h0")) @[Debouncer.scala 45:19]
    node _T_1 = asUInt(stateReg) @[Debouncer.scala 45:19]
    node _T_2 = eq(_T, _T_1) @[Debouncer.scala 45:19]
    when _T_2 : @[Debouncer.scala 45:19]
      when io.din : @[Debouncer.scala 47:19]
        stateReg <= UInt<1>("h1") @[Debouncer.scala 48:18]
    else :
      node _T_3 = asUInt(UInt<1>("h1")) @[Debouncer.scala 45:19]
      node _T_4 = asUInt(stateReg) @[Debouncer.scala 45:19]
      node _T_5 = eq(_T_3, _T_4) @[Debouncer.scala 45:19]
      when _T_5 : @[Debouncer.scala 45:19]
        node _T_6 = eq(io.din, UInt<1>("h0")) @[Debouncer.scala 52:12]
        when _T_6 : @[Debouncer.scala 52:20]
          stateReg <= UInt<2>("h2") @[Debouncer.scala 53:18]
      else :
        node _T_7 = asUInt(UInt<2>("h2")) @[Debouncer.scala 45:19]
        node _T_8 = asUInt(stateReg) @[Debouncer.scala 45:19]
        node _T_9 = eq(_T_7, _T_8) @[Debouncer.scala 45:19]
        when _T_9 : @[Debouncer.scala 45:19]
          when io.din : @[Debouncer.scala 57:19]
            stateReg <= UInt<1>("h1") @[Debouncer.scala 58:18]
          else :
            node _T_10 = eq(io.countReg, UInt<24>("h98967e")) @[Debouncer.scala 60:29]
            when _T_10 : @[Debouncer.scala 60:41]
              stateReg <= UInt<1>("h0") @[Debouncer.scala 61:18]
    node _io_dout_T = eq(stateReg, UInt<1>("h1")) @[Debouncer.scala 66:23]
    node _io_dout_T_1 = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 66:45]
    node _io_dout_T_2 = or(_io_dout_T, _io_dout_T_1) @[Debouncer.scala 66:32]
    io.dout <= _io_dout_T_2 @[Debouncer.scala 66:10]
    node _io_runTimer_T = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 67:27]
    io.runTimer <= _io_runTimer_T @[Debouncer.scala 67:15]

  module Debouncer_1 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, out : UInt<1>}

    reg countReg : UInt<27>, clock with :
      reset => (reset, UInt<27>("h0")) @[Debouncer.scala 10:27]
    inst fsm of debounceFsm_1 @[Debouncer.scala 12:21]
    fsm.clock <= clock
    fsm.reset <= reset
    fsm.io.din <= io.in @[Debouncer.scala 13:16]
    fsm.io.countReg <= countReg @[Debouncer.scala 14:21]
    io.out <= fsm.io.dout @[Debouncer.scala 15:12]
    when fsm.io.runTimer : @[Debouncer.scala 17:26]
      node _countReg_T = add(countReg, UInt<1>("h1")) @[Debouncer.scala 18:28]
      node _countReg_T_1 = tail(_countReg_T, 1) @[Debouncer.scala 18:28]
      countReg <= _countReg_T_1 @[Debouncer.scala 18:16]
    else :
      countReg <= UInt<1>("h0") @[Debouncer.scala 20:16]


  module debounceFsm_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip din : UInt<1>, flip countReg : UInt<27>, dout : UInt<1>, runTimer : UInt<1>}

    reg stateReg : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[Debouncer.scala 42:25]
    node _T = asUInt(UInt<1>("h0")) @[Debouncer.scala 45:19]
    node _T_1 = asUInt(stateReg) @[Debouncer.scala 45:19]
    node _T_2 = eq(_T, _T_1) @[Debouncer.scala 45:19]
    when _T_2 : @[Debouncer.scala 45:19]
      when io.din : @[Debouncer.scala 47:19]
        stateReg <= UInt<1>("h1") @[Debouncer.scala 48:18]
    else :
      node _T_3 = asUInt(UInt<1>("h1")) @[Debouncer.scala 45:19]
      node _T_4 = asUInt(stateReg) @[Debouncer.scala 45:19]
      node _T_5 = eq(_T_3, _T_4) @[Debouncer.scala 45:19]
      when _T_5 : @[Debouncer.scala 45:19]
        node _T_6 = eq(io.din, UInt<1>("h0")) @[Debouncer.scala 52:12]
        when _T_6 : @[Debouncer.scala 52:20]
          stateReg <= UInt<2>("h2") @[Debouncer.scala 53:18]
      else :
        node _T_7 = asUInt(UInt<2>("h2")) @[Debouncer.scala 45:19]
        node _T_8 = asUInt(stateReg) @[Debouncer.scala 45:19]
        node _T_9 = eq(_T_7, _T_8) @[Debouncer.scala 45:19]
        when _T_9 : @[Debouncer.scala 45:19]
          when io.din : @[Debouncer.scala 57:19]
            stateReg <= UInt<1>("h1") @[Debouncer.scala 58:18]
          else :
            node _T_10 = eq(io.countReg, UInt<24>("h98967e")) @[Debouncer.scala 60:29]
            when _T_10 : @[Debouncer.scala 60:41]
              stateReg <= UInt<1>("h0") @[Debouncer.scala 61:18]
    node _io_dout_T = eq(stateReg, UInt<1>("h1")) @[Debouncer.scala 66:23]
    node _io_dout_T_1 = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 66:45]
    node _io_dout_T_2 = or(_io_dout_T, _io_dout_T_1) @[Debouncer.scala 66:32]
    io.dout <= _io_dout_T_2 @[Debouncer.scala 66:10]
    node _io_runTimer_T = eq(stateReg, UInt<2>("h2")) @[Debouncer.scala 67:27]
    io.runTimer <= _io_runTimer_T @[Debouncer.scala 67:15]

  module Debouncer_2 :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<1>, out : UInt<1>}

    reg countReg : UInt<27>, clock with :
      reset => (reset, UInt<27>("h0")) @[Debouncer.scala 10:27]
    inst fsm of debounceFsm_2 @[Debouncer.scala 12:21]
    fsm.clock <= clock
    fsm.reset <= reset
    fsm.io.din <= io.in @[Debouncer.scala 13:16]
    fsm.io.countReg <= countReg @[Debouncer.scala 14:21]
    io.out <= fsm.io.dout @[Debouncer.scala 15:12]
    when fsm.io.runTimer : @[Debouncer.scala 17:26]
      node _countReg_T = add(countReg, UInt<1>("h1")) @[Debouncer.scala 18:28]
      node _countReg_T_1 = tail(_countReg_T, 1) @[Debouncer.scala 18:28]
      countReg <= _countReg_T_1 @[Debouncer.scala 18:16]
    else :
      countReg <= UInt<1>("h0") @[Debouncer.scala 20:16]


  module BcdTable :
    input clock : Clock
    input reset : Reset
    output io : { flip address : UInt<8>, data : UInt<8>}

    wire table : UInt<8>[100] @[DisplayMultiplexer.scala 67:19]
    table[0] <= UInt<1>("h0") @[DisplayMultiplexer.scala 71:14]
    table[1] <= UInt<1>("h1") @[DisplayMultiplexer.scala 71:14]
    table[2] <= UInt<2>("h2") @[DisplayMultiplexer.scala 71:14]
    table[3] <= UInt<2>("h3") @[DisplayMultiplexer.scala 71:14]
    table[4] <= UInt<3>("h4") @[DisplayMultiplexer.scala 71:14]
    table[5] <= UInt<3>("h5") @[DisplayMultiplexer.scala 71:14]
    table[6] <= UInt<3>("h6") @[DisplayMultiplexer.scala 71:14]
    table[7] <= UInt<3>("h7") @[DisplayMultiplexer.scala 71:14]
    table[8] <= UInt<4>("h8") @[DisplayMultiplexer.scala 71:14]
    table[9] <= UInt<4>("h9") @[DisplayMultiplexer.scala 71:14]
    table[10] <= UInt<5>("h10") @[DisplayMultiplexer.scala 71:14]
    table[11] <= UInt<5>("h11") @[DisplayMultiplexer.scala 71:14]
    table[12] <= UInt<5>("h12") @[DisplayMultiplexer.scala 71:14]
    table[13] <= UInt<5>("h13") @[DisplayMultiplexer.scala 71:14]
    table[14] <= UInt<5>("h14") @[DisplayMultiplexer.scala 71:14]
    table[15] <= UInt<5>("h15") @[DisplayMultiplexer.scala 71:14]
    table[16] <= UInt<5>("h16") @[DisplayMultiplexer.scala 71:14]
    table[17] <= UInt<5>("h17") @[DisplayMultiplexer.scala 71:14]
    table[18] <= UInt<5>("h18") @[DisplayMultiplexer.scala 71:14]
    table[19] <= UInt<5>("h19") @[DisplayMultiplexer.scala 71:14]
    table[20] <= UInt<6>("h20") @[DisplayMultiplexer.scala 71:14]
    table[21] <= UInt<6>("h21") @[DisplayMultiplexer.scala 71:14]
    table[22] <= UInt<6>("h22") @[DisplayMultiplexer.scala 71:14]
    table[23] <= UInt<6>("h23") @[DisplayMultiplexer.scala 71:14]
    table[24] <= UInt<6>("h24") @[DisplayMultiplexer.scala 71:14]
    table[25] <= UInt<6>("h25") @[DisplayMultiplexer.scala 71:14]
    table[26] <= UInt<6>("h26") @[DisplayMultiplexer.scala 71:14]
    table[27] <= UInt<6>("h27") @[DisplayMultiplexer.scala 71:14]
    table[28] <= UInt<6>("h28") @[DisplayMultiplexer.scala 71:14]
    table[29] <= UInt<6>("h29") @[DisplayMultiplexer.scala 71:14]
    table[30] <= UInt<6>("h30") @[DisplayMultiplexer.scala 71:14]
    table[31] <= UInt<6>("h31") @[DisplayMultiplexer.scala 71:14]
    table[32] <= UInt<6>("h32") @[DisplayMultiplexer.scala 71:14]
    table[33] <= UInt<6>("h33") @[DisplayMultiplexer.scala 71:14]
    table[34] <= UInt<6>("h34") @[DisplayMultiplexer.scala 71:14]
    table[35] <= UInt<6>("h35") @[DisplayMultiplexer.scala 71:14]
    table[36] <= UInt<6>("h36") @[DisplayMultiplexer.scala 71:14]
    table[37] <= UInt<6>("h37") @[DisplayMultiplexer.scala 71:14]
    table[38] <= UInt<6>("h38") @[DisplayMultiplexer.scala 71:14]
    table[39] <= UInt<6>("h39") @[DisplayMultiplexer.scala 71:14]
    table[40] <= UInt<7>("h40") @[DisplayMultiplexer.scala 71:14]
    table[41] <= UInt<7>("h41") @[DisplayMultiplexer.scala 71:14]
    table[42] <= UInt<7>("h42") @[DisplayMultiplexer.scala 71:14]
    table[43] <= UInt<7>("h43") @[DisplayMultiplexer.scala 71:14]
    table[44] <= UInt<7>("h44") @[DisplayMultiplexer.scala 71:14]
    table[45] <= UInt<7>("h45") @[DisplayMultiplexer.scala 71:14]
    table[46] <= UInt<7>("h46") @[DisplayMultiplexer.scala 71:14]
    table[47] <= UInt<7>("h47") @[DisplayMultiplexer.scala 71:14]
    table[48] <= UInt<7>("h48") @[DisplayMultiplexer.scala 71:14]
    table[49] <= UInt<7>("h49") @[DisplayMultiplexer.scala 71:14]
    table[50] <= UInt<7>("h50") @[DisplayMultiplexer.scala 71:14]
    table[51] <= UInt<7>("h51") @[DisplayMultiplexer.scala 71:14]
    table[52] <= UInt<7>("h52") @[DisplayMultiplexer.scala 71:14]
    table[53] <= UInt<7>("h53") @[DisplayMultiplexer.scala 71:14]
    table[54] <= UInt<7>("h54") @[DisplayMultiplexer.scala 71:14]
    table[55] <= UInt<7>("h55") @[DisplayMultiplexer.scala 71:14]
    table[56] <= UInt<7>("h56") @[DisplayMultiplexer.scala 71:14]
    table[57] <= UInt<7>("h57") @[DisplayMultiplexer.scala 71:14]
    table[58] <= UInt<7>("h58") @[DisplayMultiplexer.scala 71:14]
    table[59] <= UInt<7>("h59") @[DisplayMultiplexer.scala 71:14]
    table[60] <= UInt<7>("h60") @[DisplayMultiplexer.scala 71:14]
    table[61] <= UInt<7>("h61") @[DisplayMultiplexer.scala 71:14]
    table[62] <= UInt<7>("h62") @[DisplayMultiplexer.scala 71:14]
    table[63] <= UInt<7>("h63") @[DisplayMultiplexer.scala 71:14]
    table[64] <= UInt<7>("h64") @[DisplayMultiplexer.scala 71:14]
    table[65] <= UInt<7>("h65") @[DisplayMultiplexer.scala 71:14]
    table[66] <= UInt<7>("h66") @[DisplayMultiplexer.scala 71:14]
    table[67] <= UInt<7>("h67") @[DisplayMultiplexer.scala 71:14]
    table[68] <= UInt<7>("h68") @[DisplayMultiplexer.scala 71:14]
    table[69] <= UInt<7>("h69") @[DisplayMultiplexer.scala 71:14]
    table[70] <= UInt<7>("h70") @[DisplayMultiplexer.scala 71:14]
    table[71] <= UInt<7>("h71") @[DisplayMultiplexer.scala 71:14]
    table[72] <= UInt<7>("h72") @[DisplayMultiplexer.scala 71:14]
    table[73] <= UInt<7>("h73") @[DisplayMultiplexer.scala 71:14]
    table[74] <= UInt<7>("h74") @[DisplayMultiplexer.scala 71:14]
    table[75] <= UInt<7>("h75") @[DisplayMultiplexer.scala 71:14]
    table[76] <= UInt<7>("h76") @[DisplayMultiplexer.scala 71:14]
    table[77] <= UInt<7>("h77") @[DisplayMultiplexer.scala 71:14]
    table[78] <= UInt<7>("h78") @[DisplayMultiplexer.scala 71:14]
    table[79] <= UInt<7>("h79") @[DisplayMultiplexer.scala 71:14]
    table[80] <= UInt<8>("h80") @[DisplayMultiplexer.scala 71:14]
    table[81] <= UInt<8>("h81") @[DisplayMultiplexer.scala 71:14]
    table[82] <= UInt<8>("h82") @[DisplayMultiplexer.scala 71:14]
    table[83] <= UInt<8>("h83") @[DisplayMultiplexer.scala 71:14]
    table[84] <= UInt<8>("h84") @[DisplayMultiplexer.scala 71:14]
    table[85] <= UInt<8>("h85") @[DisplayMultiplexer.scala 71:14]
    table[86] <= UInt<8>("h86") @[DisplayMultiplexer.scala 71:14]
    table[87] <= UInt<8>("h87") @[DisplayMultiplexer.scala 71:14]
    table[88] <= UInt<8>("h88") @[DisplayMultiplexer.scala 71:14]
    table[89] <= UInt<8>("h89") @[DisplayMultiplexer.scala 71:14]
    table[90] <= UInt<8>("h90") @[DisplayMultiplexer.scala 71:14]
    table[91] <= UInt<8>("h91") @[DisplayMultiplexer.scala 71:14]
    table[92] <= UInt<8>("h92") @[DisplayMultiplexer.scala 71:14]
    table[93] <= UInt<8>("h93") @[DisplayMultiplexer.scala 71:14]
    table[94] <= UInt<8>("h94") @[DisplayMultiplexer.scala 71:14]
    table[95] <= UInt<8>("h95") @[DisplayMultiplexer.scala 71:14]
    table[96] <= UInt<8>("h96") @[DisplayMultiplexer.scala 71:14]
    table[97] <= UInt<8>("h97") @[DisplayMultiplexer.scala 71:14]
    table[98] <= UInt<8>("h98") @[DisplayMultiplexer.scala 71:14]
    table[99] <= UInt<8>("h99") @[DisplayMultiplexer.scala 71:14]
    node _io_data_T = bits(io.address, 6, 0)
    io.data <= table[_io_data_T] @[DisplayMultiplexer.scala 74:11]

  module SevenSegDec :
    input clock : Clock
    input reset : Reset
    output io : { flip in : UInt<4>, out : UInt<7>}

    wire sevSeg : UInt<7> @[SevenSegDec.scala 10:27]
    sevSeg <= UInt<7>("h0") @[SevenSegDec.scala 10:27]
    node _T = eq(UInt<1>("h0"), io.in) @[SevenSegDec.scala 13:17]
    when _T : @[SevenSegDec.scala 13:17]
      sevSeg <= UInt<6>("h3f") @[SevenSegDec.scala 14:22]
    else :
      node _T_1 = eq(UInt<1>("h1"), io.in) @[SevenSegDec.scala 13:17]
      when _T_1 : @[SevenSegDec.scala 13:17]
        sevSeg <= UInt<6>("h30") @[SevenSegDec.scala 15:22]
      else :
        node _T_2 = eq(UInt<2>("h2"), io.in) @[SevenSegDec.scala 13:17]
        when _T_2 : @[SevenSegDec.scala 13:17]
          sevSeg <= UInt<7>("h5b") @[SevenSegDec.scala 16:22]
        else :
          node _T_3 = eq(UInt<2>("h3"), io.in) @[SevenSegDec.scala 13:17]
          when _T_3 : @[SevenSegDec.scala 13:17]
            sevSeg <= UInt<7>("h4f") @[SevenSegDec.scala 17:22]
          else :
            node _T_4 = eq(UInt<3>("h4"), io.in) @[SevenSegDec.scala 13:17]
            when _T_4 : @[SevenSegDec.scala 13:17]
              sevSeg <= UInt<7>("h66") @[SevenSegDec.scala 18:22]
            else :
              node _T_5 = eq(UInt<3>("h5"), io.in) @[SevenSegDec.scala 13:17]
              when _T_5 : @[SevenSegDec.scala 13:17]
                sevSeg <= UInt<7>("h6d") @[SevenSegDec.scala 19:22]
              else :
                node _T_6 = eq(UInt<3>("h6"), io.in) @[SevenSegDec.scala 13:17]
                when _T_6 : @[SevenSegDec.scala 13:17]
                  sevSeg <= UInt<7>("h7d") @[SevenSegDec.scala 20:22]
                else :
                  node _T_7 = eq(UInt<3>("h7"), io.in) @[SevenSegDec.scala 13:17]
                  when _T_7 : @[SevenSegDec.scala 13:17]
                    sevSeg <= UInt<3>("h7") @[SevenSegDec.scala 21:22]
                  else :
                    node _T_8 = eq(UInt<4>("h8"), io.in) @[SevenSegDec.scala 13:17]
                    when _T_8 : @[SevenSegDec.scala 13:17]
                      sevSeg <= UInt<7>("h7f") @[SevenSegDec.scala 22:22]
                    else :
                      node _T_9 = eq(UInt<4>("h9"), io.in) @[SevenSegDec.scala 13:17]
                      when _T_9 : @[SevenSegDec.scala 13:17]
                        sevSeg <= UInt<7>("h67") @[SevenSegDec.scala 23:22]
                      else :
                        node _T_10 = eq(UInt<4>("ha"), io.in) @[SevenSegDec.scala 13:17]
                        when _T_10 : @[SevenSegDec.scala 13:17]
                          sevSeg <= UInt<7>("h77") @[SevenSegDec.scala 24:23]
                        else :
                          node _T_11 = eq(UInt<4>("hb"), io.in) @[SevenSegDec.scala 13:17]
                          when _T_11 : @[SevenSegDec.scala 13:17]
                            sevSeg <= UInt<7>("h7c") @[SevenSegDec.scala 25:23]
                          else :
                            node _T_12 = eq(UInt<4>("hc"), io.in) @[SevenSegDec.scala 13:17]
                            when _T_12 : @[SevenSegDec.scala 13:17]
                              sevSeg <= UInt<6>("h39") @[SevenSegDec.scala 26:23]
                            else :
                              node _T_13 = eq(UInt<4>("hd"), io.in) @[SevenSegDec.scala 13:17]
                              when _T_13 : @[SevenSegDec.scala 13:17]
                                sevSeg <= UInt<7>("h5e") @[SevenSegDec.scala 27:23]
                              else :
                                node _T_14 = eq(UInt<4>("he"), io.in) @[SevenSegDec.scala 13:17]
                                when _T_14 : @[SevenSegDec.scala 13:17]
                                  sevSeg <= UInt<7>("h79") @[SevenSegDec.scala 28:23]
                                else :
                                  node _T_15 = eq(UInt<4>("hf"), io.in) @[SevenSegDec.scala 13:17]
                                  when _T_15 : @[SevenSegDec.scala 13:17]
                                    sevSeg <= UInt<7>("h71") @[SevenSegDec.scala 29:23]
    node _io_out_T = not(sevSeg) @[SevenSegDec.scala 33:13]
    io.out <= _io_out_T @[SevenSegDec.scala 33:10]

  module DisplayMultiplexer :
    input clock : Clock
    input reset : Reset
    output io : { flip sum : UInt<7>, flip price : UInt<5>, seg : UInt<7>, an : UInt<4>}

    wire sevSeg : UInt<7> @[DisplayMultiplexer.scala 12:27]
    sevSeg <= UInt<7>("h7f") @[DisplayMultiplexer.scala 12:27]
    reg selectReg : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[DisplayMultiplexer.scala 17:26]
    inst table of BcdTable @[DisplayMultiplexer.scala 19:21]
    table.clock <= clock
    table.reset <= reset
    table.io.address <= UInt<1>("h0") @[DisplayMultiplexer.scala 20:20]
    inst decoder of SevenSegDec @[DisplayMultiplexer.scala 22:23]
    decoder.clock <= clock
    decoder.reset <= reset
    decoder.io.in <= UInt<1>("h0") @[DisplayMultiplexer.scala 23:17]
    sevSeg <= decoder.io.out @[DisplayMultiplexer.scala 24:10]
    reg tickCounterReg : UInt<17>, clock with :
      reset => (reset, UInt<17>("h0")) @[DisplayMultiplexer.scala 26:32]
    node tick = eq(tickCounterReg, UInt<17>("h1869f")) @[DisplayMultiplexer.scala 27:29]
    node _tickCounterReg_T = add(tickCounterReg, UInt<1>("h1")) @[DisplayMultiplexer.scala 28:36]
    node _tickCounterReg_T_1 = tail(_tickCounterReg_T, 1) @[DisplayMultiplexer.scala 28:36]
    tickCounterReg <= _tickCounterReg_T_1 @[DisplayMultiplexer.scala 28:18]
    when tick : @[DisplayMultiplexer.scala 30:15]
      tickCounterReg <= UInt<1>("h0") @[DisplayMultiplexer.scala 31:20]
      node _selectReg_T = add(selectReg, UInt<1>("h1")) @[DisplayMultiplexer.scala 32:28]
      node _selectReg_T_1 = tail(_selectReg_T, 1) @[DisplayMultiplexer.scala 32:28]
      selectReg <= _selectReg_T_1 @[DisplayMultiplexer.scala 32:15]
    node _T = eq(UInt<1>("h0"), selectReg) @[DisplayMultiplexer.scala 35:21]
    when _T : @[DisplayMultiplexer.scala 35:21]
      table.io.address <= io.price @[DisplayMultiplexer.scala 37:24]
      node _decoder_io_in_T = bits(table.io.data, 3, 0) @[DisplayMultiplexer.scala 38:37]
      decoder.io.in <= _decoder_io_in_T @[DisplayMultiplexer.scala 38:21]
    else :
      node _T_1 = eq(UInt<1>("h1"), selectReg) @[DisplayMultiplexer.scala 35:21]
      when _T_1 : @[DisplayMultiplexer.scala 35:21]
        table.io.address <= io.price @[DisplayMultiplexer.scala 41:24]
        node _decoder_io_in_T_1 = bits(table.io.data, 7, 4) @[DisplayMultiplexer.scala 42:37]
        decoder.io.in <= _decoder_io_in_T_1 @[DisplayMultiplexer.scala 42:21]
      else :
        node _T_2 = eq(UInt<2>("h2"), selectReg) @[DisplayMultiplexer.scala 35:21]
        when _T_2 : @[DisplayMultiplexer.scala 35:21]
          table.io.address <= io.sum @[DisplayMultiplexer.scala 45:24]
          node _decoder_io_in_T_2 = bits(table.io.data, 3, 0) @[DisplayMultiplexer.scala 46:37]
          decoder.io.in <= _decoder_io_in_T_2 @[DisplayMultiplexer.scala 46:21]
        else :
          node _T_3 = eq(UInt<2>("h3"), selectReg) @[DisplayMultiplexer.scala 35:21]
          when _T_3 : @[DisplayMultiplexer.scala 35:21]
            table.io.address <= io.sum @[DisplayMultiplexer.scala 49:24]
            node _decoder_io_in_T_3 = bits(table.io.data, 7, 4) @[DisplayMultiplexer.scala 50:37]
            decoder.io.in <= _decoder_io_in_T_3 @[DisplayMultiplexer.scala 50:21]
    io.seg <= sevSeg @[DisplayMultiplexer.scala 56:10]
    node _io_an_T = dshl(UInt<1>("h1"), selectReg) @[DisplayMultiplexer.scala 57:18]
    node _io_an_T_1 = not(_io_an_T) @[DisplayMultiplexer.scala 57:12]
    io.an <= _io_an_T_1 @[DisplayMultiplexer.scala 57:9]

  module fsm :
    input clock : Clock
    input reset : Reset
    output io : { flip price : UInt<5>, flip sum : UInt<8>, flip buy : UInt<1>, flip coin : UInt<1>, sub : UInt<1>, add : UInt<1>, alarm : UInt<1>, releaseCan : UInt<1>}

    reg stateReg : UInt<3>, clock with :
      reset => (reset, UInt<1>("h0")) @[VendingMachine.scala 107:25]
    node _T = asUInt(UInt<1>("h0")) @[VendingMachine.scala 110:19]
    node _T_1 = asUInt(stateReg) @[VendingMachine.scala 110:19]
    node _T_2 = eq(_T, _T_1) @[VendingMachine.scala 110:19]
    when _T_2 : @[VendingMachine.scala 110:19]
      node _T_3 = geq(io.sum, io.price) @[VendingMachine.scala 112:29]
      node _T_4 = and(io.buy, _T_3) @[VendingMachine.scala 112:19]
      when _T_4 : @[VendingMachine.scala 112:41]
        stateReg <= UInt<1>("h1") @[VendingMachine.scala 113:18]
      else :
        node _T_5 = lt(io.sum, io.price) @[VendingMachine.scala 114:36]
        node _T_6 = and(io.buy, _T_5) @[VendingMachine.scala 114:26]
        when _T_6 : @[VendingMachine.scala 114:47]
          stateReg <= UInt<2>("h3") @[VendingMachine.scala 115:18]
        else :
          when io.coin : @[VendingMachine.scala 116:26]
            stateReg <= UInt<3>("h4") @[VendingMachine.scala 117:18]
    else :
      node _T_7 = asUInt(UInt<1>("h1")) @[VendingMachine.scala 110:19]
      node _T_8 = asUInt(stateReg) @[VendingMachine.scala 110:19]
      node _T_9 = eq(_T_7, _T_8) @[VendingMachine.scala 110:19]
      when _T_9 : @[VendingMachine.scala 110:19]
        stateReg <= UInt<2>("h2") @[VendingMachine.scala 121:15]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[VendingMachine.scala 110:19]
        node _T_11 = asUInt(stateReg) @[VendingMachine.scala 110:19]
        node _T_12 = eq(_T_10, _T_11) @[VendingMachine.scala 110:19]
        when _T_12 : @[VendingMachine.scala 110:19]
          node _T_13 = eq(io.buy, UInt<1>("h0")) @[VendingMachine.scala 124:19]
          when _T_13 : @[VendingMachine.scala 124:31]
            stateReg <= UInt<1>("h0") @[VendingMachine.scala 125:17]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[VendingMachine.scala 110:19]
          node _T_15 = asUInt(stateReg) @[VendingMachine.scala 110:19]
          node _T_16 = eq(_T_14, _T_15) @[VendingMachine.scala 110:19]
          when _T_16 : @[VendingMachine.scala 110:19]
            node _T_17 = eq(io.buy, UInt<1>("h0")) @[VendingMachine.scala 129:19]
            when _T_17 : @[VendingMachine.scala 129:31]
              stateReg <= UInt<1>("h0") @[VendingMachine.scala 130:17]
          else :
            node _T_18 = asUInt(UInt<3>("h4")) @[VendingMachine.scala 110:19]
            node _T_19 = asUInt(stateReg) @[VendingMachine.scala 110:19]
            node _T_20 = eq(_T_18, _T_19) @[VendingMachine.scala 110:19]
            when _T_20 : @[VendingMachine.scala 110:19]
              stateReg <= UInt<3>("h5") @[VendingMachine.scala 134:16]
            else :
              node _T_21 = asUInt(UInt<3>("h5")) @[VendingMachine.scala 110:19]
              node _T_22 = asUInt(stateReg) @[VendingMachine.scala 110:19]
              node _T_23 = eq(_T_21, _T_22) @[VendingMachine.scala 110:19]
              when _T_23 : @[VendingMachine.scala 110:19]
                node _T_24 = eq(io.coin, UInt<1>("h0")) @[VendingMachine.scala 137:20]
                when _T_24 : @[VendingMachine.scala 137:32]
                  stateReg <= UInt<1>("h0") @[VendingMachine.scala 138:17]
    node _io_sub_T = eq(stateReg, UInt<1>("h1")) @[VendingMachine.scala 144:21]
    io.sub <= _io_sub_T @[VendingMachine.scala 144:9]
    node _io_add_T = eq(stateReg, UInt<3>("h4")) @[VendingMachine.scala 145:22]
    io.add <= _io_add_T @[VendingMachine.scala 145:10]
    node _io_alarm_T = eq(stateReg, UInt<2>("h3")) @[VendingMachine.scala 146:24]
    io.alarm <= _io_alarm_T @[VendingMachine.scala 146:12]
    node _io_releaseCan_T = eq(stateReg, UInt<2>("h2")) @[VendingMachine.scala 147:30]
    node _io_releaseCan_T_1 = eq(stateReg, UInt<1>("h1")) @[VendingMachine.scala 147:54]
    node _io_releaseCan_T_2 = or(_io_releaseCan_T, _io_releaseCan_T_1) @[VendingMachine.scala 147:42]
    io.releaseCan <= _io_releaseCan_T_2 @[VendingMachine.scala 147:17]

  module VendingMachine :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip price : UInt<5>, flip coin2Raw : UInt<1>, flip coin5Raw : UInt<1>, flip buyRaw : UInt<1>, releaseCan : UInt<1>, alarm : UInt<1>, seg : UInt<7>, an : UInt<4>}

    wire sub : UInt<1> @[VendingMachine.scala 18:24]
    sub <= UInt<1>("h0") @[VendingMachine.scala 18:24]
    wire add : UInt<1> @[VendingMachine.scala 19:24]
    add <= UInt<1>("h0") @[VendingMachine.scala 19:24]
    wire alarm : UInt<1> @[VendingMachine.scala 20:26]
    alarm <= UInt<1>("h0") @[VendingMachine.scala 20:26]
    wire releaseCan : UInt<1> @[VendingMachine.scala 21:31]
    releaseCan <= UInt<1>("h0") @[VendingMachine.scala 21:31]
    wire coinVal : UInt @[VendingMachine.scala 22:28]
    coinVal <= UInt<1>("h0") @[VendingMachine.scala 22:28]
    wire coin2 : UInt<1> @[VendingMachine.scala 24:26]
    coin2 <= UInt<1>("h0") @[VendingMachine.scala 24:26]
    wire coin5 : UInt<1> @[VendingMachine.scala 25:26]
    coin5 <= UInt<1>("h0") @[VendingMachine.scala 25:26]
    wire buy : UInt<1> @[VendingMachine.scala 26:24]
    buy <= UInt<1>("h0") @[VendingMachine.scala 26:24]
    inst coin2Deb of Debouncer @[VendingMachine.scala 29:24]
    coin2Deb.clock <= clock
    coin2Deb.reset <= reset
    coin2Deb.io.in <= io.coin2Raw @[VendingMachine.scala 30:18]
    coin2 <= coin2Deb.io.out @[VendingMachine.scala 31:9]
    inst coin5Deb of Debouncer_1 @[VendingMachine.scala 32:24]
    coin5Deb.clock <= clock
    coin5Deb.reset <= reset
    coin5Deb.io.in <= io.coin5Raw @[VendingMachine.scala 33:18]
    coin5 <= coin5Deb.io.out @[VendingMachine.scala 34:9]
    inst buyDeb of Debouncer_2 @[VendingMachine.scala 35:22]
    buyDeb.clock <= clock
    buyDeb.reset <= reset
    buyDeb.io.in <= io.buyRaw @[VendingMachine.scala 36:16]
    buy <= buyDeb.io.out @[VendingMachine.scala 37:7]
    reg sumReg : UInt<7>, clock with :
      reset => (reset, UInt<7>("h0")) @[VendingMachine.scala 41:23]
    inst dispMux of DisplayMultiplexer @[VendingMachine.scala 44:23]
    dispMux.clock <= clock
    dispMux.reset <= reset
    dispMux.io.price <= io.price @[VendingMachine.scala 45:20]
    dispMux.io.sum <= sumReg @[VendingMachine.scala 46:18]
    inst fsm of fsm @[VendingMachine.scala 49:19]
    fsm.clock <= clock
    fsm.reset <= reset
    fsm.io.price <= io.price @[VendingMachine.scala 51:16]
    fsm.io.sum <= sumReg @[VendingMachine.scala 52:14]
    fsm.io.buy <= buy @[VendingMachine.scala 53:14]
    node _fsm_io_coin_T = or(coin2, coin5) @[VendingMachine.scala 54:24]
    fsm.io.coin <= _fsm_io_coin_T @[VendingMachine.scala 54:15]
    sub <= fsm.io.sub @[VendingMachine.scala 56:7]
    add <= fsm.io.add @[VendingMachine.scala 57:7]
    alarm <= fsm.io.alarm @[VendingMachine.scala 58:9]
    releaseCan <= fsm.io.releaseCan @[VendingMachine.scala 59:14]
    node _T = eq(coin2, UInt<1>("h1")) @[VendingMachine.scala 62:14]
    when _T : @[VendingMachine.scala 62:25]
      coinVal <= UInt<2>("h2") @[VendingMachine.scala 63:13]
    else :
      node _T_1 = eq(coin5, UInt<1>("h1")) @[VendingMachine.scala 64:21]
      when _T_1 : @[VendingMachine.scala 64:32]
        coinVal <= UInt<3>("h5") @[VendingMachine.scala 65:13]
    node _T_2 = eq(sub, UInt<1>("h0")) @[VendingMachine.scala 69:13]
    node _T_3 = eq(add, UInt<1>("h0")) @[VendingMachine.scala 69:32]
    node _T_4 = and(_T_2, _T_3) @[VendingMachine.scala 69:25]
    when _T_4 : @[VendingMachine.scala 69:45]
      sumReg <= sumReg @[VendingMachine.scala 70:12]
    else :
      node _T_5 = eq(add, UInt<1>("h1")) @[VendingMachine.scala 71:18]
      when _T_5 : @[VendingMachine.scala 71:29]
        node _sumReg_T = add(sumReg, coinVal) @[VendingMachine.scala 72:22]
        node _sumReg_T_1 = tail(_sumReg_T, 1) @[VendingMachine.scala 72:22]
        sumReg <= _sumReg_T_1 @[VendingMachine.scala 72:12]
      else :
        node _T_6 = eq(sub, UInt<1>("h1")) @[VendingMachine.scala 73:18]
        when _T_6 : @[VendingMachine.scala 73:30]
          node _sumReg_T_2 = sub(sumReg, io.price) @[VendingMachine.scala 74:22]
          node _sumReg_T_3 = tail(_sumReg_T_2, 1) @[VendingMachine.scala 74:22]
          sumReg <= _sumReg_T_3 @[VendingMachine.scala 74:12]
    io.alarm <= alarm @[VendingMachine.scala 78:12]
    io.releaseCan <= releaseCan @[VendingMachine.scala 79:17]
    io.seg <= dispMux.io.seg @[VendingMachine.scala 80:10]
    io.an <= dispMux.io.an @[VendingMachine.scala 81:9]

