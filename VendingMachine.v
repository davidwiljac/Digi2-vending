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
module BcdTable(
  input  [7:0] io_address,
  output [7:0] io_data
);
  wire [7:0] _GEN_1 = 7'h1 == io_address[6:0] ? 8'h1 : 8'h0; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_2 = 7'h2 == io_address[6:0] ? 8'h2 : _GEN_1; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_3 = 7'h3 == io_address[6:0] ? 8'h3 : _GEN_2; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_4 = 7'h4 == io_address[6:0] ? 8'h4 : _GEN_3; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_5 = 7'h5 == io_address[6:0] ? 8'h5 : _GEN_4; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_6 = 7'h6 == io_address[6:0] ? 8'h6 : _GEN_5; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_7 = 7'h7 == io_address[6:0] ? 8'h7 : _GEN_6; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_8 = 7'h8 == io_address[6:0] ? 8'h8 : _GEN_7; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_9 = 7'h9 == io_address[6:0] ? 8'h9 : _GEN_8; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_10 = 7'ha == io_address[6:0] ? 8'h10 : _GEN_9; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_11 = 7'hb == io_address[6:0] ? 8'h11 : _GEN_10; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_12 = 7'hc == io_address[6:0] ? 8'h12 : _GEN_11; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_13 = 7'hd == io_address[6:0] ? 8'h13 : _GEN_12; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_14 = 7'he == io_address[6:0] ? 8'h14 : _GEN_13; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_15 = 7'hf == io_address[6:0] ? 8'h15 : _GEN_14; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_16 = 7'h10 == io_address[6:0] ? 8'h16 : _GEN_15; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_17 = 7'h11 == io_address[6:0] ? 8'h17 : _GEN_16; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_18 = 7'h12 == io_address[6:0] ? 8'h18 : _GEN_17; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_19 = 7'h13 == io_address[6:0] ? 8'h19 : _GEN_18; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_20 = 7'h14 == io_address[6:0] ? 8'h20 : _GEN_19; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_21 = 7'h15 == io_address[6:0] ? 8'h21 : _GEN_20; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_22 = 7'h16 == io_address[6:0] ? 8'h22 : _GEN_21; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_23 = 7'h17 == io_address[6:0] ? 8'h23 : _GEN_22; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_24 = 7'h18 == io_address[6:0] ? 8'h24 : _GEN_23; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_25 = 7'h19 == io_address[6:0] ? 8'h25 : _GEN_24; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_26 = 7'h1a == io_address[6:0] ? 8'h26 : _GEN_25; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_27 = 7'h1b == io_address[6:0] ? 8'h27 : _GEN_26; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_28 = 7'h1c == io_address[6:0] ? 8'h28 : _GEN_27; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_29 = 7'h1d == io_address[6:0] ? 8'h29 : _GEN_28; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_30 = 7'h1e == io_address[6:0] ? 8'h30 : _GEN_29; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_31 = 7'h1f == io_address[6:0] ? 8'h31 : _GEN_30; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_32 = 7'h20 == io_address[6:0] ? 8'h32 : _GEN_31; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_33 = 7'h21 == io_address[6:0] ? 8'h33 : _GEN_32; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_34 = 7'h22 == io_address[6:0] ? 8'h34 : _GEN_33; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_35 = 7'h23 == io_address[6:0] ? 8'h35 : _GEN_34; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_36 = 7'h24 == io_address[6:0] ? 8'h36 : _GEN_35; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_37 = 7'h25 == io_address[6:0] ? 8'h37 : _GEN_36; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_38 = 7'h26 == io_address[6:0] ? 8'h38 : _GEN_37; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_39 = 7'h27 == io_address[6:0] ? 8'h39 : _GEN_38; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_40 = 7'h28 == io_address[6:0] ? 8'h40 : _GEN_39; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_41 = 7'h29 == io_address[6:0] ? 8'h41 : _GEN_40; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_42 = 7'h2a == io_address[6:0] ? 8'h42 : _GEN_41; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_43 = 7'h2b == io_address[6:0] ? 8'h43 : _GEN_42; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_44 = 7'h2c == io_address[6:0] ? 8'h44 : _GEN_43; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_45 = 7'h2d == io_address[6:0] ? 8'h45 : _GEN_44; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_46 = 7'h2e == io_address[6:0] ? 8'h46 : _GEN_45; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_47 = 7'h2f == io_address[6:0] ? 8'h47 : _GEN_46; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_48 = 7'h30 == io_address[6:0] ? 8'h48 : _GEN_47; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_49 = 7'h31 == io_address[6:0] ? 8'h49 : _GEN_48; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_50 = 7'h32 == io_address[6:0] ? 8'h50 : _GEN_49; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_51 = 7'h33 == io_address[6:0] ? 8'h51 : _GEN_50; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_52 = 7'h34 == io_address[6:0] ? 8'h52 : _GEN_51; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_53 = 7'h35 == io_address[6:0] ? 8'h53 : _GEN_52; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_54 = 7'h36 == io_address[6:0] ? 8'h54 : _GEN_53; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_55 = 7'h37 == io_address[6:0] ? 8'h55 : _GEN_54; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_56 = 7'h38 == io_address[6:0] ? 8'h56 : _GEN_55; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_57 = 7'h39 == io_address[6:0] ? 8'h57 : _GEN_56; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_58 = 7'h3a == io_address[6:0] ? 8'h58 : _GEN_57; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_59 = 7'h3b == io_address[6:0] ? 8'h59 : _GEN_58; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_60 = 7'h3c == io_address[6:0] ? 8'h60 : _GEN_59; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_61 = 7'h3d == io_address[6:0] ? 8'h61 : _GEN_60; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_62 = 7'h3e == io_address[6:0] ? 8'h62 : _GEN_61; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_63 = 7'h3f == io_address[6:0] ? 8'h63 : _GEN_62; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_64 = 7'h40 == io_address[6:0] ? 8'h64 : _GEN_63; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_65 = 7'h41 == io_address[6:0] ? 8'h65 : _GEN_64; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_66 = 7'h42 == io_address[6:0] ? 8'h66 : _GEN_65; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_67 = 7'h43 == io_address[6:0] ? 8'h67 : _GEN_66; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_68 = 7'h44 == io_address[6:0] ? 8'h68 : _GEN_67; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_69 = 7'h45 == io_address[6:0] ? 8'h69 : _GEN_68; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_70 = 7'h46 == io_address[6:0] ? 8'h70 : _GEN_69; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_71 = 7'h47 == io_address[6:0] ? 8'h71 : _GEN_70; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_72 = 7'h48 == io_address[6:0] ? 8'h72 : _GEN_71; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_73 = 7'h49 == io_address[6:0] ? 8'h73 : _GEN_72; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_74 = 7'h4a == io_address[6:0] ? 8'h74 : _GEN_73; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_75 = 7'h4b == io_address[6:0] ? 8'h75 : _GEN_74; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_76 = 7'h4c == io_address[6:0] ? 8'h76 : _GEN_75; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_77 = 7'h4d == io_address[6:0] ? 8'h77 : _GEN_76; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_78 = 7'h4e == io_address[6:0] ? 8'h78 : _GEN_77; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_79 = 7'h4f == io_address[6:0] ? 8'h79 : _GEN_78; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_80 = 7'h50 == io_address[6:0] ? 8'h80 : _GEN_79; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_81 = 7'h51 == io_address[6:0] ? 8'h81 : _GEN_80; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_82 = 7'h52 == io_address[6:0] ? 8'h82 : _GEN_81; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_83 = 7'h53 == io_address[6:0] ? 8'h83 : _GEN_82; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_84 = 7'h54 == io_address[6:0] ? 8'h84 : _GEN_83; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_85 = 7'h55 == io_address[6:0] ? 8'h85 : _GEN_84; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_86 = 7'h56 == io_address[6:0] ? 8'h86 : _GEN_85; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_87 = 7'h57 == io_address[6:0] ? 8'h87 : _GEN_86; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_88 = 7'h58 == io_address[6:0] ? 8'h88 : _GEN_87; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_89 = 7'h59 == io_address[6:0] ? 8'h89 : _GEN_88; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_90 = 7'h5a == io_address[6:0] ? 8'h90 : _GEN_89; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_91 = 7'h5b == io_address[6:0] ? 8'h91 : _GEN_90; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_92 = 7'h5c == io_address[6:0] ? 8'h92 : _GEN_91; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_93 = 7'h5d == io_address[6:0] ? 8'h93 : _GEN_92; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_94 = 7'h5e == io_address[6:0] ? 8'h94 : _GEN_93; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_95 = 7'h5f == io_address[6:0] ? 8'h95 : _GEN_94; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_96 = 7'h60 == io_address[6:0] ? 8'h96 : _GEN_95; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_97 = 7'h61 == io_address[6:0] ? 8'h97 : _GEN_96; // @[DisplayMultiplexer.scala 74:{11,11}]
  wire [7:0] _GEN_98 = 7'h62 == io_address[6:0] ? 8'h98 : _GEN_97; // @[DisplayMultiplexer.scala 74:{11,11}]
  assign io_data = 7'h63 == io_address[6:0] ? 8'h99 : _GEN_98; // @[DisplayMultiplexer.scala 74:{11,11}]
