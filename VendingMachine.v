module debounceFsm(
  input         clock,
  input         reset,
  input         io_din,
  input  [26:0] io_countReg,
  output        io_dout,
  output        io_runTimer
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] stateReg; // @[Debouncer.scala 42:25]
  wire [1:0] _GEN_2 = io_countReg == 27'h98967e ? 2'h0 : stateReg; // @[Debouncer.scala 60:41 61:18 42:25]
  wire [1:0] _GEN_3 = io_din ? 2'h1 : _GEN_2; // @[Debouncer.scala 57:19 58:18]
  assign io_dout = stateReg == 2'h1 | stateReg == 2'h2; // @[Debouncer.scala 66:32]
  assign io_runTimer = stateReg == 2'h2; // @[Debouncer.scala 67:27]
  always @(posedge clock) begin
    if (reset) begin // @[Debouncer.scala 42:25]
      stateReg <= 2'h0; // @[Debouncer.scala 42:25]
    end else if (2'h0 == stateReg) begin // @[Debouncer.scala 45:19]
      if (io_din) begin // @[Debouncer.scala 47:19]
        stateReg <= 2'h1; // @[Debouncer.scala 48:18]
      end
    end else if (2'h1 == stateReg) begin // @[Debouncer.scala 45:19]
      if (~io_din) begin // @[Debouncer.scala 52:20]
        stateReg <= 2'h2; // @[Debouncer.scala 53:18]
      end
    end else if (2'h2 == stateReg) begin // @[Debouncer.scala 45:19]
      stateReg <= _GEN_3;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Debouncer(
  input   clock,
  input   reset,
  input   io_in,
  output  io_out
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  fsm_clock; // @[Debouncer.scala 12:21]
  wire  fsm_reset; // @[Debouncer.scala 12:21]
  wire  fsm_io_din; // @[Debouncer.scala 12:21]
  wire [26:0] fsm_io_countReg; // @[Debouncer.scala 12:21]
  wire  fsm_io_dout; // @[Debouncer.scala 12:21]
  wire  fsm_io_runTimer; // @[Debouncer.scala 12:21]
  reg [26:0] countReg; // @[Debouncer.scala 10:27]
  wire [26:0] _countReg_T_1 = countReg + 27'h1; // @[Debouncer.scala 18:28]
  debounceFsm fsm ( // @[Debouncer.scala 12:21]
    .clock(fsm_clock),
    .reset(fsm_reset),
    .io_din(fsm_io_din),
    .io_countReg(fsm_io_countReg),
    .io_dout(fsm_io_dout),
    .io_runTimer(fsm_io_runTimer)
  );
  assign io_out = fsm_io_dout; // @[Debouncer.scala 15:12]
  assign fsm_clock = clock;
  assign fsm_reset = reset;
  assign fsm_io_din = io_in; // @[Debouncer.scala 13:16]
  assign fsm_io_countReg = countReg; // @[Debouncer.scala 14:21]
  always @(posedge clock) begin
    if (reset) begin // @[Debouncer.scala 10:27]
      countReg <= 27'h0; // @[Debouncer.scala 10:27]
    end else if (fsm_io_runTimer) begin // @[Debouncer.scala 17:26]
      countReg <= _countReg_T_1; // @[Debouncer.scala 18:16]
    end else begin
      countReg <= 27'h0; // @[Debouncer.scala 20:16]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  countReg = _RAND_0[26:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module dataPath(
  input        clock,
  input        reset,
  input  [4:0] io_price,
  input        io_coin2,
  input        io_coin5,
  input        io_sub,
  input        io_add,
  input        io_alarm,
  output [6:0] io_sum,
  output       io_coin,
  output       io_isEmpty,
  output [6:0] io_customOut_0,
  output [6:0] io_customOut_1,
  output [6:0] io_customOut_2,
  output [6:0] io_customOut_3
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
`endif // RANDOMIZE_REG_INIT
  reg [6:0] sumReg; // @[VendingMachine.scala 95:23]
  reg [7:0] numCanReg; // @[VendingMachine.scala 97:26]
  wire [2:0] _GEN_0 = io_coin5 ? 3'h5 : 3'h0; // @[VendingMachine.scala 101:35 102:13 92:28]
  wire [2:0] coinVal = io_coin2 ? 3'h2 : _GEN_0; // @[VendingMachine.scala 100:13 99:28]
  wire [6:0] _GEN_145 = {{4'd0}, coinVal}; // @[VendingMachine.scala 109:22]
  wire [6:0] _sumReg_T_1 = sumReg + _GEN_145; // @[VendingMachine.scala 109:22]
  wire [6:0] _GEN_146 = {{2'd0}, io_price}; // @[VendingMachine.scala 111:22]
  wire [6:0] _sumReg_T_3 = sumReg - _GEN_146; // @[VendingMachine.scala 111:22]
  wire [7:0] _numCanReg_T_1 = numCanReg - 8'h1; // @[VendingMachine.scala 112:28]
  reg [31:0] scrollReg; // @[VendingMachine.scala 115:26]
  reg [3:0] selector1; // @[VendingMachine.scala 118:28]
  reg [3:0] selector2; // @[VendingMachine.scala 119:28]
  reg [3:0] selector3; // @[VendingMachine.scala 120:28]
  reg [3:0] selector4; // @[VendingMachine.scala 121:28]
  wire [31:0] _scrollReg_T_1 = scrollReg + 32'h1; // @[VendingMachine.scala 122:28]
  wire  _T_8 = scrollReg == 32'h2faf080; // @[VendingMachine.scala 123:20]
  wire [3:0] _selector1_T_1 = selector1 + 4'h1; // @[VendingMachine.scala 125:30]
  wire [3:0] _selector2_T_1 = selector2 + 4'h1; // @[VendingMachine.scala 126:30]
  wire [3:0] _selector3_T_1 = selector3 + 4'h1; // @[VendingMachine.scala 127:30]
  wire [3:0] _selector4_T_1 = selector4 + 4'h1; // @[VendingMachine.scala 128:30]
  wire [4:0] _GEN_147 = {{1'd0}, selector1}; // @[VendingMachine.scala 129:22]
  wire [4:0] _GEN_148 = {{1'd0}, selector2}; // @[VendingMachine.scala 130:22]
  wire [4:0] _GEN_149 = {{1'd0}, selector3}; // @[VendingMachine.scala 131:22]
  wire [4:0] _GEN_150 = {{1'd0}, selector4}; // @[VendingMachine.scala 132:22]
  wire [31:0] _GEN_12 = scrollReg == 32'h2faf080 ? 32'h0 : _scrollReg_T_1; // @[VendingMachine.scala 122:15 123:37 124:17]
  wire [6:0] _GEN_20 = 4'h3 == selector1 ? 7'h54 : 7'h0; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_21 = 4'h4 == selector1 ? 7'h3f : _GEN_20; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_22 = 4'h5 == selector1 ? 7'h0 : _GEN_21; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_23 = 4'h6 == selector1 ? 7'h39 : _GEN_22; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_24 = 4'h7 == selector1 ? 7'h77 : _GEN_23; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_25 = 4'h8 == selector1 ? 7'h54 : _GEN_24; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_26 = 4'h9 == selector1 ? 7'h6d : _GEN_25; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_27 = 4'ha == selector1 ? 7'h0 : _GEN_26; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_28 = 4'hb == selector1 ? 7'h38 : _GEN_27; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_29 = 4'hc == selector1 ? 7'h79 : _GEN_28; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_30 = 4'hd == selector1 ? 7'h71 : _GEN_29; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_31 = 4'he == selector1 ? 7'h78 : _GEN_30; // @[VendingMachine.scala 138:{21,21}]
  wire [6:0] _GEN_35 = 4'h3 == selector2 ? 7'h54 : 7'h0; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_36 = 4'h4 == selector2 ? 7'h3f : _GEN_35; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_37 = 4'h5 == selector2 ? 7'h0 : _GEN_36; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_38 = 4'h6 == selector2 ? 7'h39 : _GEN_37; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_39 = 4'h7 == selector2 ? 7'h77 : _GEN_38; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_40 = 4'h8 == selector2 ? 7'h54 : _GEN_39; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_41 = 4'h9 == selector2 ? 7'h6d : _GEN_40; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_42 = 4'ha == selector2 ? 7'h0 : _GEN_41; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_43 = 4'hb == selector2 ? 7'h38 : _GEN_42; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_44 = 4'hc == selector2 ? 7'h79 : _GEN_43; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_45 = 4'hd == selector2 ? 7'h71 : _GEN_44; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_46 = 4'he == selector2 ? 7'h78 : _GEN_45; // @[VendingMachine.scala 139:{21,21}]
  wire [6:0] _GEN_50 = 4'h3 == selector3 ? 7'h54 : 7'h0; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_51 = 4'h4 == selector3 ? 7'h3f : _GEN_50; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_52 = 4'h5 == selector3 ? 7'h0 : _GEN_51; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_53 = 4'h6 == selector3 ? 7'h39 : _GEN_52; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_54 = 4'h7 == selector3 ? 7'h77 : _GEN_53; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_55 = 4'h8 == selector3 ? 7'h54 : _GEN_54; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_56 = 4'h9 == selector3 ? 7'h6d : _GEN_55; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_57 = 4'ha == selector3 ? 7'h0 : _GEN_56; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_58 = 4'hb == selector3 ? 7'h38 : _GEN_57; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_59 = 4'hc == selector3 ? 7'h79 : _GEN_58; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_60 = 4'hd == selector3 ? 7'h71 : _GEN_59; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_61 = 4'he == selector3 ? 7'h78 : _GEN_60; // @[VendingMachine.scala 140:{21,21}]
  wire [6:0] _GEN_65 = 4'h3 == selector4 ? 7'h54 : 7'h0; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_66 = 4'h4 == selector4 ? 7'h3f : _GEN_65; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_67 = 4'h5 == selector4 ? 7'h0 : _GEN_66; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_68 = 4'h6 == selector4 ? 7'h39 : _GEN_67; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_69 = 4'h7 == selector4 ? 7'h77 : _GEN_68; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_70 = 4'h8 == selector4 ? 7'h54 : _GEN_69; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_71 = 4'h9 == selector4 ? 7'h6d : _GEN_70; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_72 = 4'ha == selector4 ? 7'h0 : _GEN_71; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_73 = 4'hb == selector4 ? 7'h38 : _GEN_72; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_74 = 4'hc == selector4 ? 7'h79 : _GEN_73; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_75 = 4'hd == selector4 ? 7'h71 : _GEN_74; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_76 = 4'he == selector4 ? 7'h78 : _GEN_75; // @[VendingMachine.scala 141:{21,21}]
  wire [6:0] _GEN_79 = numCanReg == 8'h0 ? _GEN_31 : 7'h0; // @[VendingMachine.scala 116:26 138:21 89:21]
  wire [6:0] _GEN_80 = numCanReg == 8'h0 ? _GEN_46 : 7'h0; // @[VendingMachine.scala 116:26 139:21 89:21]
  wire [6:0] _GEN_81 = numCanReg == 8'h0 ? _GEN_61 : 7'h0; // @[VendingMachine.scala 116:26 140:21 89:21]
  wire [6:0] _GEN_82 = numCanReg == 8'h0 ? _GEN_76 : 7'h0; // @[VendingMachine.scala 116:26 141:21 89:21]
  reg [3:0] selector1_1; // @[VendingMachine.scala 146:28]
  reg [3:0] selector2_1; // @[VendingMachine.scala 147:28]
  reg [3:0] selector3_1; // @[VendingMachine.scala 148:28]
  reg [3:0] selector4_1; // @[VendingMachine.scala 149:28]
  wire [3:0] _selector1_T_3 = selector1_1 + 4'h1; // @[VendingMachine.scala 153:30]
  wire [3:0] _selector2_T_3 = selector2_1 + 4'h1; // @[VendingMachine.scala 154:30]
  wire [3:0] _selector3_T_3 = selector3_1 + 4'h1; // @[VendingMachine.scala 155:30]
  wire [3:0] _selector4_T_3 = selector4_1 + 4'h1; // @[VendingMachine.scala 156:30]
  wire [4:0] _GEN_151 = {{1'd0}, selector1_1}; // @[VendingMachine.scala 157:22]
  wire [4:0] _GEN_152 = {{1'd0}, selector2_1}; // @[VendingMachine.scala 158:22]
  wire [4:0] _GEN_153 = {{1'd0}, selector3_1}; // @[VendingMachine.scala 159:22]
  wire [4:0] _GEN_154 = {{1'd0}, selector4_1}; // @[VendingMachine.scala 160:22]
  wire [6:0] _GEN_95 = 4'h3 == selector1_1 ? 7'h6e : 7'h0; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_96 = 4'h4 == selector1_1 ? 7'h3f : _GEN_95; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_97 = 4'h5 == selector1_1 ? 7'h3e : _GEN_96; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_98 = 4'h6 == selector1_1 ? 7'h0 : _GEN_97; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_99 = 4'h7 == selector1_1 ? 7'h73 : _GEN_98; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_100 = 4'h8 == selector1_1 ? 7'h3f : _GEN_99; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_101 = 4'h9 == selector1_1 ? 7'h3f : _GEN_100; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_102 = 4'ha == selector1_1 ? 7'h50 : _GEN_101; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_103 = 4'hb == selector1_1 ? 7'hb : _GEN_102; // @[VendingMachine.scala 165:{21,21}]
  wire [6:0] _GEN_107 = 4'h3 == selector2_1 ? 7'h6e : 7'h0; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_108 = 4'h4 == selector2_1 ? 7'h3f : _GEN_107; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_109 = 4'h5 == selector2_1 ? 7'h3e : _GEN_108; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_110 = 4'h6 == selector2_1 ? 7'h0 : _GEN_109; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_111 = 4'h7 == selector2_1 ? 7'h73 : _GEN_110; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_112 = 4'h8 == selector2_1 ? 7'h3f : _GEN_111; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_113 = 4'h9 == selector2_1 ? 7'h3f : _GEN_112; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_114 = 4'ha == selector2_1 ? 7'h50 : _GEN_113; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_115 = 4'hb == selector2_1 ? 7'hb : _GEN_114; // @[VendingMachine.scala 166:{21,21}]
  wire [6:0] _GEN_119 = 4'h3 == selector3_1 ? 7'h6e : 7'h0; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_120 = 4'h4 == selector3_1 ? 7'h3f : _GEN_119; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_121 = 4'h5 == selector3_1 ? 7'h3e : _GEN_120; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_122 = 4'h6 == selector3_1 ? 7'h0 : _GEN_121; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_123 = 4'h7 == selector3_1 ? 7'h73 : _GEN_122; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_124 = 4'h8 == selector3_1 ? 7'h3f : _GEN_123; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_125 = 4'h9 == selector3_1 ? 7'h3f : _GEN_124; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_126 = 4'ha == selector3_1 ? 7'h50 : _GEN_125; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_127 = 4'hb == selector3_1 ? 7'hb : _GEN_126; // @[VendingMachine.scala 167:{21,21}]
  wire [6:0] _GEN_131 = 4'h3 == selector4_1 ? 7'h6e : 7'h0; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_132 = 4'h4 == selector4_1 ? 7'h3f : _GEN_131; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_133 = 4'h5 == selector4_1 ? 7'h3e : _GEN_132; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_134 = 4'h6 == selector4_1 ? 7'h0 : _GEN_133; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_135 = 4'h7 == selector4_1 ? 7'h73 : _GEN_134; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_136 = 4'h8 == selector4_1 ? 7'h3f : _GEN_135; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_137 = 4'h9 == selector4_1 ? 7'h3f : _GEN_136; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_138 = 4'ha == selector4_1 ? 7'h50 : _GEN_137; // @[VendingMachine.scala 168:{21,21}]
  wire [6:0] _GEN_139 = 4'hb == selector4_1 ? 7'hb : _GEN_138; // @[VendingMachine.scala 168:{21,21}]
  assign io_sum = sumReg; // @[VendingMachine.scala 172:10]
  assign io_coin = io_coin2 | io_coin5; // @[VendingMachine.scala 173:24]
  assign io_isEmpty = numCanReg == 8'h0; // @[VendingMachine.scala 116:18]
  assign io_customOut_0 = io_alarm ? _GEN_139 : _GEN_82; // @[VendingMachine.scala 145:28 168:21]
  assign io_customOut_1 = io_alarm ? _GEN_127 : _GEN_81; // @[VendingMachine.scala 145:28 167:21]
  assign io_customOut_2 = io_alarm ? _GEN_115 : _GEN_80; // @[VendingMachine.scala 145:28 166:21]
  assign io_customOut_3 = io_alarm ? _GEN_103 : _GEN_79; // @[VendingMachine.scala 145:28 165:21]
  always @(posedge clock) begin
    if (reset) begin // @[VendingMachine.scala 95:23]
      sumReg <= 7'h0; // @[VendingMachine.scala 95:23]
    end else if (!(~io_sub & ~io_add)) begin // @[VendingMachine.scala 106:51]
      if (io_add) begin // @[VendingMachine.scala 108:32]
        sumReg <= _sumReg_T_1; // @[VendingMachine.scala 109:12]
      end else if (io_sub) begin // @[VendingMachine.scala 110:33]
        sumReg <= _sumReg_T_3; // @[VendingMachine.scala 111:12]
      end
    end
    if (reset) begin // @[VendingMachine.scala 97:26]
      numCanReg <= 8'h3; // @[VendingMachine.scala 97:26]
    end else if (!(~io_sub & ~io_add)) begin // @[VendingMachine.scala 106:51]
      if (!(io_add)) begin // @[VendingMachine.scala 108:32]
        if (io_sub) begin // @[VendingMachine.scala 110:33]
          numCanReg <= _numCanReg_T_1; // @[VendingMachine.scala 112:15]
        end
      end
    end
    if (reset) begin // @[VendingMachine.scala 115:26]
      scrollReg <= 32'h0; // @[VendingMachine.scala 115:26]
    end else if (io_alarm) begin // @[VendingMachine.scala 145:28]
      scrollReg <= _GEN_12;
    end else if (numCanReg == 8'h0) begin // @[VendingMachine.scala 116:26]
      scrollReg <= _GEN_12;
    end
    if (reset) begin // @[VendingMachine.scala 118:28]
      selector1 <= 4'h0; // @[VendingMachine.scala 118:28]
    end else if (scrollReg == 32'h2faf080) begin // @[VendingMachine.scala 123:37]
      if (_GEN_147 == 5'h11) begin // @[VendingMachine.scala 129:31]
        selector1 <= 4'h0; // @[VendingMachine.scala 129:42]
      end else begin
        selector1 <= _selector1_T_1; // @[VendingMachine.scala 125:17]
      end
    end
    if (reset) begin // @[VendingMachine.scala 119:28]
      selector2 <= 4'h1; // @[VendingMachine.scala 119:28]
    end else if (scrollReg == 32'h2faf080) begin // @[VendingMachine.scala 123:37]
      if (_GEN_148 == 5'h11) begin // @[VendingMachine.scala 130:31]
        selector2 <= 4'h0; // @[VendingMachine.scala 130:42]
      end else begin
        selector2 <= _selector2_T_1; // @[VendingMachine.scala 126:17]
      end
    end
    if (reset) begin // @[VendingMachine.scala 120:28]
      selector3 <= 4'h2; // @[VendingMachine.scala 120:28]
    end else if (scrollReg == 32'h2faf080) begin // @[VendingMachine.scala 123:37]
      if (_GEN_149 == 5'h11) begin // @[VendingMachine.scala 131:31]
        selector3 <= 4'h0; // @[VendingMachine.scala 131:42]
      end else begin
        selector3 <= _selector3_T_1; // @[VendingMachine.scala 127:17]
      end
    end
    if (reset) begin // @[VendingMachine.scala 121:28]
      selector4 <= 4'h3; // @[VendingMachine.scala 121:28]
    end else if (scrollReg == 32'h2faf080) begin // @[VendingMachine.scala 123:37]
      if (_GEN_150 == 5'h11) begin // @[VendingMachine.scala 132:31]
        selector4 <= 4'h0; // @[VendingMachine.scala 132:42]
      end else begin
        selector4 <= _selector4_T_1; // @[VendingMachine.scala 128:17]
      end
    end
    if (reset) begin // @[VendingMachine.scala 146:28]
      selector1_1 <= 4'h0; // @[VendingMachine.scala 146:28]
    end else if (_T_8) begin // @[VendingMachine.scala 151:37]
      if (_GEN_151 == 5'h11) begin // @[VendingMachine.scala 157:31]
        selector1_1 <= 4'h0; // @[VendingMachine.scala 157:42]
      end else begin
        selector1_1 <= _selector1_T_3; // @[VendingMachine.scala 153:17]
      end
    end
    if (reset) begin // @[VendingMachine.scala 147:28]
      selector2_1 <= 4'h1; // @[VendingMachine.scala 147:28]
    end else if (_T_8) begin // @[VendingMachine.scala 151:37]
      if (_GEN_152 == 5'h11) begin // @[VendingMachine.scala 158:31]
        selector2_1 <= 4'h0; // @[VendingMachine.scala 158:42]
      end else begin
        selector2_1 <= _selector2_T_3; // @[VendingMachine.scala 154:17]
      end
    end
    if (reset) begin // @[VendingMachine.scala 148:28]
      selector3_1 <= 4'h2; // @[VendingMachine.scala 148:28]
    end else if (_T_8) begin // @[VendingMachine.scala 151:37]
      if (_GEN_153 == 5'h11) begin // @[VendingMachine.scala 159:31]
        selector3_1 <= 4'h0; // @[VendingMachine.scala 159:42]
      end else begin
        selector3_1 <= _selector3_T_3; // @[VendingMachine.scala 155:17]
      end
    end
    if (reset) begin // @[VendingMachine.scala 149:28]
      selector4_1 <= 4'h3; // @[VendingMachine.scala 149:28]
    end else if (_T_8) begin // @[VendingMachine.scala 151:37]
      if (_GEN_154 == 5'h11) begin // @[VendingMachine.scala 160:31]
        selector4_1 <= 4'h0; // @[VendingMachine.scala 160:42]
      end else begin
        selector4_1 <= _selector4_T_3; // @[VendingMachine.scala 156:17]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  sumReg = _RAND_0[6:0];
  _RAND_1 = {1{`RANDOM}};
  numCanReg = _RAND_1[7:0];
  _RAND_2 = {1{`RANDOM}};
  scrollReg = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  selector1 = _RAND_3[3:0];
  _RAND_4 = {1{`RANDOM}};
  selector2 = _RAND_4[3:0];
  _RAND_5 = {1{`RANDOM}};
  selector3 = _RAND_5[3:0];
  _RAND_6 = {1{`RANDOM}};
  selector4 = _RAND_6[3:0];
  _RAND_7 = {1{`RANDOM}};
  selector1_1 = _RAND_7[3:0];
  _RAND_8 = {1{`RANDOM}};
  selector2_1 = _RAND_8[3:0];
  _RAND_9 = {1{`RANDOM}};
  selector3_1 = _RAND_9[3:0];
  _RAND_10 = {1{`RANDOM}};
  selector4_1 = _RAND_10[3:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module fsm(
  input        clock,
  input        reset,
  input  [4:0] io_price,
  input  [7:0] io_sum,
  input        io_buy,
  input        io_coin,
  input        io_empty,
  output       io_sub,
  output       io_add,
  output       io_alarm,
  output       io_releaseCan
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] stateReg; // @[VendingMachine.scala 198:25]
  wire [7:0] _GEN_13 = {{3'd0}, io_price}; // @[VendingMachine.scala 203:29]
  wire [2:0] _GEN_0 = io_empty ? 3'h6 : stateReg; // @[VendingMachine.scala 209:28 210:18 198:25]
  wire [2:0] _GEN_1 = io_coin ? 3'h4 : _GEN_0; // @[VendingMachine.scala 207:26 208:18]
  wire [2:0] _GEN_4 = ~io_buy ? 3'h0 : stateReg; // @[VendingMachine.scala 217:31 218:17 198:25]
  wire [2:0] _GEN_6 = ~io_coin ? 3'h0 : stateReg; // @[VendingMachine.scala 230:32 231:17 198:25]
  wire [2:0] _GEN_7 = 3'h5 == stateReg ? _GEN_6 : stateReg; // @[VendingMachine.scala 201:19 198:25]
  wire [2:0] _GEN_8 = 3'h4 == stateReg ? 3'h5 : _GEN_7; // @[VendingMachine.scala 201:19 227:16]
  wire [2:0] _GEN_9 = 3'h3 == stateReg ? _GEN_4 : _GEN_8; // @[VendingMachine.scala 201:19]
  wire  _io_sub_T = stateReg == 3'h1; // @[VendingMachine.scala 240:21]
  assign io_sub = stateReg == 3'h1; // @[VendingMachine.scala 240:21]
  assign io_add = stateReg == 3'h4; // @[VendingMachine.scala 241:22]
  assign io_alarm = stateReg == 3'h3; // @[VendingMachine.scala 242:24]
  assign io_releaseCan = stateReg == 3'h2 | _io_sub_T; // @[VendingMachine.scala 243:42]
  always @(posedge clock) begin
    if (reset) begin // @[VendingMachine.scala 198:25]
      stateReg <= 3'h0; // @[VendingMachine.scala 198:25]
    end else if (3'h0 == stateReg) begin // @[VendingMachine.scala 201:19]
      if (io_buy & io_sum >= _GEN_13) begin // @[VendingMachine.scala 203:41]
        stateReg <= 3'h1; // @[VendingMachine.scala 204:18]
      end else if (io_buy & io_sum < _GEN_13) begin // @[VendingMachine.scala 205:47]
        stateReg <= 3'h3; // @[VendingMachine.scala 206:18]
      end else begin
        stateReg <= _GEN_1;
      end
    end else if (3'h1 == stateReg) begin // @[VendingMachine.scala 201:19]
      stateReg <= 3'h2; // @[VendingMachine.scala 214:15]
    end else if (3'h2 == stateReg) begin // @[VendingMachine.scala 201:19]
      stateReg <= _GEN_4;
    end else begin
      stateReg <= _GEN_9;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  stateReg = _RAND_0[2:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module BcdTable(
  input  [7:0] io_address,
  output [7:0] io_data
);
  wire [7:0] _GEN_1 = 7'h1 == io_address[6:0] ? 8'h1 : 8'h0; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_2 = 7'h2 == io_address[6:0] ? 8'h2 : _GEN_1; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_3 = 7'h3 == io_address[6:0] ? 8'h3 : _GEN_2; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_4 = 7'h4 == io_address[6:0] ? 8'h4 : _GEN_3; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_5 = 7'h5 == io_address[6:0] ? 8'h5 : _GEN_4; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_6 = 7'h6 == io_address[6:0] ? 8'h6 : _GEN_5; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_7 = 7'h7 == io_address[6:0] ? 8'h7 : _GEN_6; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_8 = 7'h8 == io_address[6:0] ? 8'h8 : _GEN_7; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_9 = 7'h9 == io_address[6:0] ? 8'h9 : _GEN_8; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_10 = 7'ha == io_address[6:0] ? 8'h10 : _GEN_9; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_11 = 7'hb == io_address[6:0] ? 8'h11 : _GEN_10; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_12 = 7'hc == io_address[6:0] ? 8'h12 : _GEN_11; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_13 = 7'hd == io_address[6:0] ? 8'h13 : _GEN_12; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_14 = 7'he == io_address[6:0] ? 8'h14 : _GEN_13; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_15 = 7'hf == io_address[6:0] ? 8'h15 : _GEN_14; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_16 = 7'h10 == io_address[6:0] ? 8'h16 : _GEN_15; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_17 = 7'h11 == io_address[6:0] ? 8'h17 : _GEN_16; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_18 = 7'h12 == io_address[6:0] ? 8'h18 : _GEN_17; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_19 = 7'h13 == io_address[6:0] ? 8'h19 : _GEN_18; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_20 = 7'h14 == io_address[6:0] ? 8'h20 : _GEN_19; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_21 = 7'h15 == io_address[6:0] ? 8'h21 : _GEN_20; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_22 = 7'h16 == io_address[6:0] ? 8'h22 : _GEN_21; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_23 = 7'h17 == io_address[6:0] ? 8'h23 : _GEN_22; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_24 = 7'h18 == io_address[6:0] ? 8'h24 : _GEN_23; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_25 = 7'h19 == io_address[6:0] ? 8'h25 : _GEN_24; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_26 = 7'h1a == io_address[6:0] ? 8'h26 : _GEN_25; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_27 = 7'h1b == io_address[6:0] ? 8'h27 : _GEN_26; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_28 = 7'h1c == io_address[6:0] ? 8'h28 : _GEN_27; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_29 = 7'h1d == io_address[6:0] ? 8'h29 : _GEN_28; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_30 = 7'h1e == io_address[6:0] ? 8'h30 : _GEN_29; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_31 = 7'h1f == io_address[6:0] ? 8'h31 : _GEN_30; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_32 = 7'h20 == io_address[6:0] ? 8'h32 : _GEN_31; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_33 = 7'h21 == io_address[6:0] ? 8'h33 : _GEN_32; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_34 = 7'h22 == io_address[6:0] ? 8'h34 : _GEN_33; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_35 = 7'h23 == io_address[6:0] ? 8'h35 : _GEN_34; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_36 = 7'h24 == io_address[6:0] ? 8'h36 : _GEN_35; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_37 = 7'h25 == io_address[6:0] ? 8'h37 : _GEN_36; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_38 = 7'h26 == io_address[6:0] ? 8'h38 : _GEN_37; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_39 = 7'h27 == io_address[6:0] ? 8'h39 : _GEN_38; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_40 = 7'h28 == io_address[6:0] ? 8'h40 : _GEN_39; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_41 = 7'h29 == io_address[6:0] ? 8'h41 : _GEN_40; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_42 = 7'h2a == io_address[6:0] ? 8'h42 : _GEN_41; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_43 = 7'h2b == io_address[6:0] ? 8'h43 : _GEN_42; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_44 = 7'h2c == io_address[6:0] ? 8'h44 : _GEN_43; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_45 = 7'h2d == io_address[6:0] ? 8'h45 : _GEN_44; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_46 = 7'h2e == io_address[6:0] ? 8'h46 : _GEN_45; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_47 = 7'h2f == io_address[6:0] ? 8'h47 : _GEN_46; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_48 = 7'h30 == io_address[6:0] ? 8'h48 : _GEN_47; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_49 = 7'h31 == io_address[6:0] ? 8'h49 : _GEN_48; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_50 = 7'h32 == io_address[6:0] ? 8'h50 : _GEN_49; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_51 = 7'h33 == io_address[6:0] ? 8'h51 : _GEN_50; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_52 = 7'h34 == io_address[6:0] ? 8'h52 : _GEN_51; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_53 = 7'h35 == io_address[6:0] ? 8'h53 : _GEN_52; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_54 = 7'h36 == io_address[6:0] ? 8'h54 : _GEN_53; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_55 = 7'h37 == io_address[6:0] ? 8'h55 : _GEN_54; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_56 = 7'h38 == io_address[6:0] ? 8'h56 : _GEN_55; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_57 = 7'h39 == io_address[6:0] ? 8'h57 : _GEN_56; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_58 = 7'h3a == io_address[6:0] ? 8'h58 : _GEN_57; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_59 = 7'h3b == io_address[6:0] ? 8'h59 : _GEN_58; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_60 = 7'h3c == io_address[6:0] ? 8'h60 : _GEN_59; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_61 = 7'h3d == io_address[6:0] ? 8'h61 : _GEN_60; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_62 = 7'h3e == io_address[6:0] ? 8'h62 : _GEN_61; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_63 = 7'h3f == io_address[6:0] ? 8'h63 : _GEN_62; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_64 = 7'h40 == io_address[6:0] ? 8'h64 : _GEN_63; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_65 = 7'h41 == io_address[6:0] ? 8'h65 : _GEN_64; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_66 = 7'h42 == io_address[6:0] ? 8'h66 : _GEN_65; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_67 = 7'h43 == io_address[6:0] ? 8'h67 : _GEN_66; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_68 = 7'h44 == io_address[6:0] ? 8'h68 : _GEN_67; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_69 = 7'h45 == io_address[6:0] ? 8'h69 : _GEN_68; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_70 = 7'h46 == io_address[6:0] ? 8'h70 : _GEN_69; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_71 = 7'h47 == io_address[6:0] ? 8'h71 : _GEN_70; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_72 = 7'h48 == io_address[6:0] ? 8'h72 : _GEN_71; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_73 = 7'h49 == io_address[6:0] ? 8'h73 : _GEN_72; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_74 = 7'h4a == io_address[6:0] ? 8'h74 : _GEN_73; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_75 = 7'h4b == io_address[6:0] ? 8'h75 : _GEN_74; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_76 = 7'h4c == io_address[6:0] ? 8'h76 : _GEN_75; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_77 = 7'h4d == io_address[6:0] ? 8'h77 : _GEN_76; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_78 = 7'h4e == io_address[6:0] ? 8'h78 : _GEN_77; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_79 = 7'h4f == io_address[6:0] ? 8'h79 : _GEN_78; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_80 = 7'h50 == io_address[6:0] ? 8'h80 : _GEN_79; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_81 = 7'h51 == io_address[6:0] ? 8'h81 : _GEN_80; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_82 = 7'h52 == io_address[6:0] ? 8'h82 : _GEN_81; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_83 = 7'h53 == io_address[6:0] ? 8'h83 : _GEN_82; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_84 = 7'h54 == io_address[6:0] ? 8'h84 : _GEN_83; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_85 = 7'h55 == io_address[6:0] ? 8'h85 : _GEN_84; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_86 = 7'h56 == io_address[6:0] ? 8'h86 : _GEN_85; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_87 = 7'h57 == io_address[6:0] ? 8'h87 : _GEN_86; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_88 = 7'h58 == io_address[6:0] ? 8'h88 : _GEN_87; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_89 = 7'h59 == io_address[6:0] ? 8'h89 : _GEN_88; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_90 = 7'h5a == io_address[6:0] ? 8'h90 : _GEN_89; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_91 = 7'h5b == io_address[6:0] ? 8'h91 : _GEN_90; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_92 = 7'h5c == io_address[6:0] ? 8'h92 : _GEN_91; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_93 = 7'h5d == io_address[6:0] ? 8'h93 : _GEN_92; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_94 = 7'h5e == io_address[6:0] ? 8'h94 : _GEN_93; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_95 = 7'h5f == io_address[6:0] ? 8'h95 : _GEN_94; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_96 = 7'h60 == io_address[6:0] ? 8'h96 : _GEN_95; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_97 = 7'h61 == io_address[6:0] ? 8'h97 : _GEN_96; // @[DisplayMultiplexer.scala 78:{11,11}]
  wire [7:0] _GEN_98 = 7'h62 == io_address[6:0] ? 8'h98 : _GEN_97; // @[DisplayMultiplexer.scala 78:{11,11}]
  assign io_data = 7'h63 == io_address[6:0] ? 8'h99 : _GEN_98; // @[DisplayMultiplexer.scala 78:{11,11}]
endmodule
module SevenSegDec(
  input  [3:0] io_in,
  output [6:0] io_out,
  input        io_custom,
  input  [6:0] io_customIn
);
  wire [6:0] _GEN_0 = 4'hf == io_in ? 7'h71 : 7'h0; // @[SevenSegDec.scala 15:17 31:23 12:27]
  wire [6:0] _GEN_1 = 4'he == io_in ? 7'h79 : _GEN_0; // @[SevenSegDec.scala 15:17 30:23]
  wire [6:0] _GEN_2 = 4'hd == io_in ? 7'h5e : _GEN_1; // @[SevenSegDec.scala 15:17 29:23]
  wire [6:0] _GEN_3 = 4'hc == io_in ? 7'h39 : _GEN_2; // @[SevenSegDec.scala 15:17 28:23]
  wire [6:0] _GEN_4 = 4'hb == io_in ? 7'h7c : _GEN_3; // @[SevenSegDec.scala 15:17 27:23]
  wire [6:0] _GEN_5 = 4'ha == io_in ? 7'h77 : _GEN_4; // @[SevenSegDec.scala 15:17 26:23]
  wire [6:0] _GEN_6 = 4'h9 == io_in ? 7'h67 : _GEN_5; // @[SevenSegDec.scala 15:17 25:22]
  wire [6:0] _GEN_7 = 4'h8 == io_in ? 7'h7f : _GEN_6; // @[SevenSegDec.scala 15:17 24:22]
  wire [6:0] _GEN_8 = 4'h7 == io_in ? 7'h7 : _GEN_7; // @[SevenSegDec.scala 15:17 23:22]
  wire [6:0] _GEN_9 = 4'h6 == io_in ? 7'h7d : _GEN_8; // @[SevenSegDec.scala 15:17 22:22]
  wire [6:0] _GEN_10 = 4'h5 == io_in ? 7'h6d : _GEN_9; // @[SevenSegDec.scala 15:17 21:22]
  wire [6:0] _GEN_11 = 4'h4 == io_in ? 7'h66 : _GEN_10; // @[SevenSegDec.scala 15:17 20:22]
  wire [6:0] _GEN_12 = 4'h3 == io_in ? 7'h4f : _GEN_11; // @[SevenSegDec.scala 15:17 19:22]
  wire [6:0] _GEN_13 = 4'h2 == io_in ? 7'h5b : _GEN_12; // @[SevenSegDec.scala 15:17 18:22]
  wire [6:0] _GEN_14 = 4'h1 == io_in ? 7'h30 : _GEN_13; // @[SevenSegDec.scala 15:17 17:22]
  wire [6:0] _GEN_15 = 4'h0 == io_in ? 7'h3f : _GEN_14; // @[SevenSegDec.scala 15:17 16:22]
  wire [6:0] sevSeg = io_custom ? io_customIn : _GEN_15; // @[SevenSegDec.scala 33:{26,34}]
  assign io_out = ~sevSeg; // @[SevenSegDec.scala 36:13]
endmodule
module DisplayMultiplexer(
  input        clock,
  input        reset,
  input  [6:0] io_customIn_0,
  input  [6:0] io_customIn_1,
  input  [6:0] io_customIn_2,
  input  [6:0] io_customIn_3,
  input  [6:0] io_sum,
  input  [4:0] io_price,
  output [6:0] io_seg,
  output [3:0] io_an
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] table__io_address; // @[DisplayMultiplexer.scala 16:21]
  wire [7:0] table__io_data; // @[DisplayMultiplexer.scala 16:21]
  wire [3:0] decoder_io_in; // @[DisplayMultiplexer.scala 19:23]
  wire [6:0] decoder_io_out; // @[DisplayMultiplexer.scala 19:23]
  wire  decoder_io_custom; // @[DisplayMultiplexer.scala 19:23]
  wire [6:0] decoder_io_customIn; // @[DisplayMultiplexer.scala 19:23]
  reg [1:0] selectReg; // @[DisplayMultiplexer.scala 14:26]
  reg [16:0] tickCounterReg; // @[DisplayMultiplexer.scala 25:32]
  wire  tick = tickCounterReg == 17'h1869f; // @[DisplayMultiplexer.scala 26:29]
  wire [16:0] _tickCounterReg_T_1 = tickCounterReg + 17'h1; // @[DisplayMultiplexer.scala 27:36]
  wire [1:0] _selectReg_T_1 = selectReg + 2'h1; // @[DisplayMultiplexer.scala 31:28]
  wire [6:0] _GEN_2 = 2'h3 == selectReg ? io_sum : 7'h0; // @[DisplayMultiplexer.scala 17:20 34:21 48:24]
  wire [3:0] _GEN_3 = 2'h3 == selectReg ? table__io_data[7:4] : 4'h0; // @[DisplayMultiplexer.scala 22:17 34:21 49:21]
  wire [6:0] _GEN_4 = 2'h2 == selectReg ? io_sum : _GEN_2; // @[DisplayMultiplexer.scala 34:21 44:24]
  wire [3:0] _GEN_5 = 2'h2 == selectReg ? table__io_data[3:0] : _GEN_3; // @[DisplayMultiplexer.scala 34:21 45:21]
  wire [6:0] _GEN_6 = 2'h1 == selectReg ? {{2'd0}, io_price} : _GEN_4; // @[DisplayMultiplexer.scala 34:21 40:24]
  wire [3:0] _GEN_7 = 2'h1 == selectReg ? table__io_data[7:4] : _GEN_5; // @[DisplayMultiplexer.scala 34:21 41:21]
  wire [6:0] _GEN_8 = 2'h0 == selectReg ? {{2'd0}, io_price} : _GEN_6; // @[DisplayMultiplexer.scala 34:21 36:24]
  wire [6:0] _GEN_11 = 2'h1 == selectReg ? io_customIn_1 : io_customIn_0; // @[DisplayMultiplexer.scala 56:{25,25}]
  wire [6:0] _GEN_12 = 2'h2 == selectReg ? io_customIn_2 : _GEN_11; // @[DisplayMultiplexer.scala 56:{25,25}]
  wire [6:0] _GEN_13 = 2'h3 == selectReg ? io_customIn_3 : _GEN_12; // @[DisplayMultiplexer.scala 56:{25,25}]
  wire [3:0] _io_an_T = 4'h1 << selectReg; // @[DisplayMultiplexer.scala 61:18]
  BcdTable table_ ( // @[DisplayMultiplexer.scala 16:21]
    .io_address(table__io_address),
    .io_data(table__io_data)
  );
  SevenSegDec decoder ( // @[DisplayMultiplexer.scala 19:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out),
    .io_custom(decoder_io_custom),
    .io_customIn(decoder_io_customIn)
  );
  assign io_seg = decoder_io_out; // @[DisplayMultiplexer.scala 13:27 23:10]
  assign io_an = ~_io_an_T; // @[DisplayMultiplexer.scala 61:12]
  assign table__io_address = {{1'd0}, _GEN_8};
  assign decoder_io_in = 2'h0 == selectReg ? table__io_data[3:0] : _GEN_7; // @[DisplayMultiplexer.scala 34:21 37:21]
  assign decoder_io_custom = io_customIn_0 != 7'h0 | io_customIn_1 != 7'h0 | io_customIn_2 != 7'h0 | io_customIn_3 != 7'h0
    ; // @[DisplayMultiplexer.scala 54:82]
  assign decoder_io_customIn = io_customIn_0 != 7'h0 | io_customIn_1 != 7'h0 | io_customIn_2 != 7'h0 | io_customIn_3 != 7'h0
     ? _GEN_13 : 7'h0; // @[DisplayMultiplexer.scala 54:107 21:23 56:25]
  always @(posedge clock) begin
    if (reset) begin // @[DisplayMultiplexer.scala 14:26]
      selectReg <= 2'h0; // @[DisplayMultiplexer.scala 14:26]
    end else if (tick) begin // @[DisplayMultiplexer.scala 29:15]
      selectReg <= _selectReg_T_1; // @[DisplayMultiplexer.scala 31:15]
    end
    if (reset) begin // @[DisplayMultiplexer.scala 25:32]
      tickCounterReg <= 17'h0; // @[DisplayMultiplexer.scala 25:32]
    end else if (tick) begin // @[DisplayMultiplexer.scala 29:15]
      tickCounterReg <= 17'h0; // @[DisplayMultiplexer.scala 30:20]
    end else begin
      tickCounterReg <= _tickCounterReg_T_1; // @[DisplayMultiplexer.scala 27:18]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  selectReg = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  tickCounterReg = _RAND_1[16:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module VendingMachine(
  input        clock,
  input        reset,
  input  [4:0] io_price,
  input        io_coin2Raw,
  input        io_coin5Raw,
  input        io_buyRaw,
  output       io_releaseCan,
  output       io_alarm,
  output [6:0] io_seg,
  output [3:0] io_an
);
  wire  coin2Deb_clock; // @[VendingMachine.scala 25:24]
  wire  coin2Deb_reset; // @[VendingMachine.scala 25:24]
  wire  coin2Deb_io_in; // @[VendingMachine.scala 25:24]
  wire  coin2Deb_io_out; // @[VendingMachine.scala 25:24]
  wire  coin5Deb_clock; // @[VendingMachine.scala 29:24]
  wire  coin5Deb_reset; // @[VendingMachine.scala 29:24]
  wire  coin5Deb_io_in; // @[VendingMachine.scala 29:24]
  wire  coin5Deb_io_out; // @[VendingMachine.scala 29:24]
  wire  buyDeb_clock; // @[VendingMachine.scala 33:22]
  wire  buyDeb_reset; // @[VendingMachine.scala 33:22]
  wire  buyDeb_io_in; // @[VendingMachine.scala 33:22]
  wire  buyDeb_io_out; // @[VendingMachine.scala 33:22]
  wire  dataPath_clock; // @[VendingMachine.scala 38:24]
  wire  dataPath_reset; // @[VendingMachine.scala 38:24]
  wire [4:0] dataPath_io_price; // @[VendingMachine.scala 38:24]
  wire  dataPath_io_coin2; // @[VendingMachine.scala 38:24]
  wire  dataPath_io_coin5; // @[VendingMachine.scala 38:24]
  wire  dataPath_io_sub; // @[VendingMachine.scala 38:24]
  wire  dataPath_io_add; // @[VendingMachine.scala 38:24]
  wire  dataPath_io_alarm; // @[VendingMachine.scala 38:24]
  wire [6:0] dataPath_io_sum; // @[VendingMachine.scala 38:24]
  wire  dataPath_io_coin; // @[VendingMachine.scala 38:24]
  wire  dataPath_io_isEmpty; // @[VendingMachine.scala 38:24]
  wire [6:0] dataPath_io_customOut_0; // @[VendingMachine.scala 38:24]
  wire [6:0] dataPath_io_customOut_1; // @[VendingMachine.scala 38:24]
  wire [6:0] dataPath_io_customOut_2; // @[VendingMachine.scala 38:24]
  wire [6:0] dataPath_io_customOut_3; // @[VendingMachine.scala 38:24]
  wire  fsm_clock; // @[VendingMachine.scala 39:19]
  wire  fsm_reset; // @[VendingMachine.scala 39:19]
  wire [4:0] fsm_io_price; // @[VendingMachine.scala 39:19]
  wire [7:0] fsm_io_sum; // @[VendingMachine.scala 39:19]
  wire  fsm_io_buy; // @[VendingMachine.scala 39:19]
  wire  fsm_io_coin; // @[VendingMachine.scala 39:19]
  wire  fsm_io_empty; // @[VendingMachine.scala 39:19]
  wire  fsm_io_sub; // @[VendingMachine.scala 39:19]
  wire  fsm_io_add; // @[VendingMachine.scala 39:19]
  wire  fsm_io_alarm; // @[VendingMachine.scala 39:19]
  wire  fsm_io_releaseCan; // @[VendingMachine.scala 39:19]
  wire  dispMux_clock; // @[VendingMachine.scala 58:23]
  wire  dispMux_reset; // @[VendingMachine.scala 58:23]
  wire [6:0] dispMux_io_customIn_0; // @[VendingMachine.scala 58:23]
  wire [6:0] dispMux_io_customIn_1; // @[VendingMachine.scala 58:23]
  wire [6:0] dispMux_io_customIn_2; // @[VendingMachine.scala 58:23]
  wire [6:0] dispMux_io_customIn_3; // @[VendingMachine.scala 58:23]
  wire [6:0] dispMux_io_sum; // @[VendingMachine.scala 58:23]
  wire [4:0] dispMux_io_price; // @[VendingMachine.scala 58:23]
  wire [6:0] dispMux_io_seg; // @[VendingMachine.scala 58:23]
  wire [3:0] dispMux_io_an; // @[VendingMachine.scala 58:23]
  Debouncer coin2Deb ( // @[VendingMachine.scala 25:24]
    .clock(coin2Deb_clock),
    .reset(coin2Deb_reset),
    .io_in(coin2Deb_io_in),
    .io_out(coin2Deb_io_out)
  );
  Debouncer coin5Deb ( // @[VendingMachine.scala 29:24]
    .clock(coin5Deb_clock),
    .reset(coin5Deb_reset),
    .io_in(coin5Deb_io_in),
    .io_out(coin5Deb_io_out)
  );
  Debouncer buyDeb ( // @[VendingMachine.scala 33:22]
    .clock(buyDeb_clock),
    .reset(buyDeb_reset),
    .io_in(buyDeb_io_in),
    .io_out(buyDeb_io_out)
  );
  dataPath dataPath ( // @[VendingMachine.scala 38:24]
    .clock(dataPath_clock),
    .reset(dataPath_reset),
    .io_price(dataPath_io_price),
    .io_coin2(dataPath_io_coin2),
    .io_coin5(dataPath_io_coin5),
    .io_sub(dataPath_io_sub),
    .io_add(dataPath_io_add),
    .io_alarm(dataPath_io_alarm),
    .io_sum(dataPath_io_sum),
    .io_coin(dataPath_io_coin),
    .io_isEmpty(dataPath_io_isEmpty),
    .io_customOut_0(dataPath_io_customOut_0),
    .io_customOut_1(dataPath_io_customOut_1),
    .io_customOut_2(dataPath_io_customOut_2),
    .io_customOut_3(dataPath_io_customOut_3)
  );
  fsm fsm ( // @[VendingMachine.scala 39:19]
    .clock(fsm_clock),
    .reset(fsm_reset),
    .io_price(fsm_io_price),
    .io_sum(fsm_io_sum),
    .io_buy(fsm_io_buy),
    .io_coin(fsm_io_coin),
    .io_empty(fsm_io_empty),
    .io_sub(fsm_io_sub),
    .io_add(fsm_io_add),
    .io_alarm(fsm_io_alarm),
    .io_releaseCan(fsm_io_releaseCan)
  );
  DisplayMultiplexer dispMux ( // @[VendingMachine.scala 58:23]
    .clock(dispMux_clock),
    .reset(dispMux_reset),
    .io_customIn_0(dispMux_io_customIn_0),
    .io_customIn_1(dispMux_io_customIn_1),
    .io_customIn_2(dispMux_io_customIn_2),
    .io_customIn_3(dispMux_io_customIn_3),
    .io_sum(dispMux_io_sum),
    .io_price(dispMux_io_price),
    .io_seg(dispMux_io_seg),
    .io_an(dispMux_io_an)
  );
  assign io_releaseCan = fsm_io_releaseCan; // @[VendingMachine.scala 68:17]
  assign io_alarm = fsm_io_alarm; // @[VendingMachine.scala 67:12]
  assign io_seg = dispMux_io_seg; // @[VendingMachine.scala 69:10]
  assign io_an = dispMux_io_an; // @[VendingMachine.scala 70:9]
  assign coin2Deb_clock = clock;
  assign coin2Deb_reset = reset;
  assign coin2Deb_io_in = io_coin2Raw; // @[VendingMachine.scala 26:18]
  assign coin5Deb_clock = clock;
  assign coin5Deb_reset = reset;
  assign coin5Deb_io_in = io_coin5Raw; // @[VendingMachine.scala 30:18]
  assign buyDeb_clock = clock;
  assign buyDeb_reset = reset;
  assign buyDeb_io_in = io_buyRaw; // @[VendingMachine.scala 34:16]
  assign dataPath_clock = clock;
  assign dataPath_reset = reset;
  assign dataPath_io_price = io_price; // @[VendingMachine.scala 42:21]
  assign dataPath_io_coin2 = coin2Deb_io_out; // @[VendingMachine.scala 20:26 27:9]
  assign dataPath_io_coin5 = coin5Deb_io_out; // @[VendingMachine.scala 21:26 31:9]
  assign dataPath_io_sub = fsm_io_sub; // @[VendingMachine.scala 46:19]
  assign dataPath_io_add = fsm_io_add; // @[VendingMachine.scala 47:19]
  assign dataPath_io_alarm = fsm_io_alarm; // @[VendingMachine.scala 49:21]
  assign fsm_clock = clock;
  assign fsm_reset = reset;
  assign fsm_io_price = io_price; // @[VendingMachine.scala 51:16]
  assign fsm_io_sum = {{1'd0}, dataPath_io_sum}; // @[VendingMachine.scala 54:14]
  assign fsm_io_buy = buyDeb_io_out; // @[VendingMachine.scala 22:24 35:7]
  assign fsm_io_coin = dataPath_io_coin; // @[VendingMachine.scala 55:15]
  assign fsm_io_empty = dataPath_io_isEmpty; // @[VendingMachine.scala 56:16]
  assign dispMux_clock = clock;
  assign dispMux_reset = reset;
  assign dispMux_io_customIn_0 = dataPath_io_customOut_0; // @[VendingMachine.scala 64:23]
  assign dispMux_io_customIn_1 = dataPath_io_customOut_1; // @[VendingMachine.scala 64:23]
  assign dispMux_io_customIn_2 = dataPath_io_customOut_2; // @[VendingMachine.scala 64:23]
  assign dispMux_io_customIn_3 = dataPath_io_customOut_3; // @[VendingMachine.scala 64:23]
  assign dispMux_io_sum = dataPath_io_sum; // @[VendingMachine.scala 63:18]
  assign dispMux_io_price = io_price; // @[VendingMachine.scala 62:20]
endmodule