endmodule
module SevenSegDec(
  input  [3:0] io_in,
  output [6:0] io_out
);
  wire [6:0] _GEN_0 = 4'hf == io_in ? 7'h71 : 7'h0; // @[SevenSegDec.scala 13:17 29:23 10:27]
  wire [6:0] _GEN_1 = 4'he == io_in ? 7'h79 : _GEN_0; // @[SevenSegDec.scala 13:17 28:23]
  wire [6:0] _GEN_2 = 4'hd == io_in ? 7'h5e : _GEN_1; // @[SevenSegDec.scala 13:17 27:23]
  wire [6:0] _GEN_3 = 4'hc == io_in ? 7'h39 : _GEN_2; // @[SevenSegDec.scala 13:17 26:23]
  wire [6:0] _GEN_4 = 4'hb == io_in ? 7'h7c : _GEN_3; // @[SevenSegDec.scala 13:17 25:23]
  wire [6:0] _GEN_5 = 4'ha == io_in ? 7'h77 : _GEN_4; // @[SevenSegDec.scala 13:17 24:23]
  wire [6:0] _GEN_6 = 4'h9 == io_in ? 7'h67 : _GEN_5; // @[SevenSegDec.scala 13:17 23:22]
  wire [6:0] _GEN_7 = 4'h8 == io_in ? 7'h7f : _GEN_6; // @[SevenSegDec.scala 13:17 22:22]
  wire [6:0] _GEN_8 = 4'h7 == io_in ? 7'h7 : _GEN_7; // @[SevenSegDec.scala 13:17 21:22]
  wire [6:0] _GEN_9 = 4'h6 == io_in ? 7'h7d : _GEN_8; // @[SevenSegDec.scala 13:17 20:22]
  wire [6:0] _GEN_10 = 4'h5 == io_in ? 7'h6d : _GEN_9; // @[SevenSegDec.scala 13:17 19:22]
  wire [6:0] _GEN_11 = 4'h4 == io_in ? 7'h66 : _GEN_10; // @[SevenSegDec.scala 13:17 18:22]
  wire [6:0] _GEN_12 = 4'h3 == io_in ? 7'h4f : _GEN_11; // @[SevenSegDec.scala 13:17 17:22]
  wire [6:0] _GEN_13 = 4'h2 == io_in ? 7'h5b : _GEN_12; // @[SevenSegDec.scala 13:17 16:22]
  wire [6:0] _GEN_14 = 4'h1 == io_in ? 7'h30 : _GEN_13; // @[SevenSegDec.scala 13:17 15:22]
  wire [6:0] sevSeg = 4'h0 == io_in ? 7'h3f : _GEN_14; // @[SevenSegDec.scala 13:17 14:22]
  assign io_out = ~sevSeg; // @[SevenSegDec.scala 33:13]
endmodule
module DisplayMultiplexer(
  input        clock,
  input        reset,
  input  [6:0] io_sum,
  input  [4:0] io_price,
  output [6:0] io_seg,
  output [3:0] io_an
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire [7:0] table__io_address; // @[DisplayMultiplexer.scala 19:21]
  wire [7:0] table__io_data; // @[DisplayMultiplexer.scala 19:21]
  wire [3:0] decoder_io_in; // @[DisplayMultiplexer.scala 22:23]
  wire [6:0] decoder_io_out; // @[DisplayMultiplexer.scala 22:23]
  reg [1:0] selectReg; // @[DisplayMultiplexer.scala 17:26]
  reg [16:0] tickCounterReg; // @[DisplayMultiplexer.scala 26:32]
  wire  tick = tickCounterReg == 17'h1869f; // @[DisplayMultiplexer.scala 27:29]
  wire [16:0] _tickCounterReg_T_1 = tickCounterReg + 17'h1; // @[DisplayMultiplexer.scala 28:36]
  wire [1:0] _selectReg_T_1 = selectReg + 2'h1; // @[DisplayMultiplexer.scala 32:28]
  wire [6:0] _GEN_2 = 2'h3 == selectReg ? io_sum : 7'h0; // @[DisplayMultiplexer.scala 20:20 35:21 49:24]
  wire [3:0] _GEN_3 = 2'h3 == selectReg ? table__io_data[7:4] : 4'h0; // @[DisplayMultiplexer.scala 23:17 35:21 50:21]
  wire [6:0] _GEN_4 = 2'h2 == selectReg ? io_sum : _GEN_2; // @[DisplayMultiplexer.scala 35:21 45:24]
  wire [3:0] _GEN_5 = 2'h2 == selectReg ? table__io_data[3:0] : _GEN_3; // @[DisplayMultiplexer.scala 35:21 46:21]
  wire [6:0] _GEN_6 = 2'h1 == selectReg ? {{2'd0}, io_price} : _GEN_4; // @[DisplayMultiplexer.scala 35:21 41:24]
  wire [3:0] _GEN_7 = 2'h1 == selectReg ? table__io_data[7:4] : _GEN_5; // @[DisplayMultiplexer.scala 35:21 42:21]
  wire [6:0] _GEN_8 = 2'h0 == selectReg ? {{2'd0}, io_price} : _GEN_6; // @[DisplayMultiplexer.scala 35:21 37:24]
  wire [3:0] _io_an_T = 4'h1 << selectReg; // @[DisplayMultiplexer.scala 57:18]
  BcdTable table_ ( // @[DisplayMultiplexer.scala 19:21]
    .io_address(table__io_address),
    .io_data(table__io_data)
  );
  SevenSegDec decoder ( // @[DisplayMultiplexer.scala 22:23]
    .io_in(decoder_io_in),
    .io_out(decoder_io_out)
  );
  assign io_seg = decoder_io_out; // @[DisplayMultiplexer.scala 12:27 24:10]
  assign io_an = ~_io_an_T; // @[DisplayMultiplexer.scala 57:12]
  assign table__io_address = {{1'd0}, _GEN_8};
  assign decoder_io_in = 2'h0 == selectReg ? table__io_data[3:0] : _GEN_7; // @[DisplayMultiplexer.scala 35:21 38:21]
  always @(posedge clock) begin
    if (reset) begin // @[DisplayMultiplexer.scala 17:26]
      selectReg <= 2'h0; // @[DisplayMultiplexer.scala 17:26]
    end else if (tick) begin // @[DisplayMultiplexer.scala 30:15]
      selectReg <= _selectReg_T_1; // @[DisplayMultiplexer.scala 32:15]
    end
    if (reset) begin // @[DisplayMultiplexer.scala 26:32]
      tickCounterReg <= 17'h0; // @[DisplayMultiplexer.scala 26:32]
    end else if (tick) begin // @[DisplayMultiplexer.scala 30:15]
      tickCounterReg <= 17'h0; // @[DisplayMultiplexer.scala 31:20]
    end else begin
      tickCounterReg <= _tickCounterReg_T_1; // @[DisplayMultiplexer.scala 28:18]
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
module fsm(
  input        clock,
  input        reset,
  input  [4:0] io_price,
  input  [7:0] io_sum,
  input        io_buy,
  input        io_coin,
  output       io_sub,
  output       io_add,
  output       io_alarm,
  output       io_releaseCan
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [2:0] stateReg; // @[VendingMachine.scala 107:25]
  wire [7:0] _GEN_12 = {{3'd0}, io_price}; // @[VendingMachine.scala 112:29]
  wire [2:0] _GEN_0 = io_coin ? 3'h4 : stateReg; // @[VendingMachine.scala 116:26 117:18 107:25]
  wire [2:0] _GEN_3 = ~io_buy ? 3'h0 : stateReg; // @[VendingMachine.scala 124:31 125:17 107:25]
  wire [2:0] _GEN_5 = ~io_coin ? 3'h0 : stateReg; // @[VendingMachine.scala 137:32 138:17 107:25]
  wire [2:0] _GEN_6 = 3'h5 == stateReg ? _GEN_5 : stateReg; // @[VendingMachine.scala 110:19 107:25]
  wire [2:0] _GEN_7 = 3'h4 == stateReg ? 3'h5 : _GEN_6; // @[VendingMachine.scala 110:19 134:16]
  wire [2:0] _GEN_8 = 3'h3 == stateReg ? _GEN_3 : _GEN_7; // @[VendingMachine.scala 110:19]
  wire  _io_sub_T = stateReg == 3'h1; // @[VendingMachine.scala 144:21]
  assign io_sub = stateReg == 3'h1; // @[VendingMachine.scala 144:21]
  assign io_add = stateReg == 3'h4; // @[VendingMachine.scala 145:22]
  assign io_alarm = stateReg == 3'h3; // @[VendingMachine.scala 146:24]
  assign io_releaseCan = stateReg == 3'h2 | _io_sub_T; // @[VendingMachine.scala 147:42]
  always @(posedge clock) begin
    if (reset) begin // @[VendingMachine.scala 107:25]
      stateReg <= 3'h0; // @[VendingMachine.scala 107:25]
    end else if (3'h0 == stateReg) begin // @[VendingMachine.scala 110:19]
      if (io_buy & io_sum >= _GEN_12) begin // @[VendingMachine.scala 112:41]
        stateReg <= 3'h1; // @[VendingMachine.scala 113:18]
      end else if (io_buy & io_sum < _GEN_12) begin // @[VendingMachine.scala 114:47]
        stateReg <= 3'h3; // @[VendingMachine.scala 115:18]
      end else begin
        stateReg <= _GEN_0;
      end
    end else if (3'h1 == stateReg) begin // @[VendingMachine.scala 110:19]
      stateReg <= 3'h2; // @[VendingMachine.scala 121:15]
    end else if (3'h2 == stateReg) begin // @[VendingMachine.scala 110:19]
      stateReg <= _GEN_3;
    end else begin
      stateReg <= _GEN_8;
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
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire  coin2Deb_clock; // @[VendingMachine.scala 29:24]
  wire  coin2Deb_reset; // @[VendingMachine.scala 29:24]
  wire  coin2Deb_io_in; // @[VendingMachine.scala 29:24]
  wire  coin2Deb_io_out; // @[VendingMachine.scala 29:24]
  wire  coin5Deb_clock; // @[VendingMachine.scala 32:24]
  wire  coin5Deb_reset; // @[VendingMachine.scala 32:24]
  wire  coin5Deb_io_in; // @[VendingMachine.scala 32:24]
  wire  coin5Deb_io_out; // @[VendingMachine.scala 32:24]
  wire  buyDeb_clock; // @[VendingMachine.scala 35:22]
  wire  buyDeb_reset; // @[VendingMachine.scala 35:22]
  wire  buyDeb_io_in; // @[VendingMachine.scala 35:22]
  wire  buyDeb_io_out; // @[VendingMachine.scala 35:22]
  wire  dispMux_clock; // @[VendingMachine.scala 44:23]
  wire  dispMux_reset; // @[VendingMachine.scala 44:23]
  wire [6:0] dispMux_io_sum; // @[VendingMachine.scala 44:23]
  wire [4:0] dispMux_io_price; // @[VendingMachine.scala 44:23]
  wire [6:0] dispMux_io_seg; // @[VendingMachine.scala 44:23]
  wire [3:0] dispMux_io_an; // @[VendingMachine.scala 44:23]
  wire  fsm_clock; // @[VendingMachine.scala 49:19]
  wire  fsm_reset; // @[VendingMachine.scala 49:19]
  wire [4:0] fsm_io_price; // @[VendingMachine.scala 49:19]
  wire [7:0] fsm_io_sum; // @[VendingMachine.scala 49:19]
  wire  fsm_io_buy; // @[VendingMachine.scala 49:19]
  wire  fsm_io_coin; // @[VendingMachine.scala 49:19]
  wire  fsm_io_sub; // @[VendingMachine.scala 49:19]
  wire  fsm_io_add; // @[VendingMachine.scala 49:19]
  wire  fsm_io_alarm; // @[VendingMachine.scala 49:19]
  wire  fsm_io_releaseCan; // @[VendingMachine.scala 49:19]
  reg [6:0] sumReg; // @[VendingMachine.scala 41:23]
  wire  coin2 = coin2Deb_io_out; // @[VendingMachine.scala 24:26 31:9]
  wire  coin5 = coin5Deb_io_out; // @[VendingMachine.scala 25:26 34:9]
  wire [2:0] _GEN_0 = coin5 ? 3'h5 : 3'h0; // @[VendingMachine.scala 64:32 65:13 22:28]
  wire [2:0] coinVal = coin2 ? 3'h2 : _GEN_0; // @[VendingMachine.scala 62:25 63:13]
  wire  sub = fsm_io_sub; // @[VendingMachine.scala 18:24 56:7]
  wire  add = fsm_io_add; // @[VendingMachine.scala 19:24 57:7]
  wire [6:0] _GEN_5 = {{4'd0}, coinVal}; // @[VendingMachine.scala 72:22]
  wire [6:0] _sumReg_T_1 = sumReg + _GEN_5; // @[VendingMachine.scala 72:22]
  wire [6:0] _GEN_6 = {{2'd0}, io_price}; // @[VendingMachine.scala 74:22]
  wire [6:0] _sumReg_T_3 = sumReg - _GEN_6; // @[VendingMachine.scala 74:22]
  Debouncer coin2Deb ( // @[VendingMachine.scala 29:24]
    .clock(coin2Deb_clock),
    .reset(coin2Deb_reset),
    .io_in(coin2Deb_io_in),
    .io_out(coin2Deb_io_out)
  );
  Debouncer coin5Deb ( // @[VendingMachine.scala 32:24]
    .clock(coin5Deb_clock),
    .reset(coin5Deb_reset),
    .io_in(coin5Deb_io_in),
    .io_out(coin5Deb_io_out)
  );
  Debouncer buyDeb ( // @[VendingMachine.scala 35:22]
    .clock(buyDeb_clock),
    .reset(buyDeb_reset),
    .io_in(buyDeb_io_in),
    .io_out(buyDeb_io_out)
  );
  DisplayMultiplexer dispMux ( // @[VendingMachine.scala 44:23]
    .clock(dispMux_clock),
    .reset(dispMux_reset),
    .io_sum(dispMux_io_sum),
    .io_price(dispMux_io_price),
    .io_seg(dispMux_io_seg),
    .io_an(dispMux_io_an)
  );
  fsm fsm ( // @[VendingMachine.scala 49:19]
    .clock(fsm_clock),
    .reset(fsm_reset),
    .io_price(fsm_io_price),
    .io_sum(fsm_io_sum),
    .io_buy(fsm_io_buy),
    .io_coin(fsm_io_coin),
    .io_sub(fsm_io_sub),
    .io_add(fsm_io_add),
    .io_alarm(fsm_io_alarm),
    .io_releaseCan(fsm_io_releaseCan)
  );
  assign io_releaseCan = fsm_io_releaseCan; // @[VendingMachine.scala 21:31 59:14]
  assign io_alarm = fsm_io_alarm; // @[VendingMachine.scala 20:26 58:9]
  assign io_seg = dispMux_io_seg; // @[VendingMachine.scala 80:10]
  assign io_an = dispMux_io_an; // @[VendingMachine.scala 81:9]
  assign coin2Deb_clock = clock;
  assign coin2Deb_reset = reset;
  assign coin2Deb_io_in = io_coin2Raw; // @[VendingMachine.scala 30:18]
  assign coin5Deb_clock = clock;
  assign coin5Deb_reset = reset;
  assign coin5Deb_io_in = io_coin5Raw; // @[VendingMachine.scala 33:18]
  assign buyDeb_clock = clock;
  assign buyDeb_reset = reset;
  assign buyDeb_io_in = io_buyRaw; // @[VendingMachine.scala 36:16]
  assign dispMux_clock = clock;
  assign dispMux_reset = reset;
  assign dispMux_io_sum = sumReg; // @[VendingMachine.scala 46:18]
  assign dispMux_io_price = io_price; // @[VendingMachine.scala 45:20]
  assign fsm_clock = clock;
  assign fsm_reset = reset;
  assign fsm_io_price = io_price; // @[VendingMachine.scala 51:16]
  assign fsm_io_sum = {{1'd0}, sumReg}; // @[VendingMachine.scala 52:14]
  assign fsm_io_buy = buyDeb_io_out; // @[VendingMachine.scala 26:24 37:7]
  assign fsm_io_coin = coin2 | coin5; // @[VendingMachine.scala 54:24]
  always @(posedge clock) begin
    if (reset) begin // @[VendingMachine.scala 41:23]
      sumReg <= 7'h0; // @[VendingMachine.scala 41:23]
    end else if (!(~sub & ~add)) begin // @[VendingMachine.scala 69:45]
      if (add) begin // @[VendingMachine.scala 71:29]
        sumReg <= _sumReg_T_1; // @[VendingMachine.scala 72:12]
      end else if (sub) begin // @[VendingMachine.scala 73:30]
        sumReg <= _sumReg_T_3; // @[VendingMachine.scala 74:12]
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
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
