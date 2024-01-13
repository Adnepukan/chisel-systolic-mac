module PipelineHandshake(
  input   clock,
  input   validPre,
  output  readyPre,
  input   lastPre,
  output  validNxt,
  input   readyNxt,
  output  regen_0,
  output  regen_1,
  output  lastNxt,
  input   rst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
`endif // RANDOMIZE_REG_INIT
  reg  valid_1_r; // @[Reg.scala 28:20]
  reg  valid_2_r; // @[Reg.scala 28:20]
  wire  ready_1 = readyNxt | ~valid_2_r; // @[pipelinehsk.scala 24:36]
  wire  ready_0 = ready_1 | ~valid_1_r; // @[pipelinehsk.scala 24:36]
  reg  last_1_r; // @[Reg.scala 28:20]
  reg  last_2_r; // @[Reg.scala 28:20]
  assign readyPre = ready_1 | ~valid_1_r; // @[pipelinehsk.scala 24:36]
  assign validNxt = valid_2_r; // @[pipelinehsk.scala 16:21 22:24]
  assign regen_0 = validPre & ready_0; // @[pipelinehsk.scala 25:34]
  assign regen_1 = valid_1_r & ready_1; // @[pipelinehsk.scala 25:34]
  assign lastNxt = last_2_r; // @[pipelinehsk.scala 18:20 23:23]
  always @(posedge clock or posedge rst) begin
    if (rst) begin // @[Reg.scala 29:18]
      valid_1_r <= 1'h0; // @[Reg.scala 29:22]
    end else if (ready_0) begin // @[Reg.scala 28:20]
      valid_1_r <= validPre;
    end
  end
  always @(posedge clock or posedge rst) begin
    if (rst) begin // @[Reg.scala 29:18]
      valid_2_r <= 1'h0; // @[Reg.scala 29:22]
    end else if (ready_1) begin // @[Reg.scala 28:20]
      valid_2_r <= valid_1_r;
    end
  end
  always @(posedge clock or posedge rst) begin
    if (rst) begin // @[Reg.scala 29:18]
      last_1_r <= 1'h0; // @[Reg.scala 29:22]
    end else if (regen_0) begin // @[Reg.scala 28:20]
      last_1_r <= lastPre;
    end
  end
  always @(posedge clock or posedge rst) begin
    if (rst) begin // @[Reg.scala 29:18]
      last_2_r <= 1'h0; // @[Reg.scala 29:22]
    end else if (regen_1) begin // @[Reg.scala 28:20]
      last_2_r <= last_1_r;
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
  valid_1_r = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  valid_2_r = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  last_1_r = _RAND_2[0:0];
  _RAND_3 = {1{`RANDOM}};
  last_2_r = _RAND_3[0:0];
`endif // RANDOMIZE_REG_INIT
  if (rst) begin
    valid_1_r = 1'h0;
  end
  if (rst) begin
    valid_2_r = 1'h0;
  end
  if (rst) begin
    last_1_r = 1'h0;
  end
  if (rst) begin
    last_2_r = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Exponent(
  input        clock,
  output       io_input_ready,
  input        io_input_valid,
  input  [7:0] io_input_bits_in_0,
  input  [7:0] io_input_bits_in_1,
  input  [7:0] io_input_bits_in_2,
  input  [7:0] io_input_bits_in_3,
  input  [7:0] io_input_bits_in_4,
  input  [7:0] io_input_bits_in_5,
  input  [7:0] io_input_bits_in_6,
  input  [7:0] io_input_bits_in_7,
  input  [7:0] io_input_bits_in_8,
  input  [7:0] io_input_bits_in_9,
  input  [7:0] io_input_bits_in_10,
  input  [7:0] io_input_bits_in_11,
  input  [7:0] io_input_bits_in_12,
  input  [7:0] io_input_bits_in_13,
  input  [7:0] io_input_bits_in_14,
  input  [7:0] io_input_bits_in_15,
  input        io_input_bits_last,
  input        io_output_ready,
  output       io_output_valid,
  output [7:0] io_output_bits_out_0,
  output [7:0] io_output_bits_out_1,
  output [7:0] io_output_bits_out_2,
  output [7:0] io_output_bits_out_3,
  output [7:0] io_output_bits_out_4,
  output [7:0] io_output_bits_out_5,
  output [7:0] io_output_bits_out_6,
  output [7:0] io_output_bits_out_7,
  output [7:0] io_output_bits_out_8,
  output [7:0] io_output_bits_out_9,
  output [7:0] io_output_bits_out_10,
  output [7:0] io_output_bits_out_11,
  output [7:0] io_output_bits_out_12,
  output [7:0] io_output_bits_out_13,
  output [7:0] io_output_bits_out_14,
  output [7:0] io_output_bits_out_15,
  output       io_output_bits_last,
  input        rst
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
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  wire  hsk_clock; // @[exponent.scala 27:21]
  wire  hsk_validPre; // @[exponent.scala 27:21]
  wire  hsk_readyPre; // @[exponent.scala 27:21]
  wire  hsk_lastPre; // @[exponent.scala 27:21]
  wire  hsk_validNxt; // @[exponent.scala 27:21]
  wire  hsk_readyNxt; // @[exponent.scala 27:21]
  wire  hsk_regen_0; // @[exponent.scala 27:21]
  wire  hsk_regen_1; // @[exponent.scala 27:21]
  wire  hsk_lastNxt; // @[exponent.scala 27:21]
  wire  hsk_rst; // @[exponent.scala 27:21]
  wire [12:0] _data1_T = $signed(io_input_bits_in_0) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_0; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_1 = $signed(io_input_bits_in_1) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_1; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_2 = $signed(io_input_bits_in_2) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_2; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_3 = $signed(io_input_bits_in_3) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_3; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_4 = $signed(io_input_bits_in_4) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_4; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_5 = $signed(io_input_bits_in_5) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_5; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_6 = $signed(io_input_bits_in_6) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_6; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_7 = $signed(io_input_bits_in_7) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_7; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_8 = $signed(io_input_bits_in_8) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_8; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_9 = $signed(io_input_bits_in_9) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_9; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_10 = $signed(io_input_bits_in_10) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_10; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_11 = $signed(io_input_bits_in_11) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_11; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_12 = $signed(io_input_bits_in_12) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_12; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_13 = $signed(io_input_bits_in_13) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_13; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_14 = $signed(io_input_bits_in_14) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_14; // @[Reg.scala 16:16]
  wire [12:0] _data1_T_15 = $signed(io_input_bits_in_15) * 5'shc; // @[exponent.scala 38:54]
  reg [12:0] data1_15; // @[Reg.scala 16:16]
  wire [5:0] data1Int_0 = data1_0[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_1 = data1_1[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_2 = data1_2[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_3 = data1_3[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_4 = data1_4[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_5 = data1_5[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_6 = data1_6[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_7 = data1_7[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_8 = data1_8[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_9 = data1_9[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_10 = data1_10[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_11 = data1_11[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_12 = data1_12[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_13 = data1_13[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_14 = data1_14[12:7]; // @[exponent.scala 39:31]
  wire [5:0] data1Int_15 = data1_15[12:7]; // @[exponent.scala 39:31]
  wire [6:0] data1Frac_0 = data1_0[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_1 = data1_1[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_2 = data1_2[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_3 = data1_3[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_4 = data1_4[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_5 = data1_5[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_6 = data1_6[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_7 = data1_7[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_8 = data1_8[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_9 = data1_9[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_10 = data1_10[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_11 = data1_11[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_12 = data1_12[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_13 = data1_13[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_14 = data1_14[6:0]; // @[exponent.scala 40:32]
  wire [6:0] data1Frac_15 = data1_15[6:0]; // @[exponent.scala 40:32]
  wire [7:0] _GEN_18 = 7'h2 == data1Frac_0 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_19 = 7'h3 == data1Frac_0 ? $signed(8'sh3f) : $signed(_GEN_18); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_20 = 7'h4 == data1Frac_0 ? $signed(8'sh3f) : $signed(_GEN_19); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_21 = 7'h5 == data1Frac_0 ? $signed(8'sh3e) : $signed(_GEN_20); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_22 = 7'h6 == data1Frac_0 ? $signed(8'sh3e) : $signed(_GEN_21); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_23 = 7'h7 == data1Frac_0 ? $signed(8'sh3e) : $signed(_GEN_22); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_24 = 7'h8 == data1Frac_0 ? $signed(8'sh3d) : $signed(_GEN_23); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_25 = 7'h9 == data1Frac_0 ? $signed(8'sh3d) : $signed(_GEN_24); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_26 = 7'ha == data1Frac_0 ? $signed(8'sh3d) : $signed(_GEN_25); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_27 = 7'hb == data1Frac_0 ? $signed(8'sh3c) : $signed(_GEN_26); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_28 = 7'hc == data1Frac_0 ? $signed(8'sh3c) : $signed(_GEN_27); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_29 = 7'hd == data1Frac_0 ? $signed(8'sh3c) : $signed(_GEN_28); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_30 = 7'he == data1Frac_0 ? $signed(8'sh3b) : $signed(_GEN_29); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_31 = 7'hf == data1Frac_0 ? $signed(8'sh3b) : $signed(_GEN_30); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_32 = 7'h10 == data1Frac_0 ? $signed(8'sh3b) : $signed(_GEN_31); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_33 = 7'h11 == data1Frac_0 ? $signed(8'sh3a) : $signed(_GEN_32); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_34 = 7'h12 == data1Frac_0 ? $signed(8'sh3a) : $signed(_GEN_33); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_35 = 7'h13 == data1Frac_0 ? $signed(8'sh3a) : $signed(_GEN_34); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_36 = 7'h14 == data1Frac_0 ? $signed(8'sh39) : $signed(_GEN_35); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_37 = 7'h15 == data1Frac_0 ? $signed(8'sh39) : $signed(_GEN_36); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_38 = 7'h16 == data1Frac_0 ? $signed(8'sh39) : $signed(_GEN_37); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_39 = 7'h17 == data1Frac_0 ? $signed(8'sh39) : $signed(_GEN_38); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_40 = 7'h18 == data1Frac_0 ? $signed(8'sh38) : $signed(_GEN_39); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_41 = 7'h19 == data1Frac_0 ? $signed(8'sh38) : $signed(_GEN_40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_42 = 7'h1a == data1Frac_0 ? $signed(8'sh38) : $signed(_GEN_41); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_43 = 7'h1b == data1Frac_0 ? $signed(8'sh37) : $signed(_GEN_42); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_44 = 7'h1c == data1Frac_0 ? $signed(8'sh37) : $signed(_GEN_43); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_45 = 7'h1d == data1Frac_0 ? $signed(8'sh37) : $signed(_GEN_44); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_46 = 7'h1e == data1Frac_0 ? $signed(8'sh36) : $signed(_GEN_45); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_47 = 7'h1f == data1Frac_0 ? $signed(8'sh36) : $signed(_GEN_46); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_48 = 7'h20 == data1Frac_0 ? $signed(8'sh36) : $signed(_GEN_47); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_49 = 7'h21 == data1Frac_0 ? $signed(8'sh36) : $signed(_GEN_48); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_50 = 7'h22 == data1Frac_0 ? $signed(8'sh35) : $signed(_GEN_49); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_51 = 7'h23 == data1Frac_0 ? $signed(8'sh35) : $signed(_GEN_50); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_52 = 7'h24 == data1Frac_0 ? $signed(8'sh35) : $signed(_GEN_51); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_53 = 7'h25 == data1Frac_0 ? $signed(8'sh34) : $signed(_GEN_52); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_54 = 7'h26 == data1Frac_0 ? $signed(8'sh34) : $signed(_GEN_53); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_55 = 7'h27 == data1Frac_0 ? $signed(8'sh34) : $signed(_GEN_54); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_56 = 7'h28 == data1Frac_0 ? $signed(8'sh34) : $signed(_GEN_55); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_57 = 7'h29 == data1Frac_0 ? $signed(8'sh33) : $signed(_GEN_56); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_58 = 7'h2a == data1Frac_0 ? $signed(8'sh33) : $signed(_GEN_57); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_59 = 7'h2b == data1Frac_0 ? $signed(8'sh33) : $signed(_GEN_58); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_60 = 7'h2c == data1Frac_0 ? $signed(8'sh32) : $signed(_GEN_59); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_61 = 7'h2d == data1Frac_0 ? $signed(8'sh32) : $signed(_GEN_60); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_62 = 7'h2e == data1Frac_0 ? $signed(8'sh32) : $signed(_GEN_61); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_63 = 7'h2f == data1Frac_0 ? $signed(8'sh32) : $signed(_GEN_62); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_64 = 7'h30 == data1Frac_0 ? $signed(8'sh31) : $signed(_GEN_63); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_65 = 7'h31 == data1Frac_0 ? $signed(8'sh31) : $signed(_GEN_64); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_66 = 7'h32 == data1Frac_0 ? $signed(8'sh31) : $signed(_GEN_65); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_67 = 7'h33 == data1Frac_0 ? $signed(8'sh31) : $signed(_GEN_66); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_68 = 7'h34 == data1Frac_0 ? $signed(8'sh30) : $signed(_GEN_67); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_69 = 7'h35 == data1Frac_0 ? $signed(8'sh30) : $signed(_GEN_68); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_70 = 7'h36 == data1Frac_0 ? $signed(8'sh30) : $signed(_GEN_69); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_71 = 7'h37 == data1Frac_0 ? $signed(8'sh30) : $signed(_GEN_70); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_72 = 7'h38 == data1Frac_0 ? $signed(8'sh2f) : $signed(_GEN_71); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_73 = 7'h39 == data1Frac_0 ? $signed(8'sh2f) : $signed(_GEN_72); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_74 = 7'h3a == data1Frac_0 ? $signed(8'sh2f) : $signed(_GEN_73); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_75 = 7'h3b == data1Frac_0 ? $signed(8'sh2e) : $signed(_GEN_74); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_76 = 7'h3c == data1Frac_0 ? $signed(8'sh2e) : $signed(_GEN_75); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_77 = 7'h3d == data1Frac_0 ? $signed(8'sh2e) : $signed(_GEN_76); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_78 = 7'h3e == data1Frac_0 ? $signed(8'sh2e) : $signed(_GEN_77); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_79 = 7'h3f == data1Frac_0 ? $signed(8'sh2e) : $signed(_GEN_78); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_80 = 7'h40 == data1Frac_0 ? $signed(8'sh2d) : $signed(_GEN_79); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_81 = 7'h41 == data1Frac_0 ? $signed(8'sh2d) : $signed(_GEN_80); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_82 = 7'h42 == data1Frac_0 ? $signed(8'sh2d) : $signed(_GEN_81); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_83 = 7'h43 == data1Frac_0 ? $signed(8'sh2d) : $signed(_GEN_82); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_84 = 7'h44 == data1Frac_0 ? $signed(8'sh2c) : $signed(_GEN_83); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_85 = 7'h45 == data1Frac_0 ? $signed(8'sh2c) : $signed(_GEN_84); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_86 = 7'h46 == data1Frac_0 ? $signed(8'sh2c) : $signed(_GEN_85); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_87 = 7'h47 == data1Frac_0 ? $signed(8'sh2c) : $signed(_GEN_86); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_88 = 7'h48 == data1Frac_0 ? $signed(8'sh2b) : $signed(_GEN_87); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_89 = 7'h49 == data1Frac_0 ? $signed(8'sh2b) : $signed(_GEN_88); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_90 = 7'h4a == data1Frac_0 ? $signed(8'sh2b) : $signed(_GEN_89); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_91 = 7'h4b == data1Frac_0 ? $signed(8'sh2b) : $signed(_GEN_90); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_92 = 7'h4c == data1Frac_0 ? $signed(8'sh2a) : $signed(_GEN_91); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_93 = 7'h4d == data1Frac_0 ? $signed(8'sh2a) : $signed(_GEN_92); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_94 = 7'h4e == data1Frac_0 ? $signed(8'sh2a) : $signed(_GEN_93); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_95 = 7'h4f == data1Frac_0 ? $signed(8'sh2a) : $signed(_GEN_94); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_96 = 7'h50 == data1Frac_0 ? $signed(8'sh29) : $signed(_GEN_95); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_97 = 7'h51 == data1Frac_0 ? $signed(8'sh29) : $signed(_GEN_96); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_98 = 7'h52 == data1Frac_0 ? $signed(8'sh29) : $signed(_GEN_97); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_99 = 7'h53 == data1Frac_0 ? $signed(8'sh29) : $signed(_GEN_98); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_100 = 7'h54 == data1Frac_0 ? $signed(8'sh29) : $signed(_GEN_99); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_101 = 7'h55 == data1Frac_0 ? $signed(8'sh28) : $signed(_GEN_100); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_102 = 7'h56 == data1Frac_0 ? $signed(8'sh28) : $signed(_GEN_101); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_103 = 7'h57 == data1Frac_0 ? $signed(8'sh28) : $signed(_GEN_102); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_104 = 7'h58 == data1Frac_0 ? $signed(8'sh28) : $signed(_GEN_103); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_105 = 7'h59 == data1Frac_0 ? $signed(8'sh28) : $signed(_GEN_104); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_106 = 7'h5a == data1Frac_0 ? $signed(8'sh27) : $signed(_GEN_105); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_107 = 7'h5b == data1Frac_0 ? $signed(8'sh27) : $signed(_GEN_106); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_108 = 7'h5c == data1Frac_0 ? $signed(8'sh27) : $signed(_GEN_107); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_109 = 7'h5d == data1Frac_0 ? $signed(8'sh27) : $signed(_GEN_108); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_110 = 7'h5e == data1Frac_0 ? $signed(8'sh26) : $signed(_GEN_109); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_111 = 7'h5f == data1Frac_0 ? $signed(8'sh26) : $signed(_GEN_110); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_112 = 7'h60 == data1Frac_0 ? $signed(8'sh26) : $signed(_GEN_111); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_113 = 7'h61 == data1Frac_0 ? $signed(8'sh26) : $signed(_GEN_112); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_114 = 7'h62 == data1Frac_0 ? $signed(8'sh26) : $signed(_GEN_113); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_115 = 7'h63 == data1Frac_0 ? $signed(8'sh25) : $signed(_GEN_114); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_116 = 7'h64 == data1Frac_0 ? $signed(8'sh25) : $signed(_GEN_115); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_117 = 7'h65 == data1Frac_0 ? $signed(8'sh25) : $signed(_GEN_116); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_118 = 7'h66 == data1Frac_0 ? $signed(8'sh25) : $signed(_GEN_117); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_119 = 7'h67 == data1Frac_0 ? $signed(8'sh25) : $signed(_GEN_118); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_120 = 7'h68 == data1Frac_0 ? $signed(8'sh24) : $signed(_GEN_119); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_121 = 7'h69 == data1Frac_0 ? $signed(8'sh24) : $signed(_GEN_120); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_122 = 7'h6a == data1Frac_0 ? $signed(8'sh24) : $signed(_GEN_121); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_123 = 7'h6b == data1Frac_0 ? $signed(8'sh24) : $signed(_GEN_122); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_124 = 7'h6c == data1Frac_0 ? $signed(8'sh24) : $signed(_GEN_123); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_125 = 7'h6d == data1Frac_0 ? $signed(8'sh23) : $signed(_GEN_124); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_126 = 7'h6e == data1Frac_0 ? $signed(8'sh23) : $signed(_GEN_125); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_127 = 7'h6f == data1Frac_0 ? $signed(8'sh23) : $signed(_GEN_126); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_128 = 7'h70 == data1Frac_0 ? $signed(8'sh23) : $signed(_GEN_127); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_129 = 7'h71 == data1Frac_0 ? $signed(8'sh23) : $signed(_GEN_128); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_130 = 7'h72 == data1Frac_0 ? $signed(8'sh23) : $signed(_GEN_129); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_131 = 7'h73 == data1Frac_0 ? $signed(8'sh22) : $signed(_GEN_130); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_132 = 7'h74 == data1Frac_0 ? $signed(8'sh22) : $signed(_GEN_131); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_133 = 7'h75 == data1Frac_0 ? $signed(8'sh22) : $signed(_GEN_132); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_134 = 7'h76 == data1Frac_0 ? $signed(8'sh22) : $signed(_GEN_133); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_135 = 7'h77 == data1Frac_0 ? $signed(8'sh22) : $signed(_GEN_134); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_136 = 7'h78 == data1Frac_0 ? $signed(8'sh21) : $signed(_GEN_135); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_137 = 7'h79 == data1Frac_0 ? $signed(8'sh21) : $signed(_GEN_136); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_138 = 7'h7a == data1Frac_0 ? $signed(8'sh21) : $signed(_GEN_137); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_139 = 7'h7b == data1Frac_0 ? $signed(8'sh21) : $signed(_GEN_138); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_140 = 7'h7c == data1Frac_0 ? $signed(8'sh21) : $signed(_GEN_139); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_141 = 7'h7d == data1Frac_0 ? $signed(8'sh21) : $signed(_GEN_140); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_142 = 7'h7e == data1Frac_0 ? $signed(8'sh20) : $signed(_GEN_141); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_143 = 7'h7f == data1Frac_0 ? $signed(8'sh20) : $signed(_GEN_142); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_2 = $signed(_GEN_143) >>> data1Int_0; // @[exponent.scala 46:85]
  reg [7:0] data2_0; // @[Reg.scala 16:16]
  wire [7:0] _GEN_147 = 7'h2 == data1Frac_1 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_148 = 7'h3 == data1Frac_1 ? $signed(8'sh3f) : $signed(_GEN_147); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_149 = 7'h4 == data1Frac_1 ? $signed(8'sh3f) : $signed(_GEN_148); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_150 = 7'h5 == data1Frac_1 ? $signed(8'sh3e) : $signed(_GEN_149); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_151 = 7'h6 == data1Frac_1 ? $signed(8'sh3e) : $signed(_GEN_150); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_152 = 7'h7 == data1Frac_1 ? $signed(8'sh3e) : $signed(_GEN_151); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_153 = 7'h8 == data1Frac_1 ? $signed(8'sh3d) : $signed(_GEN_152); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_154 = 7'h9 == data1Frac_1 ? $signed(8'sh3d) : $signed(_GEN_153); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_155 = 7'ha == data1Frac_1 ? $signed(8'sh3d) : $signed(_GEN_154); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_156 = 7'hb == data1Frac_1 ? $signed(8'sh3c) : $signed(_GEN_155); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_157 = 7'hc == data1Frac_1 ? $signed(8'sh3c) : $signed(_GEN_156); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_158 = 7'hd == data1Frac_1 ? $signed(8'sh3c) : $signed(_GEN_157); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_159 = 7'he == data1Frac_1 ? $signed(8'sh3b) : $signed(_GEN_158); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_160 = 7'hf == data1Frac_1 ? $signed(8'sh3b) : $signed(_GEN_159); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_161 = 7'h10 == data1Frac_1 ? $signed(8'sh3b) : $signed(_GEN_160); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_162 = 7'h11 == data1Frac_1 ? $signed(8'sh3a) : $signed(_GEN_161); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_163 = 7'h12 == data1Frac_1 ? $signed(8'sh3a) : $signed(_GEN_162); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_164 = 7'h13 == data1Frac_1 ? $signed(8'sh3a) : $signed(_GEN_163); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_165 = 7'h14 == data1Frac_1 ? $signed(8'sh39) : $signed(_GEN_164); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_166 = 7'h15 == data1Frac_1 ? $signed(8'sh39) : $signed(_GEN_165); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_167 = 7'h16 == data1Frac_1 ? $signed(8'sh39) : $signed(_GEN_166); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_168 = 7'h17 == data1Frac_1 ? $signed(8'sh39) : $signed(_GEN_167); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_169 = 7'h18 == data1Frac_1 ? $signed(8'sh38) : $signed(_GEN_168); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_170 = 7'h19 == data1Frac_1 ? $signed(8'sh38) : $signed(_GEN_169); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_171 = 7'h1a == data1Frac_1 ? $signed(8'sh38) : $signed(_GEN_170); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_172 = 7'h1b == data1Frac_1 ? $signed(8'sh37) : $signed(_GEN_171); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_173 = 7'h1c == data1Frac_1 ? $signed(8'sh37) : $signed(_GEN_172); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_174 = 7'h1d == data1Frac_1 ? $signed(8'sh37) : $signed(_GEN_173); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_175 = 7'h1e == data1Frac_1 ? $signed(8'sh36) : $signed(_GEN_174); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_176 = 7'h1f == data1Frac_1 ? $signed(8'sh36) : $signed(_GEN_175); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_177 = 7'h20 == data1Frac_1 ? $signed(8'sh36) : $signed(_GEN_176); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_178 = 7'h21 == data1Frac_1 ? $signed(8'sh36) : $signed(_GEN_177); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_179 = 7'h22 == data1Frac_1 ? $signed(8'sh35) : $signed(_GEN_178); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_180 = 7'h23 == data1Frac_1 ? $signed(8'sh35) : $signed(_GEN_179); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_181 = 7'h24 == data1Frac_1 ? $signed(8'sh35) : $signed(_GEN_180); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_182 = 7'h25 == data1Frac_1 ? $signed(8'sh34) : $signed(_GEN_181); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_183 = 7'h26 == data1Frac_1 ? $signed(8'sh34) : $signed(_GEN_182); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_184 = 7'h27 == data1Frac_1 ? $signed(8'sh34) : $signed(_GEN_183); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_185 = 7'h28 == data1Frac_1 ? $signed(8'sh34) : $signed(_GEN_184); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_186 = 7'h29 == data1Frac_1 ? $signed(8'sh33) : $signed(_GEN_185); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_187 = 7'h2a == data1Frac_1 ? $signed(8'sh33) : $signed(_GEN_186); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_188 = 7'h2b == data1Frac_1 ? $signed(8'sh33) : $signed(_GEN_187); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_189 = 7'h2c == data1Frac_1 ? $signed(8'sh32) : $signed(_GEN_188); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_190 = 7'h2d == data1Frac_1 ? $signed(8'sh32) : $signed(_GEN_189); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_191 = 7'h2e == data1Frac_1 ? $signed(8'sh32) : $signed(_GEN_190); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_192 = 7'h2f == data1Frac_1 ? $signed(8'sh32) : $signed(_GEN_191); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_193 = 7'h30 == data1Frac_1 ? $signed(8'sh31) : $signed(_GEN_192); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_194 = 7'h31 == data1Frac_1 ? $signed(8'sh31) : $signed(_GEN_193); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_195 = 7'h32 == data1Frac_1 ? $signed(8'sh31) : $signed(_GEN_194); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_196 = 7'h33 == data1Frac_1 ? $signed(8'sh31) : $signed(_GEN_195); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_197 = 7'h34 == data1Frac_1 ? $signed(8'sh30) : $signed(_GEN_196); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_198 = 7'h35 == data1Frac_1 ? $signed(8'sh30) : $signed(_GEN_197); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_199 = 7'h36 == data1Frac_1 ? $signed(8'sh30) : $signed(_GEN_198); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_200 = 7'h37 == data1Frac_1 ? $signed(8'sh30) : $signed(_GEN_199); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_201 = 7'h38 == data1Frac_1 ? $signed(8'sh2f) : $signed(_GEN_200); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_202 = 7'h39 == data1Frac_1 ? $signed(8'sh2f) : $signed(_GEN_201); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_203 = 7'h3a == data1Frac_1 ? $signed(8'sh2f) : $signed(_GEN_202); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_204 = 7'h3b == data1Frac_1 ? $signed(8'sh2e) : $signed(_GEN_203); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_205 = 7'h3c == data1Frac_1 ? $signed(8'sh2e) : $signed(_GEN_204); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_206 = 7'h3d == data1Frac_1 ? $signed(8'sh2e) : $signed(_GEN_205); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_207 = 7'h3e == data1Frac_1 ? $signed(8'sh2e) : $signed(_GEN_206); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_208 = 7'h3f == data1Frac_1 ? $signed(8'sh2e) : $signed(_GEN_207); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_209 = 7'h40 == data1Frac_1 ? $signed(8'sh2d) : $signed(_GEN_208); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_210 = 7'h41 == data1Frac_1 ? $signed(8'sh2d) : $signed(_GEN_209); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_211 = 7'h42 == data1Frac_1 ? $signed(8'sh2d) : $signed(_GEN_210); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_212 = 7'h43 == data1Frac_1 ? $signed(8'sh2d) : $signed(_GEN_211); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_213 = 7'h44 == data1Frac_1 ? $signed(8'sh2c) : $signed(_GEN_212); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_214 = 7'h45 == data1Frac_1 ? $signed(8'sh2c) : $signed(_GEN_213); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_215 = 7'h46 == data1Frac_1 ? $signed(8'sh2c) : $signed(_GEN_214); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_216 = 7'h47 == data1Frac_1 ? $signed(8'sh2c) : $signed(_GEN_215); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_217 = 7'h48 == data1Frac_1 ? $signed(8'sh2b) : $signed(_GEN_216); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_218 = 7'h49 == data1Frac_1 ? $signed(8'sh2b) : $signed(_GEN_217); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_219 = 7'h4a == data1Frac_1 ? $signed(8'sh2b) : $signed(_GEN_218); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_220 = 7'h4b == data1Frac_1 ? $signed(8'sh2b) : $signed(_GEN_219); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_221 = 7'h4c == data1Frac_1 ? $signed(8'sh2a) : $signed(_GEN_220); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_222 = 7'h4d == data1Frac_1 ? $signed(8'sh2a) : $signed(_GEN_221); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_223 = 7'h4e == data1Frac_1 ? $signed(8'sh2a) : $signed(_GEN_222); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_224 = 7'h4f == data1Frac_1 ? $signed(8'sh2a) : $signed(_GEN_223); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_225 = 7'h50 == data1Frac_1 ? $signed(8'sh29) : $signed(_GEN_224); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_226 = 7'h51 == data1Frac_1 ? $signed(8'sh29) : $signed(_GEN_225); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_227 = 7'h52 == data1Frac_1 ? $signed(8'sh29) : $signed(_GEN_226); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_228 = 7'h53 == data1Frac_1 ? $signed(8'sh29) : $signed(_GEN_227); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_229 = 7'h54 == data1Frac_1 ? $signed(8'sh29) : $signed(_GEN_228); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_230 = 7'h55 == data1Frac_1 ? $signed(8'sh28) : $signed(_GEN_229); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_231 = 7'h56 == data1Frac_1 ? $signed(8'sh28) : $signed(_GEN_230); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_232 = 7'h57 == data1Frac_1 ? $signed(8'sh28) : $signed(_GEN_231); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_233 = 7'h58 == data1Frac_1 ? $signed(8'sh28) : $signed(_GEN_232); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_234 = 7'h59 == data1Frac_1 ? $signed(8'sh28) : $signed(_GEN_233); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_235 = 7'h5a == data1Frac_1 ? $signed(8'sh27) : $signed(_GEN_234); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_236 = 7'h5b == data1Frac_1 ? $signed(8'sh27) : $signed(_GEN_235); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_237 = 7'h5c == data1Frac_1 ? $signed(8'sh27) : $signed(_GEN_236); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_238 = 7'h5d == data1Frac_1 ? $signed(8'sh27) : $signed(_GEN_237); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_239 = 7'h5e == data1Frac_1 ? $signed(8'sh26) : $signed(_GEN_238); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_240 = 7'h5f == data1Frac_1 ? $signed(8'sh26) : $signed(_GEN_239); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_241 = 7'h60 == data1Frac_1 ? $signed(8'sh26) : $signed(_GEN_240); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_242 = 7'h61 == data1Frac_1 ? $signed(8'sh26) : $signed(_GEN_241); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_243 = 7'h62 == data1Frac_1 ? $signed(8'sh26) : $signed(_GEN_242); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_244 = 7'h63 == data1Frac_1 ? $signed(8'sh25) : $signed(_GEN_243); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_245 = 7'h64 == data1Frac_1 ? $signed(8'sh25) : $signed(_GEN_244); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_246 = 7'h65 == data1Frac_1 ? $signed(8'sh25) : $signed(_GEN_245); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_247 = 7'h66 == data1Frac_1 ? $signed(8'sh25) : $signed(_GEN_246); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_248 = 7'h67 == data1Frac_1 ? $signed(8'sh25) : $signed(_GEN_247); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_249 = 7'h68 == data1Frac_1 ? $signed(8'sh24) : $signed(_GEN_248); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_250 = 7'h69 == data1Frac_1 ? $signed(8'sh24) : $signed(_GEN_249); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_251 = 7'h6a == data1Frac_1 ? $signed(8'sh24) : $signed(_GEN_250); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_252 = 7'h6b == data1Frac_1 ? $signed(8'sh24) : $signed(_GEN_251); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_253 = 7'h6c == data1Frac_1 ? $signed(8'sh24) : $signed(_GEN_252); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_254 = 7'h6d == data1Frac_1 ? $signed(8'sh23) : $signed(_GEN_253); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_255 = 7'h6e == data1Frac_1 ? $signed(8'sh23) : $signed(_GEN_254); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_256 = 7'h6f == data1Frac_1 ? $signed(8'sh23) : $signed(_GEN_255); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_257 = 7'h70 == data1Frac_1 ? $signed(8'sh23) : $signed(_GEN_256); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_258 = 7'h71 == data1Frac_1 ? $signed(8'sh23) : $signed(_GEN_257); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_259 = 7'h72 == data1Frac_1 ? $signed(8'sh23) : $signed(_GEN_258); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_260 = 7'h73 == data1Frac_1 ? $signed(8'sh22) : $signed(_GEN_259); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_261 = 7'h74 == data1Frac_1 ? $signed(8'sh22) : $signed(_GEN_260); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_262 = 7'h75 == data1Frac_1 ? $signed(8'sh22) : $signed(_GEN_261); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_263 = 7'h76 == data1Frac_1 ? $signed(8'sh22) : $signed(_GEN_262); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_264 = 7'h77 == data1Frac_1 ? $signed(8'sh22) : $signed(_GEN_263); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_265 = 7'h78 == data1Frac_1 ? $signed(8'sh21) : $signed(_GEN_264); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_266 = 7'h79 == data1Frac_1 ? $signed(8'sh21) : $signed(_GEN_265); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_267 = 7'h7a == data1Frac_1 ? $signed(8'sh21) : $signed(_GEN_266); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_268 = 7'h7b == data1Frac_1 ? $signed(8'sh21) : $signed(_GEN_267); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_269 = 7'h7c == data1Frac_1 ? $signed(8'sh21) : $signed(_GEN_268); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_270 = 7'h7d == data1Frac_1 ? $signed(8'sh21) : $signed(_GEN_269); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_271 = 7'h7e == data1Frac_1 ? $signed(8'sh20) : $signed(_GEN_270); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_272 = 7'h7f == data1Frac_1 ? $signed(8'sh20) : $signed(_GEN_271); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_5 = $signed(_GEN_272) >>> data1Int_1; // @[exponent.scala 46:85]
  reg [7:0] data2_1; // @[Reg.scala 16:16]
  wire [7:0] _GEN_276 = 7'h2 == data1Frac_2 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_277 = 7'h3 == data1Frac_2 ? $signed(8'sh3f) : $signed(_GEN_276); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_278 = 7'h4 == data1Frac_2 ? $signed(8'sh3f) : $signed(_GEN_277); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_279 = 7'h5 == data1Frac_2 ? $signed(8'sh3e) : $signed(_GEN_278); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_280 = 7'h6 == data1Frac_2 ? $signed(8'sh3e) : $signed(_GEN_279); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_281 = 7'h7 == data1Frac_2 ? $signed(8'sh3e) : $signed(_GEN_280); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_282 = 7'h8 == data1Frac_2 ? $signed(8'sh3d) : $signed(_GEN_281); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_283 = 7'h9 == data1Frac_2 ? $signed(8'sh3d) : $signed(_GEN_282); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_284 = 7'ha == data1Frac_2 ? $signed(8'sh3d) : $signed(_GEN_283); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_285 = 7'hb == data1Frac_2 ? $signed(8'sh3c) : $signed(_GEN_284); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_286 = 7'hc == data1Frac_2 ? $signed(8'sh3c) : $signed(_GEN_285); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_287 = 7'hd == data1Frac_2 ? $signed(8'sh3c) : $signed(_GEN_286); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_288 = 7'he == data1Frac_2 ? $signed(8'sh3b) : $signed(_GEN_287); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_289 = 7'hf == data1Frac_2 ? $signed(8'sh3b) : $signed(_GEN_288); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_290 = 7'h10 == data1Frac_2 ? $signed(8'sh3b) : $signed(_GEN_289); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_291 = 7'h11 == data1Frac_2 ? $signed(8'sh3a) : $signed(_GEN_290); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_292 = 7'h12 == data1Frac_2 ? $signed(8'sh3a) : $signed(_GEN_291); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_293 = 7'h13 == data1Frac_2 ? $signed(8'sh3a) : $signed(_GEN_292); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_294 = 7'h14 == data1Frac_2 ? $signed(8'sh39) : $signed(_GEN_293); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_295 = 7'h15 == data1Frac_2 ? $signed(8'sh39) : $signed(_GEN_294); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_296 = 7'h16 == data1Frac_2 ? $signed(8'sh39) : $signed(_GEN_295); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_297 = 7'h17 == data1Frac_2 ? $signed(8'sh39) : $signed(_GEN_296); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_298 = 7'h18 == data1Frac_2 ? $signed(8'sh38) : $signed(_GEN_297); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_299 = 7'h19 == data1Frac_2 ? $signed(8'sh38) : $signed(_GEN_298); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_300 = 7'h1a == data1Frac_2 ? $signed(8'sh38) : $signed(_GEN_299); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_301 = 7'h1b == data1Frac_2 ? $signed(8'sh37) : $signed(_GEN_300); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_302 = 7'h1c == data1Frac_2 ? $signed(8'sh37) : $signed(_GEN_301); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_303 = 7'h1d == data1Frac_2 ? $signed(8'sh37) : $signed(_GEN_302); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_304 = 7'h1e == data1Frac_2 ? $signed(8'sh36) : $signed(_GEN_303); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_305 = 7'h1f == data1Frac_2 ? $signed(8'sh36) : $signed(_GEN_304); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_306 = 7'h20 == data1Frac_2 ? $signed(8'sh36) : $signed(_GEN_305); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_307 = 7'h21 == data1Frac_2 ? $signed(8'sh36) : $signed(_GEN_306); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_308 = 7'h22 == data1Frac_2 ? $signed(8'sh35) : $signed(_GEN_307); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_309 = 7'h23 == data1Frac_2 ? $signed(8'sh35) : $signed(_GEN_308); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_310 = 7'h24 == data1Frac_2 ? $signed(8'sh35) : $signed(_GEN_309); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_311 = 7'h25 == data1Frac_2 ? $signed(8'sh34) : $signed(_GEN_310); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_312 = 7'h26 == data1Frac_2 ? $signed(8'sh34) : $signed(_GEN_311); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_313 = 7'h27 == data1Frac_2 ? $signed(8'sh34) : $signed(_GEN_312); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_314 = 7'h28 == data1Frac_2 ? $signed(8'sh34) : $signed(_GEN_313); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_315 = 7'h29 == data1Frac_2 ? $signed(8'sh33) : $signed(_GEN_314); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_316 = 7'h2a == data1Frac_2 ? $signed(8'sh33) : $signed(_GEN_315); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_317 = 7'h2b == data1Frac_2 ? $signed(8'sh33) : $signed(_GEN_316); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_318 = 7'h2c == data1Frac_2 ? $signed(8'sh32) : $signed(_GEN_317); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_319 = 7'h2d == data1Frac_2 ? $signed(8'sh32) : $signed(_GEN_318); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_320 = 7'h2e == data1Frac_2 ? $signed(8'sh32) : $signed(_GEN_319); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_321 = 7'h2f == data1Frac_2 ? $signed(8'sh32) : $signed(_GEN_320); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_322 = 7'h30 == data1Frac_2 ? $signed(8'sh31) : $signed(_GEN_321); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_323 = 7'h31 == data1Frac_2 ? $signed(8'sh31) : $signed(_GEN_322); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_324 = 7'h32 == data1Frac_2 ? $signed(8'sh31) : $signed(_GEN_323); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_325 = 7'h33 == data1Frac_2 ? $signed(8'sh31) : $signed(_GEN_324); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_326 = 7'h34 == data1Frac_2 ? $signed(8'sh30) : $signed(_GEN_325); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_327 = 7'h35 == data1Frac_2 ? $signed(8'sh30) : $signed(_GEN_326); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_328 = 7'h36 == data1Frac_2 ? $signed(8'sh30) : $signed(_GEN_327); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_329 = 7'h37 == data1Frac_2 ? $signed(8'sh30) : $signed(_GEN_328); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_330 = 7'h38 == data1Frac_2 ? $signed(8'sh2f) : $signed(_GEN_329); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_331 = 7'h39 == data1Frac_2 ? $signed(8'sh2f) : $signed(_GEN_330); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_332 = 7'h3a == data1Frac_2 ? $signed(8'sh2f) : $signed(_GEN_331); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_333 = 7'h3b == data1Frac_2 ? $signed(8'sh2e) : $signed(_GEN_332); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_334 = 7'h3c == data1Frac_2 ? $signed(8'sh2e) : $signed(_GEN_333); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_335 = 7'h3d == data1Frac_2 ? $signed(8'sh2e) : $signed(_GEN_334); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_336 = 7'h3e == data1Frac_2 ? $signed(8'sh2e) : $signed(_GEN_335); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_337 = 7'h3f == data1Frac_2 ? $signed(8'sh2e) : $signed(_GEN_336); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_338 = 7'h40 == data1Frac_2 ? $signed(8'sh2d) : $signed(_GEN_337); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_339 = 7'h41 == data1Frac_2 ? $signed(8'sh2d) : $signed(_GEN_338); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_340 = 7'h42 == data1Frac_2 ? $signed(8'sh2d) : $signed(_GEN_339); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_341 = 7'h43 == data1Frac_2 ? $signed(8'sh2d) : $signed(_GEN_340); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_342 = 7'h44 == data1Frac_2 ? $signed(8'sh2c) : $signed(_GEN_341); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_343 = 7'h45 == data1Frac_2 ? $signed(8'sh2c) : $signed(_GEN_342); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_344 = 7'h46 == data1Frac_2 ? $signed(8'sh2c) : $signed(_GEN_343); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_345 = 7'h47 == data1Frac_2 ? $signed(8'sh2c) : $signed(_GEN_344); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_346 = 7'h48 == data1Frac_2 ? $signed(8'sh2b) : $signed(_GEN_345); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_347 = 7'h49 == data1Frac_2 ? $signed(8'sh2b) : $signed(_GEN_346); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_348 = 7'h4a == data1Frac_2 ? $signed(8'sh2b) : $signed(_GEN_347); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_349 = 7'h4b == data1Frac_2 ? $signed(8'sh2b) : $signed(_GEN_348); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_350 = 7'h4c == data1Frac_2 ? $signed(8'sh2a) : $signed(_GEN_349); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_351 = 7'h4d == data1Frac_2 ? $signed(8'sh2a) : $signed(_GEN_350); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_352 = 7'h4e == data1Frac_2 ? $signed(8'sh2a) : $signed(_GEN_351); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_353 = 7'h4f == data1Frac_2 ? $signed(8'sh2a) : $signed(_GEN_352); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_354 = 7'h50 == data1Frac_2 ? $signed(8'sh29) : $signed(_GEN_353); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_355 = 7'h51 == data1Frac_2 ? $signed(8'sh29) : $signed(_GEN_354); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_356 = 7'h52 == data1Frac_2 ? $signed(8'sh29) : $signed(_GEN_355); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_357 = 7'h53 == data1Frac_2 ? $signed(8'sh29) : $signed(_GEN_356); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_358 = 7'h54 == data1Frac_2 ? $signed(8'sh29) : $signed(_GEN_357); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_359 = 7'h55 == data1Frac_2 ? $signed(8'sh28) : $signed(_GEN_358); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_360 = 7'h56 == data1Frac_2 ? $signed(8'sh28) : $signed(_GEN_359); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_361 = 7'h57 == data1Frac_2 ? $signed(8'sh28) : $signed(_GEN_360); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_362 = 7'h58 == data1Frac_2 ? $signed(8'sh28) : $signed(_GEN_361); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_363 = 7'h59 == data1Frac_2 ? $signed(8'sh28) : $signed(_GEN_362); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_364 = 7'h5a == data1Frac_2 ? $signed(8'sh27) : $signed(_GEN_363); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_365 = 7'h5b == data1Frac_2 ? $signed(8'sh27) : $signed(_GEN_364); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_366 = 7'h5c == data1Frac_2 ? $signed(8'sh27) : $signed(_GEN_365); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_367 = 7'h5d == data1Frac_2 ? $signed(8'sh27) : $signed(_GEN_366); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_368 = 7'h5e == data1Frac_2 ? $signed(8'sh26) : $signed(_GEN_367); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_369 = 7'h5f == data1Frac_2 ? $signed(8'sh26) : $signed(_GEN_368); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_370 = 7'h60 == data1Frac_2 ? $signed(8'sh26) : $signed(_GEN_369); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_371 = 7'h61 == data1Frac_2 ? $signed(8'sh26) : $signed(_GEN_370); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_372 = 7'h62 == data1Frac_2 ? $signed(8'sh26) : $signed(_GEN_371); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_373 = 7'h63 == data1Frac_2 ? $signed(8'sh25) : $signed(_GEN_372); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_374 = 7'h64 == data1Frac_2 ? $signed(8'sh25) : $signed(_GEN_373); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_375 = 7'h65 == data1Frac_2 ? $signed(8'sh25) : $signed(_GEN_374); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_376 = 7'h66 == data1Frac_2 ? $signed(8'sh25) : $signed(_GEN_375); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_377 = 7'h67 == data1Frac_2 ? $signed(8'sh25) : $signed(_GEN_376); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_378 = 7'h68 == data1Frac_2 ? $signed(8'sh24) : $signed(_GEN_377); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_379 = 7'h69 == data1Frac_2 ? $signed(8'sh24) : $signed(_GEN_378); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_380 = 7'h6a == data1Frac_2 ? $signed(8'sh24) : $signed(_GEN_379); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_381 = 7'h6b == data1Frac_2 ? $signed(8'sh24) : $signed(_GEN_380); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_382 = 7'h6c == data1Frac_2 ? $signed(8'sh24) : $signed(_GEN_381); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_383 = 7'h6d == data1Frac_2 ? $signed(8'sh23) : $signed(_GEN_382); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_384 = 7'h6e == data1Frac_2 ? $signed(8'sh23) : $signed(_GEN_383); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_385 = 7'h6f == data1Frac_2 ? $signed(8'sh23) : $signed(_GEN_384); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_386 = 7'h70 == data1Frac_2 ? $signed(8'sh23) : $signed(_GEN_385); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_387 = 7'h71 == data1Frac_2 ? $signed(8'sh23) : $signed(_GEN_386); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_388 = 7'h72 == data1Frac_2 ? $signed(8'sh23) : $signed(_GEN_387); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_389 = 7'h73 == data1Frac_2 ? $signed(8'sh22) : $signed(_GEN_388); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_390 = 7'h74 == data1Frac_2 ? $signed(8'sh22) : $signed(_GEN_389); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_391 = 7'h75 == data1Frac_2 ? $signed(8'sh22) : $signed(_GEN_390); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_392 = 7'h76 == data1Frac_2 ? $signed(8'sh22) : $signed(_GEN_391); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_393 = 7'h77 == data1Frac_2 ? $signed(8'sh22) : $signed(_GEN_392); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_394 = 7'h78 == data1Frac_2 ? $signed(8'sh21) : $signed(_GEN_393); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_395 = 7'h79 == data1Frac_2 ? $signed(8'sh21) : $signed(_GEN_394); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_396 = 7'h7a == data1Frac_2 ? $signed(8'sh21) : $signed(_GEN_395); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_397 = 7'h7b == data1Frac_2 ? $signed(8'sh21) : $signed(_GEN_396); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_398 = 7'h7c == data1Frac_2 ? $signed(8'sh21) : $signed(_GEN_397); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_399 = 7'h7d == data1Frac_2 ? $signed(8'sh21) : $signed(_GEN_398); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_400 = 7'h7e == data1Frac_2 ? $signed(8'sh20) : $signed(_GEN_399); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_401 = 7'h7f == data1Frac_2 ? $signed(8'sh20) : $signed(_GEN_400); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_8 = $signed(_GEN_401) >>> data1Int_2; // @[exponent.scala 46:85]
  reg [7:0] data2_2; // @[Reg.scala 16:16]
  wire [7:0] _GEN_405 = 7'h2 == data1Frac_3 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_406 = 7'h3 == data1Frac_3 ? $signed(8'sh3f) : $signed(_GEN_405); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_407 = 7'h4 == data1Frac_3 ? $signed(8'sh3f) : $signed(_GEN_406); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_408 = 7'h5 == data1Frac_3 ? $signed(8'sh3e) : $signed(_GEN_407); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_409 = 7'h6 == data1Frac_3 ? $signed(8'sh3e) : $signed(_GEN_408); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_410 = 7'h7 == data1Frac_3 ? $signed(8'sh3e) : $signed(_GEN_409); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_411 = 7'h8 == data1Frac_3 ? $signed(8'sh3d) : $signed(_GEN_410); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_412 = 7'h9 == data1Frac_3 ? $signed(8'sh3d) : $signed(_GEN_411); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_413 = 7'ha == data1Frac_3 ? $signed(8'sh3d) : $signed(_GEN_412); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_414 = 7'hb == data1Frac_3 ? $signed(8'sh3c) : $signed(_GEN_413); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_415 = 7'hc == data1Frac_3 ? $signed(8'sh3c) : $signed(_GEN_414); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_416 = 7'hd == data1Frac_3 ? $signed(8'sh3c) : $signed(_GEN_415); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_417 = 7'he == data1Frac_3 ? $signed(8'sh3b) : $signed(_GEN_416); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_418 = 7'hf == data1Frac_3 ? $signed(8'sh3b) : $signed(_GEN_417); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_419 = 7'h10 == data1Frac_3 ? $signed(8'sh3b) : $signed(_GEN_418); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_420 = 7'h11 == data1Frac_3 ? $signed(8'sh3a) : $signed(_GEN_419); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_421 = 7'h12 == data1Frac_3 ? $signed(8'sh3a) : $signed(_GEN_420); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_422 = 7'h13 == data1Frac_3 ? $signed(8'sh3a) : $signed(_GEN_421); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_423 = 7'h14 == data1Frac_3 ? $signed(8'sh39) : $signed(_GEN_422); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_424 = 7'h15 == data1Frac_3 ? $signed(8'sh39) : $signed(_GEN_423); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_425 = 7'h16 == data1Frac_3 ? $signed(8'sh39) : $signed(_GEN_424); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_426 = 7'h17 == data1Frac_3 ? $signed(8'sh39) : $signed(_GEN_425); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_427 = 7'h18 == data1Frac_3 ? $signed(8'sh38) : $signed(_GEN_426); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_428 = 7'h19 == data1Frac_3 ? $signed(8'sh38) : $signed(_GEN_427); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_429 = 7'h1a == data1Frac_3 ? $signed(8'sh38) : $signed(_GEN_428); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_430 = 7'h1b == data1Frac_3 ? $signed(8'sh37) : $signed(_GEN_429); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_431 = 7'h1c == data1Frac_3 ? $signed(8'sh37) : $signed(_GEN_430); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_432 = 7'h1d == data1Frac_3 ? $signed(8'sh37) : $signed(_GEN_431); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_433 = 7'h1e == data1Frac_3 ? $signed(8'sh36) : $signed(_GEN_432); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_434 = 7'h1f == data1Frac_3 ? $signed(8'sh36) : $signed(_GEN_433); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_435 = 7'h20 == data1Frac_3 ? $signed(8'sh36) : $signed(_GEN_434); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_436 = 7'h21 == data1Frac_3 ? $signed(8'sh36) : $signed(_GEN_435); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_437 = 7'h22 == data1Frac_3 ? $signed(8'sh35) : $signed(_GEN_436); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_438 = 7'h23 == data1Frac_3 ? $signed(8'sh35) : $signed(_GEN_437); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_439 = 7'h24 == data1Frac_3 ? $signed(8'sh35) : $signed(_GEN_438); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_440 = 7'h25 == data1Frac_3 ? $signed(8'sh34) : $signed(_GEN_439); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_441 = 7'h26 == data1Frac_3 ? $signed(8'sh34) : $signed(_GEN_440); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_442 = 7'h27 == data1Frac_3 ? $signed(8'sh34) : $signed(_GEN_441); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_443 = 7'h28 == data1Frac_3 ? $signed(8'sh34) : $signed(_GEN_442); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_444 = 7'h29 == data1Frac_3 ? $signed(8'sh33) : $signed(_GEN_443); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_445 = 7'h2a == data1Frac_3 ? $signed(8'sh33) : $signed(_GEN_444); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_446 = 7'h2b == data1Frac_3 ? $signed(8'sh33) : $signed(_GEN_445); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_447 = 7'h2c == data1Frac_3 ? $signed(8'sh32) : $signed(_GEN_446); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_448 = 7'h2d == data1Frac_3 ? $signed(8'sh32) : $signed(_GEN_447); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_449 = 7'h2e == data1Frac_3 ? $signed(8'sh32) : $signed(_GEN_448); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_450 = 7'h2f == data1Frac_3 ? $signed(8'sh32) : $signed(_GEN_449); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_451 = 7'h30 == data1Frac_3 ? $signed(8'sh31) : $signed(_GEN_450); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_452 = 7'h31 == data1Frac_3 ? $signed(8'sh31) : $signed(_GEN_451); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_453 = 7'h32 == data1Frac_3 ? $signed(8'sh31) : $signed(_GEN_452); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_454 = 7'h33 == data1Frac_3 ? $signed(8'sh31) : $signed(_GEN_453); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_455 = 7'h34 == data1Frac_3 ? $signed(8'sh30) : $signed(_GEN_454); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_456 = 7'h35 == data1Frac_3 ? $signed(8'sh30) : $signed(_GEN_455); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_457 = 7'h36 == data1Frac_3 ? $signed(8'sh30) : $signed(_GEN_456); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_458 = 7'h37 == data1Frac_3 ? $signed(8'sh30) : $signed(_GEN_457); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_459 = 7'h38 == data1Frac_3 ? $signed(8'sh2f) : $signed(_GEN_458); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_460 = 7'h39 == data1Frac_3 ? $signed(8'sh2f) : $signed(_GEN_459); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_461 = 7'h3a == data1Frac_3 ? $signed(8'sh2f) : $signed(_GEN_460); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_462 = 7'h3b == data1Frac_3 ? $signed(8'sh2e) : $signed(_GEN_461); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_463 = 7'h3c == data1Frac_3 ? $signed(8'sh2e) : $signed(_GEN_462); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_464 = 7'h3d == data1Frac_3 ? $signed(8'sh2e) : $signed(_GEN_463); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_465 = 7'h3e == data1Frac_3 ? $signed(8'sh2e) : $signed(_GEN_464); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_466 = 7'h3f == data1Frac_3 ? $signed(8'sh2e) : $signed(_GEN_465); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_467 = 7'h40 == data1Frac_3 ? $signed(8'sh2d) : $signed(_GEN_466); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_468 = 7'h41 == data1Frac_3 ? $signed(8'sh2d) : $signed(_GEN_467); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_469 = 7'h42 == data1Frac_3 ? $signed(8'sh2d) : $signed(_GEN_468); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_470 = 7'h43 == data1Frac_3 ? $signed(8'sh2d) : $signed(_GEN_469); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_471 = 7'h44 == data1Frac_3 ? $signed(8'sh2c) : $signed(_GEN_470); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_472 = 7'h45 == data1Frac_3 ? $signed(8'sh2c) : $signed(_GEN_471); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_473 = 7'h46 == data1Frac_3 ? $signed(8'sh2c) : $signed(_GEN_472); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_474 = 7'h47 == data1Frac_3 ? $signed(8'sh2c) : $signed(_GEN_473); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_475 = 7'h48 == data1Frac_3 ? $signed(8'sh2b) : $signed(_GEN_474); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_476 = 7'h49 == data1Frac_3 ? $signed(8'sh2b) : $signed(_GEN_475); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_477 = 7'h4a == data1Frac_3 ? $signed(8'sh2b) : $signed(_GEN_476); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_478 = 7'h4b == data1Frac_3 ? $signed(8'sh2b) : $signed(_GEN_477); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_479 = 7'h4c == data1Frac_3 ? $signed(8'sh2a) : $signed(_GEN_478); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_480 = 7'h4d == data1Frac_3 ? $signed(8'sh2a) : $signed(_GEN_479); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_481 = 7'h4e == data1Frac_3 ? $signed(8'sh2a) : $signed(_GEN_480); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_482 = 7'h4f == data1Frac_3 ? $signed(8'sh2a) : $signed(_GEN_481); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_483 = 7'h50 == data1Frac_3 ? $signed(8'sh29) : $signed(_GEN_482); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_484 = 7'h51 == data1Frac_3 ? $signed(8'sh29) : $signed(_GEN_483); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_485 = 7'h52 == data1Frac_3 ? $signed(8'sh29) : $signed(_GEN_484); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_486 = 7'h53 == data1Frac_3 ? $signed(8'sh29) : $signed(_GEN_485); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_487 = 7'h54 == data1Frac_3 ? $signed(8'sh29) : $signed(_GEN_486); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_488 = 7'h55 == data1Frac_3 ? $signed(8'sh28) : $signed(_GEN_487); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_489 = 7'h56 == data1Frac_3 ? $signed(8'sh28) : $signed(_GEN_488); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_490 = 7'h57 == data1Frac_3 ? $signed(8'sh28) : $signed(_GEN_489); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_491 = 7'h58 == data1Frac_3 ? $signed(8'sh28) : $signed(_GEN_490); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_492 = 7'h59 == data1Frac_3 ? $signed(8'sh28) : $signed(_GEN_491); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_493 = 7'h5a == data1Frac_3 ? $signed(8'sh27) : $signed(_GEN_492); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_494 = 7'h5b == data1Frac_3 ? $signed(8'sh27) : $signed(_GEN_493); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_495 = 7'h5c == data1Frac_3 ? $signed(8'sh27) : $signed(_GEN_494); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_496 = 7'h5d == data1Frac_3 ? $signed(8'sh27) : $signed(_GEN_495); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_497 = 7'h5e == data1Frac_3 ? $signed(8'sh26) : $signed(_GEN_496); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_498 = 7'h5f == data1Frac_3 ? $signed(8'sh26) : $signed(_GEN_497); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_499 = 7'h60 == data1Frac_3 ? $signed(8'sh26) : $signed(_GEN_498); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_500 = 7'h61 == data1Frac_3 ? $signed(8'sh26) : $signed(_GEN_499); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_501 = 7'h62 == data1Frac_3 ? $signed(8'sh26) : $signed(_GEN_500); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_502 = 7'h63 == data1Frac_3 ? $signed(8'sh25) : $signed(_GEN_501); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_503 = 7'h64 == data1Frac_3 ? $signed(8'sh25) : $signed(_GEN_502); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_504 = 7'h65 == data1Frac_3 ? $signed(8'sh25) : $signed(_GEN_503); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_505 = 7'h66 == data1Frac_3 ? $signed(8'sh25) : $signed(_GEN_504); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_506 = 7'h67 == data1Frac_3 ? $signed(8'sh25) : $signed(_GEN_505); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_507 = 7'h68 == data1Frac_3 ? $signed(8'sh24) : $signed(_GEN_506); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_508 = 7'h69 == data1Frac_3 ? $signed(8'sh24) : $signed(_GEN_507); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_509 = 7'h6a == data1Frac_3 ? $signed(8'sh24) : $signed(_GEN_508); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_510 = 7'h6b == data1Frac_3 ? $signed(8'sh24) : $signed(_GEN_509); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_511 = 7'h6c == data1Frac_3 ? $signed(8'sh24) : $signed(_GEN_510); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_512 = 7'h6d == data1Frac_3 ? $signed(8'sh23) : $signed(_GEN_511); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_513 = 7'h6e == data1Frac_3 ? $signed(8'sh23) : $signed(_GEN_512); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_514 = 7'h6f == data1Frac_3 ? $signed(8'sh23) : $signed(_GEN_513); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_515 = 7'h70 == data1Frac_3 ? $signed(8'sh23) : $signed(_GEN_514); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_516 = 7'h71 == data1Frac_3 ? $signed(8'sh23) : $signed(_GEN_515); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_517 = 7'h72 == data1Frac_3 ? $signed(8'sh23) : $signed(_GEN_516); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_518 = 7'h73 == data1Frac_3 ? $signed(8'sh22) : $signed(_GEN_517); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_519 = 7'h74 == data1Frac_3 ? $signed(8'sh22) : $signed(_GEN_518); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_520 = 7'h75 == data1Frac_3 ? $signed(8'sh22) : $signed(_GEN_519); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_521 = 7'h76 == data1Frac_3 ? $signed(8'sh22) : $signed(_GEN_520); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_522 = 7'h77 == data1Frac_3 ? $signed(8'sh22) : $signed(_GEN_521); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_523 = 7'h78 == data1Frac_3 ? $signed(8'sh21) : $signed(_GEN_522); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_524 = 7'h79 == data1Frac_3 ? $signed(8'sh21) : $signed(_GEN_523); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_525 = 7'h7a == data1Frac_3 ? $signed(8'sh21) : $signed(_GEN_524); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_526 = 7'h7b == data1Frac_3 ? $signed(8'sh21) : $signed(_GEN_525); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_527 = 7'h7c == data1Frac_3 ? $signed(8'sh21) : $signed(_GEN_526); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_528 = 7'h7d == data1Frac_3 ? $signed(8'sh21) : $signed(_GEN_527); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_529 = 7'h7e == data1Frac_3 ? $signed(8'sh20) : $signed(_GEN_528); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_530 = 7'h7f == data1Frac_3 ? $signed(8'sh20) : $signed(_GEN_529); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_11 = $signed(_GEN_530) >>> data1Int_3; // @[exponent.scala 46:85]
  reg [7:0] data2_3; // @[Reg.scala 16:16]
  wire [7:0] _GEN_534 = 7'h2 == data1Frac_4 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_535 = 7'h3 == data1Frac_4 ? $signed(8'sh3f) : $signed(_GEN_534); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_536 = 7'h4 == data1Frac_4 ? $signed(8'sh3f) : $signed(_GEN_535); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_537 = 7'h5 == data1Frac_4 ? $signed(8'sh3e) : $signed(_GEN_536); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_538 = 7'h6 == data1Frac_4 ? $signed(8'sh3e) : $signed(_GEN_537); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_539 = 7'h7 == data1Frac_4 ? $signed(8'sh3e) : $signed(_GEN_538); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_540 = 7'h8 == data1Frac_4 ? $signed(8'sh3d) : $signed(_GEN_539); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_541 = 7'h9 == data1Frac_4 ? $signed(8'sh3d) : $signed(_GEN_540); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_542 = 7'ha == data1Frac_4 ? $signed(8'sh3d) : $signed(_GEN_541); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_543 = 7'hb == data1Frac_4 ? $signed(8'sh3c) : $signed(_GEN_542); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_544 = 7'hc == data1Frac_4 ? $signed(8'sh3c) : $signed(_GEN_543); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_545 = 7'hd == data1Frac_4 ? $signed(8'sh3c) : $signed(_GEN_544); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_546 = 7'he == data1Frac_4 ? $signed(8'sh3b) : $signed(_GEN_545); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_547 = 7'hf == data1Frac_4 ? $signed(8'sh3b) : $signed(_GEN_546); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_548 = 7'h10 == data1Frac_4 ? $signed(8'sh3b) : $signed(_GEN_547); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_549 = 7'h11 == data1Frac_4 ? $signed(8'sh3a) : $signed(_GEN_548); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_550 = 7'h12 == data1Frac_4 ? $signed(8'sh3a) : $signed(_GEN_549); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_551 = 7'h13 == data1Frac_4 ? $signed(8'sh3a) : $signed(_GEN_550); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_552 = 7'h14 == data1Frac_4 ? $signed(8'sh39) : $signed(_GEN_551); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_553 = 7'h15 == data1Frac_4 ? $signed(8'sh39) : $signed(_GEN_552); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_554 = 7'h16 == data1Frac_4 ? $signed(8'sh39) : $signed(_GEN_553); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_555 = 7'h17 == data1Frac_4 ? $signed(8'sh39) : $signed(_GEN_554); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_556 = 7'h18 == data1Frac_4 ? $signed(8'sh38) : $signed(_GEN_555); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_557 = 7'h19 == data1Frac_4 ? $signed(8'sh38) : $signed(_GEN_556); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_558 = 7'h1a == data1Frac_4 ? $signed(8'sh38) : $signed(_GEN_557); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_559 = 7'h1b == data1Frac_4 ? $signed(8'sh37) : $signed(_GEN_558); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_560 = 7'h1c == data1Frac_4 ? $signed(8'sh37) : $signed(_GEN_559); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_561 = 7'h1d == data1Frac_4 ? $signed(8'sh37) : $signed(_GEN_560); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_562 = 7'h1e == data1Frac_4 ? $signed(8'sh36) : $signed(_GEN_561); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_563 = 7'h1f == data1Frac_4 ? $signed(8'sh36) : $signed(_GEN_562); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_564 = 7'h20 == data1Frac_4 ? $signed(8'sh36) : $signed(_GEN_563); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_565 = 7'h21 == data1Frac_4 ? $signed(8'sh36) : $signed(_GEN_564); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_566 = 7'h22 == data1Frac_4 ? $signed(8'sh35) : $signed(_GEN_565); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_567 = 7'h23 == data1Frac_4 ? $signed(8'sh35) : $signed(_GEN_566); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_568 = 7'h24 == data1Frac_4 ? $signed(8'sh35) : $signed(_GEN_567); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_569 = 7'h25 == data1Frac_4 ? $signed(8'sh34) : $signed(_GEN_568); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_570 = 7'h26 == data1Frac_4 ? $signed(8'sh34) : $signed(_GEN_569); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_571 = 7'h27 == data1Frac_4 ? $signed(8'sh34) : $signed(_GEN_570); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_572 = 7'h28 == data1Frac_4 ? $signed(8'sh34) : $signed(_GEN_571); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_573 = 7'h29 == data1Frac_4 ? $signed(8'sh33) : $signed(_GEN_572); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_574 = 7'h2a == data1Frac_4 ? $signed(8'sh33) : $signed(_GEN_573); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_575 = 7'h2b == data1Frac_4 ? $signed(8'sh33) : $signed(_GEN_574); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_576 = 7'h2c == data1Frac_4 ? $signed(8'sh32) : $signed(_GEN_575); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_577 = 7'h2d == data1Frac_4 ? $signed(8'sh32) : $signed(_GEN_576); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_578 = 7'h2e == data1Frac_4 ? $signed(8'sh32) : $signed(_GEN_577); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_579 = 7'h2f == data1Frac_4 ? $signed(8'sh32) : $signed(_GEN_578); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_580 = 7'h30 == data1Frac_4 ? $signed(8'sh31) : $signed(_GEN_579); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_581 = 7'h31 == data1Frac_4 ? $signed(8'sh31) : $signed(_GEN_580); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_582 = 7'h32 == data1Frac_4 ? $signed(8'sh31) : $signed(_GEN_581); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_583 = 7'h33 == data1Frac_4 ? $signed(8'sh31) : $signed(_GEN_582); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_584 = 7'h34 == data1Frac_4 ? $signed(8'sh30) : $signed(_GEN_583); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_585 = 7'h35 == data1Frac_4 ? $signed(8'sh30) : $signed(_GEN_584); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_586 = 7'h36 == data1Frac_4 ? $signed(8'sh30) : $signed(_GEN_585); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_587 = 7'h37 == data1Frac_4 ? $signed(8'sh30) : $signed(_GEN_586); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_588 = 7'h38 == data1Frac_4 ? $signed(8'sh2f) : $signed(_GEN_587); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_589 = 7'h39 == data1Frac_4 ? $signed(8'sh2f) : $signed(_GEN_588); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_590 = 7'h3a == data1Frac_4 ? $signed(8'sh2f) : $signed(_GEN_589); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_591 = 7'h3b == data1Frac_4 ? $signed(8'sh2e) : $signed(_GEN_590); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_592 = 7'h3c == data1Frac_4 ? $signed(8'sh2e) : $signed(_GEN_591); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_593 = 7'h3d == data1Frac_4 ? $signed(8'sh2e) : $signed(_GEN_592); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_594 = 7'h3e == data1Frac_4 ? $signed(8'sh2e) : $signed(_GEN_593); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_595 = 7'h3f == data1Frac_4 ? $signed(8'sh2e) : $signed(_GEN_594); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_596 = 7'h40 == data1Frac_4 ? $signed(8'sh2d) : $signed(_GEN_595); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_597 = 7'h41 == data1Frac_4 ? $signed(8'sh2d) : $signed(_GEN_596); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_598 = 7'h42 == data1Frac_4 ? $signed(8'sh2d) : $signed(_GEN_597); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_599 = 7'h43 == data1Frac_4 ? $signed(8'sh2d) : $signed(_GEN_598); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_600 = 7'h44 == data1Frac_4 ? $signed(8'sh2c) : $signed(_GEN_599); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_601 = 7'h45 == data1Frac_4 ? $signed(8'sh2c) : $signed(_GEN_600); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_602 = 7'h46 == data1Frac_4 ? $signed(8'sh2c) : $signed(_GEN_601); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_603 = 7'h47 == data1Frac_4 ? $signed(8'sh2c) : $signed(_GEN_602); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_604 = 7'h48 == data1Frac_4 ? $signed(8'sh2b) : $signed(_GEN_603); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_605 = 7'h49 == data1Frac_4 ? $signed(8'sh2b) : $signed(_GEN_604); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_606 = 7'h4a == data1Frac_4 ? $signed(8'sh2b) : $signed(_GEN_605); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_607 = 7'h4b == data1Frac_4 ? $signed(8'sh2b) : $signed(_GEN_606); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_608 = 7'h4c == data1Frac_4 ? $signed(8'sh2a) : $signed(_GEN_607); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_609 = 7'h4d == data1Frac_4 ? $signed(8'sh2a) : $signed(_GEN_608); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_610 = 7'h4e == data1Frac_4 ? $signed(8'sh2a) : $signed(_GEN_609); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_611 = 7'h4f == data1Frac_4 ? $signed(8'sh2a) : $signed(_GEN_610); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_612 = 7'h50 == data1Frac_4 ? $signed(8'sh29) : $signed(_GEN_611); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_613 = 7'h51 == data1Frac_4 ? $signed(8'sh29) : $signed(_GEN_612); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_614 = 7'h52 == data1Frac_4 ? $signed(8'sh29) : $signed(_GEN_613); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_615 = 7'h53 == data1Frac_4 ? $signed(8'sh29) : $signed(_GEN_614); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_616 = 7'h54 == data1Frac_4 ? $signed(8'sh29) : $signed(_GEN_615); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_617 = 7'h55 == data1Frac_4 ? $signed(8'sh28) : $signed(_GEN_616); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_618 = 7'h56 == data1Frac_4 ? $signed(8'sh28) : $signed(_GEN_617); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_619 = 7'h57 == data1Frac_4 ? $signed(8'sh28) : $signed(_GEN_618); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_620 = 7'h58 == data1Frac_4 ? $signed(8'sh28) : $signed(_GEN_619); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_621 = 7'h59 == data1Frac_4 ? $signed(8'sh28) : $signed(_GEN_620); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_622 = 7'h5a == data1Frac_4 ? $signed(8'sh27) : $signed(_GEN_621); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_623 = 7'h5b == data1Frac_4 ? $signed(8'sh27) : $signed(_GEN_622); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_624 = 7'h5c == data1Frac_4 ? $signed(8'sh27) : $signed(_GEN_623); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_625 = 7'h5d == data1Frac_4 ? $signed(8'sh27) : $signed(_GEN_624); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_626 = 7'h5e == data1Frac_4 ? $signed(8'sh26) : $signed(_GEN_625); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_627 = 7'h5f == data1Frac_4 ? $signed(8'sh26) : $signed(_GEN_626); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_628 = 7'h60 == data1Frac_4 ? $signed(8'sh26) : $signed(_GEN_627); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_629 = 7'h61 == data1Frac_4 ? $signed(8'sh26) : $signed(_GEN_628); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_630 = 7'h62 == data1Frac_4 ? $signed(8'sh26) : $signed(_GEN_629); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_631 = 7'h63 == data1Frac_4 ? $signed(8'sh25) : $signed(_GEN_630); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_632 = 7'h64 == data1Frac_4 ? $signed(8'sh25) : $signed(_GEN_631); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_633 = 7'h65 == data1Frac_4 ? $signed(8'sh25) : $signed(_GEN_632); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_634 = 7'h66 == data1Frac_4 ? $signed(8'sh25) : $signed(_GEN_633); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_635 = 7'h67 == data1Frac_4 ? $signed(8'sh25) : $signed(_GEN_634); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_636 = 7'h68 == data1Frac_4 ? $signed(8'sh24) : $signed(_GEN_635); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_637 = 7'h69 == data1Frac_4 ? $signed(8'sh24) : $signed(_GEN_636); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_638 = 7'h6a == data1Frac_4 ? $signed(8'sh24) : $signed(_GEN_637); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_639 = 7'h6b == data1Frac_4 ? $signed(8'sh24) : $signed(_GEN_638); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_640 = 7'h6c == data1Frac_4 ? $signed(8'sh24) : $signed(_GEN_639); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_641 = 7'h6d == data1Frac_4 ? $signed(8'sh23) : $signed(_GEN_640); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_642 = 7'h6e == data1Frac_4 ? $signed(8'sh23) : $signed(_GEN_641); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_643 = 7'h6f == data1Frac_4 ? $signed(8'sh23) : $signed(_GEN_642); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_644 = 7'h70 == data1Frac_4 ? $signed(8'sh23) : $signed(_GEN_643); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_645 = 7'h71 == data1Frac_4 ? $signed(8'sh23) : $signed(_GEN_644); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_646 = 7'h72 == data1Frac_4 ? $signed(8'sh23) : $signed(_GEN_645); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_647 = 7'h73 == data1Frac_4 ? $signed(8'sh22) : $signed(_GEN_646); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_648 = 7'h74 == data1Frac_4 ? $signed(8'sh22) : $signed(_GEN_647); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_649 = 7'h75 == data1Frac_4 ? $signed(8'sh22) : $signed(_GEN_648); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_650 = 7'h76 == data1Frac_4 ? $signed(8'sh22) : $signed(_GEN_649); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_651 = 7'h77 == data1Frac_4 ? $signed(8'sh22) : $signed(_GEN_650); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_652 = 7'h78 == data1Frac_4 ? $signed(8'sh21) : $signed(_GEN_651); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_653 = 7'h79 == data1Frac_4 ? $signed(8'sh21) : $signed(_GEN_652); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_654 = 7'h7a == data1Frac_4 ? $signed(8'sh21) : $signed(_GEN_653); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_655 = 7'h7b == data1Frac_4 ? $signed(8'sh21) : $signed(_GEN_654); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_656 = 7'h7c == data1Frac_4 ? $signed(8'sh21) : $signed(_GEN_655); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_657 = 7'h7d == data1Frac_4 ? $signed(8'sh21) : $signed(_GEN_656); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_658 = 7'h7e == data1Frac_4 ? $signed(8'sh20) : $signed(_GEN_657); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_659 = 7'h7f == data1Frac_4 ? $signed(8'sh20) : $signed(_GEN_658); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_14 = $signed(_GEN_659) >>> data1Int_4; // @[exponent.scala 46:85]
  reg [7:0] data2_4; // @[Reg.scala 16:16]
  wire [7:0] _GEN_663 = 7'h2 == data1Frac_5 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_664 = 7'h3 == data1Frac_5 ? $signed(8'sh3f) : $signed(_GEN_663); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_665 = 7'h4 == data1Frac_5 ? $signed(8'sh3f) : $signed(_GEN_664); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_666 = 7'h5 == data1Frac_5 ? $signed(8'sh3e) : $signed(_GEN_665); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_667 = 7'h6 == data1Frac_5 ? $signed(8'sh3e) : $signed(_GEN_666); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_668 = 7'h7 == data1Frac_5 ? $signed(8'sh3e) : $signed(_GEN_667); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_669 = 7'h8 == data1Frac_5 ? $signed(8'sh3d) : $signed(_GEN_668); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_670 = 7'h9 == data1Frac_5 ? $signed(8'sh3d) : $signed(_GEN_669); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_671 = 7'ha == data1Frac_5 ? $signed(8'sh3d) : $signed(_GEN_670); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_672 = 7'hb == data1Frac_5 ? $signed(8'sh3c) : $signed(_GEN_671); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_673 = 7'hc == data1Frac_5 ? $signed(8'sh3c) : $signed(_GEN_672); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_674 = 7'hd == data1Frac_5 ? $signed(8'sh3c) : $signed(_GEN_673); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_675 = 7'he == data1Frac_5 ? $signed(8'sh3b) : $signed(_GEN_674); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_676 = 7'hf == data1Frac_5 ? $signed(8'sh3b) : $signed(_GEN_675); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_677 = 7'h10 == data1Frac_5 ? $signed(8'sh3b) : $signed(_GEN_676); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_678 = 7'h11 == data1Frac_5 ? $signed(8'sh3a) : $signed(_GEN_677); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_679 = 7'h12 == data1Frac_5 ? $signed(8'sh3a) : $signed(_GEN_678); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_680 = 7'h13 == data1Frac_5 ? $signed(8'sh3a) : $signed(_GEN_679); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_681 = 7'h14 == data1Frac_5 ? $signed(8'sh39) : $signed(_GEN_680); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_682 = 7'h15 == data1Frac_5 ? $signed(8'sh39) : $signed(_GEN_681); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_683 = 7'h16 == data1Frac_5 ? $signed(8'sh39) : $signed(_GEN_682); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_684 = 7'h17 == data1Frac_5 ? $signed(8'sh39) : $signed(_GEN_683); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_685 = 7'h18 == data1Frac_5 ? $signed(8'sh38) : $signed(_GEN_684); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_686 = 7'h19 == data1Frac_5 ? $signed(8'sh38) : $signed(_GEN_685); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_687 = 7'h1a == data1Frac_5 ? $signed(8'sh38) : $signed(_GEN_686); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_688 = 7'h1b == data1Frac_5 ? $signed(8'sh37) : $signed(_GEN_687); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_689 = 7'h1c == data1Frac_5 ? $signed(8'sh37) : $signed(_GEN_688); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_690 = 7'h1d == data1Frac_5 ? $signed(8'sh37) : $signed(_GEN_689); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_691 = 7'h1e == data1Frac_5 ? $signed(8'sh36) : $signed(_GEN_690); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_692 = 7'h1f == data1Frac_5 ? $signed(8'sh36) : $signed(_GEN_691); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_693 = 7'h20 == data1Frac_5 ? $signed(8'sh36) : $signed(_GEN_692); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_694 = 7'h21 == data1Frac_5 ? $signed(8'sh36) : $signed(_GEN_693); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_695 = 7'h22 == data1Frac_5 ? $signed(8'sh35) : $signed(_GEN_694); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_696 = 7'h23 == data1Frac_5 ? $signed(8'sh35) : $signed(_GEN_695); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_697 = 7'h24 == data1Frac_5 ? $signed(8'sh35) : $signed(_GEN_696); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_698 = 7'h25 == data1Frac_5 ? $signed(8'sh34) : $signed(_GEN_697); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_699 = 7'h26 == data1Frac_5 ? $signed(8'sh34) : $signed(_GEN_698); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_700 = 7'h27 == data1Frac_5 ? $signed(8'sh34) : $signed(_GEN_699); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_701 = 7'h28 == data1Frac_5 ? $signed(8'sh34) : $signed(_GEN_700); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_702 = 7'h29 == data1Frac_5 ? $signed(8'sh33) : $signed(_GEN_701); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_703 = 7'h2a == data1Frac_5 ? $signed(8'sh33) : $signed(_GEN_702); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_704 = 7'h2b == data1Frac_5 ? $signed(8'sh33) : $signed(_GEN_703); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_705 = 7'h2c == data1Frac_5 ? $signed(8'sh32) : $signed(_GEN_704); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_706 = 7'h2d == data1Frac_5 ? $signed(8'sh32) : $signed(_GEN_705); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_707 = 7'h2e == data1Frac_5 ? $signed(8'sh32) : $signed(_GEN_706); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_708 = 7'h2f == data1Frac_5 ? $signed(8'sh32) : $signed(_GEN_707); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_709 = 7'h30 == data1Frac_5 ? $signed(8'sh31) : $signed(_GEN_708); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_710 = 7'h31 == data1Frac_5 ? $signed(8'sh31) : $signed(_GEN_709); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_711 = 7'h32 == data1Frac_5 ? $signed(8'sh31) : $signed(_GEN_710); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_712 = 7'h33 == data1Frac_5 ? $signed(8'sh31) : $signed(_GEN_711); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_713 = 7'h34 == data1Frac_5 ? $signed(8'sh30) : $signed(_GEN_712); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_714 = 7'h35 == data1Frac_5 ? $signed(8'sh30) : $signed(_GEN_713); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_715 = 7'h36 == data1Frac_5 ? $signed(8'sh30) : $signed(_GEN_714); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_716 = 7'h37 == data1Frac_5 ? $signed(8'sh30) : $signed(_GEN_715); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_717 = 7'h38 == data1Frac_5 ? $signed(8'sh2f) : $signed(_GEN_716); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_718 = 7'h39 == data1Frac_5 ? $signed(8'sh2f) : $signed(_GEN_717); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_719 = 7'h3a == data1Frac_5 ? $signed(8'sh2f) : $signed(_GEN_718); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_720 = 7'h3b == data1Frac_5 ? $signed(8'sh2e) : $signed(_GEN_719); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_721 = 7'h3c == data1Frac_5 ? $signed(8'sh2e) : $signed(_GEN_720); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_722 = 7'h3d == data1Frac_5 ? $signed(8'sh2e) : $signed(_GEN_721); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_723 = 7'h3e == data1Frac_5 ? $signed(8'sh2e) : $signed(_GEN_722); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_724 = 7'h3f == data1Frac_5 ? $signed(8'sh2e) : $signed(_GEN_723); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_725 = 7'h40 == data1Frac_5 ? $signed(8'sh2d) : $signed(_GEN_724); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_726 = 7'h41 == data1Frac_5 ? $signed(8'sh2d) : $signed(_GEN_725); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_727 = 7'h42 == data1Frac_5 ? $signed(8'sh2d) : $signed(_GEN_726); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_728 = 7'h43 == data1Frac_5 ? $signed(8'sh2d) : $signed(_GEN_727); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_729 = 7'h44 == data1Frac_5 ? $signed(8'sh2c) : $signed(_GEN_728); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_730 = 7'h45 == data1Frac_5 ? $signed(8'sh2c) : $signed(_GEN_729); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_731 = 7'h46 == data1Frac_5 ? $signed(8'sh2c) : $signed(_GEN_730); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_732 = 7'h47 == data1Frac_5 ? $signed(8'sh2c) : $signed(_GEN_731); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_733 = 7'h48 == data1Frac_5 ? $signed(8'sh2b) : $signed(_GEN_732); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_734 = 7'h49 == data1Frac_5 ? $signed(8'sh2b) : $signed(_GEN_733); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_735 = 7'h4a == data1Frac_5 ? $signed(8'sh2b) : $signed(_GEN_734); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_736 = 7'h4b == data1Frac_5 ? $signed(8'sh2b) : $signed(_GEN_735); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_737 = 7'h4c == data1Frac_5 ? $signed(8'sh2a) : $signed(_GEN_736); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_738 = 7'h4d == data1Frac_5 ? $signed(8'sh2a) : $signed(_GEN_737); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_739 = 7'h4e == data1Frac_5 ? $signed(8'sh2a) : $signed(_GEN_738); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_740 = 7'h4f == data1Frac_5 ? $signed(8'sh2a) : $signed(_GEN_739); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_741 = 7'h50 == data1Frac_5 ? $signed(8'sh29) : $signed(_GEN_740); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_742 = 7'h51 == data1Frac_5 ? $signed(8'sh29) : $signed(_GEN_741); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_743 = 7'h52 == data1Frac_5 ? $signed(8'sh29) : $signed(_GEN_742); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_744 = 7'h53 == data1Frac_5 ? $signed(8'sh29) : $signed(_GEN_743); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_745 = 7'h54 == data1Frac_5 ? $signed(8'sh29) : $signed(_GEN_744); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_746 = 7'h55 == data1Frac_5 ? $signed(8'sh28) : $signed(_GEN_745); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_747 = 7'h56 == data1Frac_5 ? $signed(8'sh28) : $signed(_GEN_746); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_748 = 7'h57 == data1Frac_5 ? $signed(8'sh28) : $signed(_GEN_747); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_749 = 7'h58 == data1Frac_5 ? $signed(8'sh28) : $signed(_GEN_748); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_750 = 7'h59 == data1Frac_5 ? $signed(8'sh28) : $signed(_GEN_749); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_751 = 7'h5a == data1Frac_5 ? $signed(8'sh27) : $signed(_GEN_750); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_752 = 7'h5b == data1Frac_5 ? $signed(8'sh27) : $signed(_GEN_751); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_753 = 7'h5c == data1Frac_5 ? $signed(8'sh27) : $signed(_GEN_752); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_754 = 7'h5d == data1Frac_5 ? $signed(8'sh27) : $signed(_GEN_753); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_755 = 7'h5e == data1Frac_5 ? $signed(8'sh26) : $signed(_GEN_754); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_756 = 7'h5f == data1Frac_5 ? $signed(8'sh26) : $signed(_GEN_755); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_757 = 7'h60 == data1Frac_5 ? $signed(8'sh26) : $signed(_GEN_756); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_758 = 7'h61 == data1Frac_5 ? $signed(8'sh26) : $signed(_GEN_757); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_759 = 7'h62 == data1Frac_5 ? $signed(8'sh26) : $signed(_GEN_758); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_760 = 7'h63 == data1Frac_5 ? $signed(8'sh25) : $signed(_GEN_759); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_761 = 7'h64 == data1Frac_5 ? $signed(8'sh25) : $signed(_GEN_760); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_762 = 7'h65 == data1Frac_5 ? $signed(8'sh25) : $signed(_GEN_761); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_763 = 7'h66 == data1Frac_5 ? $signed(8'sh25) : $signed(_GEN_762); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_764 = 7'h67 == data1Frac_5 ? $signed(8'sh25) : $signed(_GEN_763); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_765 = 7'h68 == data1Frac_5 ? $signed(8'sh24) : $signed(_GEN_764); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_766 = 7'h69 == data1Frac_5 ? $signed(8'sh24) : $signed(_GEN_765); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_767 = 7'h6a == data1Frac_5 ? $signed(8'sh24) : $signed(_GEN_766); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_768 = 7'h6b == data1Frac_5 ? $signed(8'sh24) : $signed(_GEN_767); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_769 = 7'h6c == data1Frac_5 ? $signed(8'sh24) : $signed(_GEN_768); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_770 = 7'h6d == data1Frac_5 ? $signed(8'sh23) : $signed(_GEN_769); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_771 = 7'h6e == data1Frac_5 ? $signed(8'sh23) : $signed(_GEN_770); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_772 = 7'h6f == data1Frac_5 ? $signed(8'sh23) : $signed(_GEN_771); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_773 = 7'h70 == data1Frac_5 ? $signed(8'sh23) : $signed(_GEN_772); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_774 = 7'h71 == data1Frac_5 ? $signed(8'sh23) : $signed(_GEN_773); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_775 = 7'h72 == data1Frac_5 ? $signed(8'sh23) : $signed(_GEN_774); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_776 = 7'h73 == data1Frac_5 ? $signed(8'sh22) : $signed(_GEN_775); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_777 = 7'h74 == data1Frac_5 ? $signed(8'sh22) : $signed(_GEN_776); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_778 = 7'h75 == data1Frac_5 ? $signed(8'sh22) : $signed(_GEN_777); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_779 = 7'h76 == data1Frac_5 ? $signed(8'sh22) : $signed(_GEN_778); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_780 = 7'h77 == data1Frac_5 ? $signed(8'sh22) : $signed(_GEN_779); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_781 = 7'h78 == data1Frac_5 ? $signed(8'sh21) : $signed(_GEN_780); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_782 = 7'h79 == data1Frac_5 ? $signed(8'sh21) : $signed(_GEN_781); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_783 = 7'h7a == data1Frac_5 ? $signed(8'sh21) : $signed(_GEN_782); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_784 = 7'h7b == data1Frac_5 ? $signed(8'sh21) : $signed(_GEN_783); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_785 = 7'h7c == data1Frac_5 ? $signed(8'sh21) : $signed(_GEN_784); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_786 = 7'h7d == data1Frac_5 ? $signed(8'sh21) : $signed(_GEN_785); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_787 = 7'h7e == data1Frac_5 ? $signed(8'sh20) : $signed(_GEN_786); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_788 = 7'h7f == data1Frac_5 ? $signed(8'sh20) : $signed(_GEN_787); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_17 = $signed(_GEN_788) >>> data1Int_5; // @[exponent.scala 46:85]
  reg [7:0] data2_5; // @[Reg.scala 16:16]
  wire [7:0] _GEN_792 = 7'h2 == data1Frac_6 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_793 = 7'h3 == data1Frac_6 ? $signed(8'sh3f) : $signed(_GEN_792); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_794 = 7'h4 == data1Frac_6 ? $signed(8'sh3f) : $signed(_GEN_793); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_795 = 7'h5 == data1Frac_6 ? $signed(8'sh3e) : $signed(_GEN_794); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_796 = 7'h6 == data1Frac_6 ? $signed(8'sh3e) : $signed(_GEN_795); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_797 = 7'h7 == data1Frac_6 ? $signed(8'sh3e) : $signed(_GEN_796); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_798 = 7'h8 == data1Frac_6 ? $signed(8'sh3d) : $signed(_GEN_797); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_799 = 7'h9 == data1Frac_6 ? $signed(8'sh3d) : $signed(_GEN_798); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_800 = 7'ha == data1Frac_6 ? $signed(8'sh3d) : $signed(_GEN_799); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_801 = 7'hb == data1Frac_6 ? $signed(8'sh3c) : $signed(_GEN_800); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_802 = 7'hc == data1Frac_6 ? $signed(8'sh3c) : $signed(_GEN_801); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_803 = 7'hd == data1Frac_6 ? $signed(8'sh3c) : $signed(_GEN_802); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_804 = 7'he == data1Frac_6 ? $signed(8'sh3b) : $signed(_GEN_803); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_805 = 7'hf == data1Frac_6 ? $signed(8'sh3b) : $signed(_GEN_804); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_806 = 7'h10 == data1Frac_6 ? $signed(8'sh3b) : $signed(_GEN_805); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_807 = 7'h11 == data1Frac_6 ? $signed(8'sh3a) : $signed(_GEN_806); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_808 = 7'h12 == data1Frac_6 ? $signed(8'sh3a) : $signed(_GEN_807); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_809 = 7'h13 == data1Frac_6 ? $signed(8'sh3a) : $signed(_GEN_808); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_810 = 7'h14 == data1Frac_6 ? $signed(8'sh39) : $signed(_GEN_809); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_811 = 7'h15 == data1Frac_6 ? $signed(8'sh39) : $signed(_GEN_810); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_812 = 7'h16 == data1Frac_6 ? $signed(8'sh39) : $signed(_GEN_811); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_813 = 7'h17 == data1Frac_6 ? $signed(8'sh39) : $signed(_GEN_812); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_814 = 7'h18 == data1Frac_6 ? $signed(8'sh38) : $signed(_GEN_813); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_815 = 7'h19 == data1Frac_6 ? $signed(8'sh38) : $signed(_GEN_814); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_816 = 7'h1a == data1Frac_6 ? $signed(8'sh38) : $signed(_GEN_815); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_817 = 7'h1b == data1Frac_6 ? $signed(8'sh37) : $signed(_GEN_816); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_818 = 7'h1c == data1Frac_6 ? $signed(8'sh37) : $signed(_GEN_817); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_819 = 7'h1d == data1Frac_6 ? $signed(8'sh37) : $signed(_GEN_818); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_820 = 7'h1e == data1Frac_6 ? $signed(8'sh36) : $signed(_GEN_819); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_821 = 7'h1f == data1Frac_6 ? $signed(8'sh36) : $signed(_GEN_820); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_822 = 7'h20 == data1Frac_6 ? $signed(8'sh36) : $signed(_GEN_821); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_823 = 7'h21 == data1Frac_6 ? $signed(8'sh36) : $signed(_GEN_822); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_824 = 7'h22 == data1Frac_6 ? $signed(8'sh35) : $signed(_GEN_823); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_825 = 7'h23 == data1Frac_6 ? $signed(8'sh35) : $signed(_GEN_824); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_826 = 7'h24 == data1Frac_6 ? $signed(8'sh35) : $signed(_GEN_825); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_827 = 7'h25 == data1Frac_6 ? $signed(8'sh34) : $signed(_GEN_826); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_828 = 7'h26 == data1Frac_6 ? $signed(8'sh34) : $signed(_GEN_827); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_829 = 7'h27 == data1Frac_6 ? $signed(8'sh34) : $signed(_GEN_828); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_830 = 7'h28 == data1Frac_6 ? $signed(8'sh34) : $signed(_GEN_829); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_831 = 7'h29 == data1Frac_6 ? $signed(8'sh33) : $signed(_GEN_830); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_832 = 7'h2a == data1Frac_6 ? $signed(8'sh33) : $signed(_GEN_831); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_833 = 7'h2b == data1Frac_6 ? $signed(8'sh33) : $signed(_GEN_832); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_834 = 7'h2c == data1Frac_6 ? $signed(8'sh32) : $signed(_GEN_833); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_835 = 7'h2d == data1Frac_6 ? $signed(8'sh32) : $signed(_GEN_834); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_836 = 7'h2e == data1Frac_6 ? $signed(8'sh32) : $signed(_GEN_835); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_837 = 7'h2f == data1Frac_6 ? $signed(8'sh32) : $signed(_GEN_836); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_838 = 7'h30 == data1Frac_6 ? $signed(8'sh31) : $signed(_GEN_837); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_839 = 7'h31 == data1Frac_6 ? $signed(8'sh31) : $signed(_GEN_838); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_840 = 7'h32 == data1Frac_6 ? $signed(8'sh31) : $signed(_GEN_839); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_841 = 7'h33 == data1Frac_6 ? $signed(8'sh31) : $signed(_GEN_840); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_842 = 7'h34 == data1Frac_6 ? $signed(8'sh30) : $signed(_GEN_841); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_843 = 7'h35 == data1Frac_6 ? $signed(8'sh30) : $signed(_GEN_842); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_844 = 7'h36 == data1Frac_6 ? $signed(8'sh30) : $signed(_GEN_843); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_845 = 7'h37 == data1Frac_6 ? $signed(8'sh30) : $signed(_GEN_844); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_846 = 7'h38 == data1Frac_6 ? $signed(8'sh2f) : $signed(_GEN_845); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_847 = 7'h39 == data1Frac_6 ? $signed(8'sh2f) : $signed(_GEN_846); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_848 = 7'h3a == data1Frac_6 ? $signed(8'sh2f) : $signed(_GEN_847); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_849 = 7'h3b == data1Frac_6 ? $signed(8'sh2e) : $signed(_GEN_848); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_850 = 7'h3c == data1Frac_6 ? $signed(8'sh2e) : $signed(_GEN_849); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_851 = 7'h3d == data1Frac_6 ? $signed(8'sh2e) : $signed(_GEN_850); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_852 = 7'h3e == data1Frac_6 ? $signed(8'sh2e) : $signed(_GEN_851); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_853 = 7'h3f == data1Frac_6 ? $signed(8'sh2e) : $signed(_GEN_852); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_854 = 7'h40 == data1Frac_6 ? $signed(8'sh2d) : $signed(_GEN_853); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_855 = 7'h41 == data1Frac_6 ? $signed(8'sh2d) : $signed(_GEN_854); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_856 = 7'h42 == data1Frac_6 ? $signed(8'sh2d) : $signed(_GEN_855); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_857 = 7'h43 == data1Frac_6 ? $signed(8'sh2d) : $signed(_GEN_856); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_858 = 7'h44 == data1Frac_6 ? $signed(8'sh2c) : $signed(_GEN_857); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_859 = 7'h45 == data1Frac_6 ? $signed(8'sh2c) : $signed(_GEN_858); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_860 = 7'h46 == data1Frac_6 ? $signed(8'sh2c) : $signed(_GEN_859); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_861 = 7'h47 == data1Frac_6 ? $signed(8'sh2c) : $signed(_GEN_860); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_862 = 7'h48 == data1Frac_6 ? $signed(8'sh2b) : $signed(_GEN_861); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_863 = 7'h49 == data1Frac_6 ? $signed(8'sh2b) : $signed(_GEN_862); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_864 = 7'h4a == data1Frac_6 ? $signed(8'sh2b) : $signed(_GEN_863); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_865 = 7'h4b == data1Frac_6 ? $signed(8'sh2b) : $signed(_GEN_864); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_866 = 7'h4c == data1Frac_6 ? $signed(8'sh2a) : $signed(_GEN_865); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_867 = 7'h4d == data1Frac_6 ? $signed(8'sh2a) : $signed(_GEN_866); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_868 = 7'h4e == data1Frac_6 ? $signed(8'sh2a) : $signed(_GEN_867); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_869 = 7'h4f == data1Frac_6 ? $signed(8'sh2a) : $signed(_GEN_868); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_870 = 7'h50 == data1Frac_6 ? $signed(8'sh29) : $signed(_GEN_869); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_871 = 7'h51 == data1Frac_6 ? $signed(8'sh29) : $signed(_GEN_870); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_872 = 7'h52 == data1Frac_6 ? $signed(8'sh29) : $signed(_GEN_871); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_873 = 7'h53 == data1Frac_6 ? $signed(8'sh29) : $signed(_GEN_872); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_874 = 7'h54 == data1Frac_6 ? $signed(8'sh29) : $signed(_GEN_873); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_875 = 7'h55 == data1Frac_6 ? $signed(8'sh28) : $signed(_GEN_874); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_876 = 7'h56 == data1Frac_6 ? $signed(8'sh28) : $signed(_GEN_875); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_877 = 7'h57 == data1Frac_6 ? $signed(8'sh28) : $signed(_GEN_876); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_878 = 7'h58 == data1Frac_6 ? $signed(8'sh28) : $signed(_GEN_877); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_879 = 7'h59 == data1Frac_6 ? $signed(8'sh28) : $signed(_GEN_878); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_880 = 7'h5a == data1Frac_6 ? $signed(8'sh27) : $signed(_GEN_879); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_881 = 7'h5b == data1Frac_6 ? $signed(8'sh27) : $signed(_GEN_880); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_882 = 7'h5c == data1Frac_6 ? $signed(8'sh27) : $signed(_GEN_881); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_883 = 7'h5d == data1Frac_6 ? $signed(8'sh27) : $signed(_GEN_882); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_884 = 7'h5e == data1Frac_6 ? $signed(8'sh26) : $signed(_GEN_883); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_885 = 7'h5f == data1Frac_6 ? $signed(8'sh26) : $signed(_GEN_884); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_886 = 7'h60 == data1Frac_6 ? $signed(8'sh26) : $signed(_GEN_885); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_887 = 7'h61 == data1Frac_6 ? $signed(8'sh26) : $signed(_GEN_886); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_888 = 7'h62 == data1Frac_6 ? $signed(8'sh26) : $signed(_GEN_887); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_889 = 7'h63 == data1Frac_6 ? $signed(8'sh25) : $signed(_GEN_888); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_890 = 7'h64 == data1Frac_6 ? $signed(8'sh25) : $signed(_GEN_889); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_891 = 7'h65 == data1Frac_6 ? $signed(8'sh25) : $signed(_GEN_890); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_892 = 7'h66 == data1Frac_6 ? $signed(8'sh25) : $signed(_GEN_891); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_893 = 7'h67 == data1Frac_6 ? $signed(8'sh25) : $signed(_GEN_892); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_894 = 7'h68 == data1Frac_6 ? $signed(8'sh24) : $signed(_GEN_893); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_895 = 7'h69 == data1Frac_6 ? $signed(8'sh24) : $signed(_GEN_894); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_896 = 7'h6a == data1Frac_6 ? $signed(8'sh24) : $signed(_GEN_895); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_897 = 7'h6b == data1Frac_6 ? $signed(8'sh24) : $signed(_GEN_896); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_898 = 7'h6c == data1Frac_6 ? $signed(8'sh24) : $signed(_GEN_897); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_899 = 7'h6d == data1Frac_6 ? $signed(8'sh23) : $signed(_GEN_898); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_900 = 7'h6e == data1Frac_6 ? $signed(8'sh23) : $signed(_GEN_899); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_901 = 7'h6f == data1Frac_6 ? $signed(8'sh23) : $signed(_GEN_900); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_902 = 7'h70 == data1Frac_6 ? $signed(8'sh23) : $signed(_GEN_901); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_903 = 7'h71 == data1Frac_6 ? $signed(8'sh23) : $signed(_GEN_902); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_904 = 7'h72 == data1Frac_6 ? $signed(8'sh23) : $signed(_GEN_903); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_905 = 7'h73 == data1Frac_6 ? $signed(8'sh22) : $signed(_GEN_904); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_906 = 7'h74 == data1Frac_6 ? $signed(8'sh22) : $signed(_GEN_905); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_907 = 7'h75 == data1Frac_6 ? $signed(8'sh22) : $signed(_GEN_906); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_908 = 7'h76 == data1Frac_6 ? $signed(8'sh22) : $signed(_GEN_907); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_909 = 7'h77 == data1Frac_6 ? $signed(8'sh22) : $signed(_GEN_908); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_910 = 7'h78 == data1Frac_6 ? $signed(8'sh21) : $signed(_GEN_909); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_911 = 7'h79 == data1Frac_6 ? $signed(8'sh21) : $signed(_GEN_910); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_912 = 7'h7a == data1Frac_6 ? $signed(8'sh21) : $signed(_GEN_911); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_913 = 7'h7b == data1Frac_6 ? $signed(8'sh21) : $signed(_GEN_912); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_914 = 7'h7c == data1Frac_6 ? $signed(8'sh21) : $signed(_GEN_913); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_915 = 7'h7d == data1Frac_6 ? $signed(8'sh21) : $signed(_GEN_914); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_916 = 7'h7e == data1Frac_6 ? $signed(8'sh20) : $signed(_GEN_915); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_917 = 7'h7f == data1Frac_6 ? $signed(8'sh20) : $signed(_GEN_916); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_20 = $signed(_GEN_917) >>> data1Int_6; // @[exponent.scala 46:85]
  reg [7:0] data2_6; // @[Reg.scala 16:16]
  wire [7:0] _GEN_921 = 7'h2 == data1Frac_7 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_922 = 7'h3 == data1Frac_7 ? $signed(8'sh3f) : $signed(_GEN_921); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_923 = 7'h4 == data1Frac_7 ? $signed(8'sh3f) : $signed(_GEN_922); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_924 = 7'h5 == data1Frac_7 ? $signed(8'sh3e) : $signed(_GEN_923); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_925 = 7'h6 == data1Frac_7 ? $signed(8'sh3e) : $signed(_GEN_924); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_926 = 7'h7 == data1Frac_7 ? $signed(8'sh3e) : $signed(_GEN_925); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_927 = 7'h8 == data1Frac_7 ? $signed(8'sh3d) : $signed(_GEN_926); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_928 = 7'h9 == data1Frac_7 ? $signed(8'sh3d) : $signed(_GEN_927); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_929 = 7'ha == data1Frac_7 ? $signed(8'sh3d) : $signed(_GEN_928); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_930 = 7'hb == data1Frac_7 ? $signed(8'sh3c) : $signed(_GEN_929); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_931 = 7'hc == data1Frac_7 ? $signed(8'sh3c) : $signed(_GEN_930); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_932 = 7'hd == data1Frac_7 ? $signed(8'sh3c) : $signed(_GEN_931); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_933 = 7'he == data1Frac_7 ? $signed(8'sh3b) : $signed(_GEN_932); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_934 = 7'hf == data1Frac_7 ? $signed(8'sh3b) : $signed(_GEN_933); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_935 = 7'h10 == data1Frac_7 ? $signed(8'sh3b) : $signed(_GEN_934); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_936 = 7'h11 == data1Frac_7 ? $signed(8'sh3a) : $signed(_GEN_935); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_937 = 7'h12 == data1Frac_7 ? $signed(8'sh3a) : $signed(_GEN_936); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_938 = 7'h13 == data1Frac_7 ? $signed(8'sh3a) : $signed(_GEN_937); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_939 = 7'h14 == data1Frac_7 ? $signed(8'sh39) : $signed(_GEN_938); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_940 = 7'h15 == data1Frac_7 ? $signed(8'sh39) : $signed(_GEN_939); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_941 = 7'h16 == data1Frac_7 ? $signed(8'sh39) : $signed(_GEN_940); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_942 = 7'h17 == data1Frac_7 ? $signed(8'sh39) : $signed(_GEN_941); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_943 = 7'h18 == data1Frac_7 ? $signed(8'sh38) : $signed(_GEN_942); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_944 = 7'h19 == data1Frac_7 ? $signed(8'sh38) : $signed(_GEN_943); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_945 = 7'h1a == data1Frac_7 ? $signed(8'sh38) : $signed(_GEN_944); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_946 = 7'h1b == data1Frac_7 ? $signed(8'sh37) : $signed(_GEN_945); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_947 = 7'h1c == data1Frac_7 ? $signed(8'sh37) : $signed(_GEN_946); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_948 = 7'h1d == data1Frac_7 ? $signed(8'sh37) : $signed(_GEN_947); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_949 = 7'h1e == data1Frac_7 ? $signed(8'sh36) : $signed(_GEN_948); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_950 = 7'h1f == data1Frac_7 ? $signed(8'sh36) : $signed(_GEN_949); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_951 = 7'h20 == data1Frac_7 ? $signed(8'sh36) : $signed(_GEN_950); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_952 = 7'h21 == data1Frac_7 ? $signed(8'sh36) : $signed(_GEN_951); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_953 = 7'h22 == data1Frac_7 ? $signed(8'sh35) : $signed(_GEN_952); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_954 = 7'h23 == data1Frac_7 ? $signed(8'sh35) : $signed(_GEN_953); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_955 = 7'h24 == data1Frac_7 ? $signed(8'sh35) : $signed(_GEN_954); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_956 = 7'h25 == data1Frac_7 ? $signed(8'sh34) : $signed(_GEN_955); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_957 = 7'h26 == data1Frac_7 ? $signed(8'sh34) : $signed(_GEN_956); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_958 = 7'h27 == data1Frac_7 ? $signed(8'sh34) : $signed(_GEN_957); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_959 = 7'h28 == data1Frac_7 ? $signed(8'sh34) : $signed(_GEN_958); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_960 = 7'h29 == data1Frac_7 ? $signed(8'sh33) : $signed(_GEN_959); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_961 = 7'h2a == data1Frac_7 ? $signed(8'sh33) : $signed(_GEN_960); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_962 = 7'h2b == data1Frac_7 ? $signed(8'sh33) : $signed(_GEN_961); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_963 = 7'h2c == data1Frac_7 ? $signed(8'sh32) : $signed(_GEN_962); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_964 = 7'h2d == data1Frac_7 ? $signed(8'sh32) : $signed(_GEN_963); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_965 = 7'h2e == data1Frac_7 ? $signed(8'sh32) : $signed(_GEN_964); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_966 = 7'h2f == data1Frac_7 ? $signed(8'sh32) : $signed(_GEN_965); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_967 = 7'h30 == data1Frac_7 ? $signed(8'sh31) : $signed(_GEN_966); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_968 = 7'h31 == data1Frac_7 ? $signed(8'sh31) : $signed(_GEN_967); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_969 = 7'h32 == data1Frac_7 ? $signed(8'sh31) : $signed(_GEN_968); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_970 = 7'h33 == data1Frac_7 ? $signed(8'sh31) : $signed(_GEN_969); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_971 = 7'h34 == data1Frac_7 ? $signed(8'sh30) : $signed(_GEN_970); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_972 = 7'h35 == data1Frac_7 ? $signed(8'sh30) : $signed(_GEN_971); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_973 = 7'h36 == data1Frac_7 ? $signed(8'sh30) : $signed(_GEN_972); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_974 = 7'h37 == data1Frac_7 ? $signed(8'sh30) : $signed(_GEN_973); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_975 = 7'h38 == data1Frac_7 ? $signed(8'sh2f) : $signed(_GEN_974); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_976 = 7'h39 == data1Frac_7 ? $signed(8'sh2f) : $signed(_GEN_975); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_977 = 7'h3a == data1Frac_7 ? $signed(8'sh2f) : $signed(_GEN_976); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_978 = 7'h3b == data1Frac_7 ? $signed(8'sh2e) : $signed(_GEN_977); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_979 = 7'h3c == data1Frac_7 ? $signed(8'sh2e) : $signed(_GEN_978); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_980 = 7'h3d == data1Frac_7 ? $signed(8'sh2e) : $signed(_GEN_979); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_981 = 7'h3e == data1Frac_7 ? $signed(8'sh2e) : $signed(_GEN_980); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_982 = 7'h3f == data1Frac_7 ? $signed(8'sh2e) : $signed(_GEN_981); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_983 = 7'h40 == data1Frac_7 ? $signed(8'sh2d) : $signed(_GEN_982); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_984 = 7'h41 == data1Frac_7 ? $signed(8'sh2d) : $signed(_GEN_983); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_985 = 7'h42 == data1Frac_7 ? $signed(8'sh2d) : $signed(_GEN_984); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_986 = 7'h43 == data1Frac_7 ? $signed(8'sh2d) : $signed(_GEN_985); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_987 = 7'h44 == data1Frac_7 ? $signed(8'sh2c) : $signed(_GEN_986); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_988 = 7'h45 == data1Frac_7 ? $signed(8'sh2c) : $signed(_GEN_987); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_989 = 7'h46 == data1Frac_7 ? $signed(8'sh2c) : $signed(_GEN_988); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_990 = 7'h47 == data1Frac_7 ? $signed(8'sh2c) : $signed(_GEN_989); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_991 = 7'h48 == data1Frac_7 ? $signed(8'sh2b) : $signed(_GEN_990); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_992 = 7'h49 == data1Frac_7 ? $signed(8'sh2b) : $signed(_GEN_991); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_993 = 7'h4a == data1Frac_7 ? $signed(8'sh2b) : $signed(_GEN_992); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_994 = 7'h4b == data1Frac_7 ? $signed(8'sh2b) : $signed(_GEN_993); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_995 = 7'h4c == data1Frac_7 ? $signed(8'sh2a) : $signed(_GEN_994); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_996 = 7'h4d == data1Frac_7 ? $signed(8'sh2a) : $signed(_GEN_995); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_997 = 7'h4e == data1Frac_7 ? $signed(8'sh2a) : $signed(_GEN_996); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_998 = 7'h4f == data1Frac_7 ? $signed(8'sh2a) : $signed(_GEN_997); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_999 = 7'h50 == data1Frac_7 ? $signed(8'sh29) : $signed(_GEN_998); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1000 = 7'h51 == data1Frac_7 ? $signed(8'sh29) : $signed(_GEN_999); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1001 = 7'h52 == data1Frac_7 ? $signed(8'sh29) : $signed(_GEN_1000); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1002 = 7'h53 == data1Frac_7 ? $signed(8'sh29) : $signed(_GEN_1001); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1003 = 7'h54 == data1Frac_7 ? $signed(8'sh29) : $signed(_GEN_1002); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1004 = 7'h55 == data1Frac_7 ? $signed(8'sh28) : $signed(_GEN_1003); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1005 = 7'h56 == data1Frac_7 ? $signed(8'sh28) : $signed(_GEN_1004); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1006 = 7'h57 == data1Frac_7 ? $signed(8'sh28) : $signed(_GEN_1005); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1007 = 7'h58 == data1Frac_7 ? $signed(8'sh28) : $signed(_GEN_1006); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1008 = 7'h59 == data1Frac_7 ? $signed(8'sh28) : $signed(_GEN_1007); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1009 = 7'h5a == data1Frac_7 ? $signed(8'sh27) : $signed(_GEN_1008); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1010 = 7'h5b == data1Frac_7 ? $signed(8'sh27) : $signed(_GEN_1009); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1011 = 7'h5c == data1Frac_7 ? $signed(8'sh27) : $signed(_GEN_1010); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1012 = 7'h5d == data1Frac_7 ? $signed(8'sh27) : $signed(_GEN_1011); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1013 = 7'h5e == data1Frac_7 ? $signed(8'sh26) : $signed(_GEN_1012); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1014 = 7'h5f == data1Frac_7 ? $signed(8'sh26) : $signed(_GEN_1013); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1015 = 7'h60 == data1Frac_7 ? $signed(8'sh26) : $signed(_GEN_1014); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1016 = 7'h61 == data1Frac_7 ? $signed(8'sh26) : $signed(_GEN_1015); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1017 = 7'h62 == data1Frac_7 ? $signed(8'sh26) : $signed(_GEN_1016); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1018 = 7'h63 == data1Frac_7 ? $signed(8'sh25) : $signed(_GEN_1017); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1019 = 7'h64 == data1Frac_7 ? $signed(8'sh25) : $signed(_GEN_1018); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1020 = 7'h65 == data1Frac_7 ? $signed(8'sh25) : $signed(_GEN_1019); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1021 = 7'h66 == data1Frac_7 ? $signed(8'sh25) : $signed(_GEN_1020); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1022 = 7'h67 == data1Frac_7 ? $signed(8'sh25) : $signed(_GEN_1021); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1023 = 7'h68 == data1Frac_7 ? $signed(8'sh24) : $signed(_GEN_1022); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1024 = 7'h69 == data1Frac_7 ? $signed(8'sh24) : $signed(_GEN_1023); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1025 = 7'h6a == data1Frac_7 ? $signed(8'sh24) : $signed(_GEN_1024); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1026 = 7'h6b == data1Frac_7 ? $signed(8'sh24) : $signed(_GEN_1025); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1027 = 7'h6c == data1Frac_7 ? $signed(8'sh24) : $signed(_GEN_1026); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1028 = 7'h6d == data1Frac_7 ? $signed(8'sh23) : $signed(_GEN_1027); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1029 = 7'h6e == data1Frac_7 ? $signed(8'sh23) : $signed(_GEN_1028); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1030 = 7'h6f == data1Frac_7 ? $signed(8'sh23) : $signed(_GEN_1029); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1031 = 7'h70 == data1Frac_7 ? $signed(8'sh23) : $signed(_GEN_1030); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1032 = 7'h71 == data1Frac_7 ? $signed(8'sh23) : $signed(_GEN_1031); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1033 = 7'h72 == data1Frac_7 ? $signed(8'sh23) : $signed(_GEN_1032); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1034 = 7'h73 == data1Frac_7 ? $signed(8'sh22) : $signed(_GEN_1033); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1035 = 7'h74 == data1Frac_7 ? $signed(8'sh22) : $signed(_GEN_1034); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1036 = 7'h75 == data1Frac_7 ? $signed(8'sh22) : $signed(_GEN_1035); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1037 = 7'h76 == data1Frac_7 ? $signed(8'sh22) : $signed(_GEN_1036); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1038 = 7'h77 == data1Frac_7 ? $signed(8'sh22) : $signed(_GEN_1037); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1039 = 7'h78 == data1Frac_7 ? $signed(8'sh21) : $signed(_GEN_1038); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1040 = 7'h79 == data1Frac_7 ? $signed(8'sh21) : $signed(_GEN_1039); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1041 = 7'h7a == data1Frac_7 ? $signed(8'sh21) : $signed(_GEN_1040); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1042 = 7'h7b == data1Frac_7 ? $signed(8'sh21) : $signed(_GEN_1041); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1043 = 7'h7c == data1Frac_7 ? $signed(8'sh21) : $signed(_GEN_1042); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1044 = 7'h7d == data1Frac_7 ? $signed(8'sh21) : $signed(_GEN_1043); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1045 = 7'h7e == data1Frac_7 ? $signed(8'sh20) : $signed(_GEN_1044); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1046 = 7'h7f == data1Frac_7 ? $signed(8'sh20) : $signed(_GEN_1045); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_23 = $signed(_GEN_1046) >>> data1Int_7; // @[exponent.scala 46:85]
  reg [7:0] data2_7; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1050 = 7'h2 == data1Frac_8 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1051 = 7'h3 == data1Frac_8 ? $signed(8'sh3f) : $signed(_GEN_1050); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1052 = 7'h4 == data1Frac_8 ? $signed(8'sh3f) : $signed(_GEN_1051); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1053 = 7'h5 == data1Frac_8 ? $signed(8'sh3e) : $signed(_GEN_1052); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1054 = 7'h6 == data1Frac_8 ? $signed(8'sh3e) : $signed(_GEN_1053); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1055 = 7'h7 == data1Frac_8 ? $signed(8'sh3e) : $signed(_GEN_1054); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1056 = 7'h8 == data1Frac_8 ? $signed(8'sh3d) : $signed(_GEN_1055); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1057 = 7'h9 == data1Frac_8 ? $signed(8'sh3d) : $signed(_GEN_1056); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1058 = 7'ha == data1Frac_8 ? $signed(8'sh3d) : $signed(_GEN_1057); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1059 = 7'hb == data1Frac_8 ? $signed(8'sh3c) : $signed(_GEN_1058); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1060 = 7'hc == data1Frac_8 ? $signed(8'sh3c) : $signed(_GEN_1059); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1061 = 7'hd == data1Frac_8 ? $signed(8'sh3c) : $signed(_GEN_1060); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1062 = 7'he == data1Frac_8 ? $signed(8'sh3b) : $signed(_GEN_1061); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1063 = 7'hf == data1Frac_8 ? $signed(8'sh3b) : $signed(_GEN_1062); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1064 = 7'h10 == data1Frac_8 ? $signed(8'sh3b) : $signed(_GEN_1063); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1065 = 7'h11 == data1Frac_8 ? $signed(8'sh3a) : $signed(_GEN_1064); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1066 = 7'h12 == data1Frac_8 ? $signed(8'sh3a) : $signed(_GEN_1065); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1067 = 7'h13 == data1Frac_8 ? $signed(8'sh3a) : $signed(_GEN_1066); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1068 = 7'h14 == data1Frac_8 ? $signed(8'sh39) : $signed(_GEN_1067); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1069 = 7'h15 == data1Frac_8 ? $signed(8'sh39) : $signed(_GEN_1068); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1070 = 7'h16 == data1Frac_8 ? $signed(8'sh39) : $signed(_GEN_1069); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1071 = 7'h17 == data1Frac_8 ? $signed(8'sh39) : $signed(_GEN_1070); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1072 = 7'h18 == data1Frac_8 ? $signed(8'sh38) : $signed(_GEN_1071); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1073 = 7'h19 == data1Frac_8 ? $signed(8'sh38) : $signed(_GEN_1072); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1074 = 7'h1a == data1Frac_8 ? $signed(8'sh38) : $signed(_GEN_1073); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1075 = 7'h1b == data1Frac_8 ? $signed(8'sh37) : $signed(_GEN_1074); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1076 = 7'h1c == data1Frac_8 ? $signed(8'sh37) : $signed(_GEN_1075); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1077 = 7'h1d == data1Frac_8 ? $signed(8'sh37) : $signed(_GEN_1076); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1078 = 7'h1e == data1Frac_8 ? $signed(8'sh36) : $signed(_GEN_1077); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1079 = 7'h1f == data1Frac_8 ? $signed(8'sh36) : $signed(_GEN_1078); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1080 = 7'h20 == data1Frac_8 ? $signed(8'sh36) : $signed(_GEN_1079); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1081 = 7'h21 == data1Frac_8 ? $signed(8'sh36) : $signed(_GEN_1080); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1082 = 7'h22 == data1Frac_8 ? $signed(8'sh35) : $signed(_GEN_1081); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1083 = 7'h23 == data1Frac_8 ? $signed(8'sh35) : $signed(_GEN_1082); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1084 = 7'h24 == data1Frac_8 ? $signed(8'sh35) : $signed(_GEN_1083); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1085 = 7'h25 == data1Frac_8 ? $signed(8'sh34) : $signed(_GEN_1084); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1086 = 7'h26 == data1Frac_8 ? $signed(8'sh34) : $signed(_GEN_1085); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1087 = 7'h27 == data1Frac_8 ? $signed(8'sh34) : $signed(_GEN_1086); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1088 = 7'h28 == data1Frac_8 ? $signed(8'sh34) : $signed(_GEN_1087); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1089 = 7'h29 == data1Frac_8 ? $signed(8'sh33) : $signed(_GEN_1088); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1090 = 7'h2a == data1Frac_8 ? $signed(8'sh33) : $signed(_GEN_1089); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1091 = 7'h2b == data1Frac_8 ? $signed(8'sh33) : $signed(_GEN_1090); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1092 = 7'h2c == data1Frac_8 ? $signed(8'sh32) : $signed(_GEN_1091); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1093 = 7'h2d == data1Frac_8 ? $signed(8'sh32) : $signed(_GEN_1092); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1094 = 7'h2e == data1Frac_8 ? $signed(8'sh32) : $signed(_GEN_1093); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1095 = 7'h2f == data1Frac_8 ? $signed(8'sh32) : $signed(_GEN_1094); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1096 = 7'h30 == data1Frac_8 ? $signed(8'sh31) : $signed(_GEN_1095); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1097 = 7'h31 == data1Frac_8 ? $signed(8'sh31) : $signed(_GEN_1096); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1098 = 7'h32 == data1Frac_8 ? $signed(8'sh31) : $signed(_GEN_1097); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1099 = 7'h33 == data1Frac_8 ? $signed(8'sh31) : $signed(_GEN_1098); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1100 = 7'h34 == data1Frac_8 ? $signed(8'sh30) : $signed(_GEN_1099); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1101 = 7'h35 == data1Frac_8 ? $signed(8'sh30) : $signed(_GEN_1100); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1102 = 7'h36 == data1Frac_8 ? $signed(8'sh30) : $signed(_GEN_1101); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1103 = 7'h37 == data1Frac_8 ? $signed(8'sh30) : $signed(_GEN_1102); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1104 = 7'h38 == data1Frac_8 ? $signed(8'sh2f) : $signed(_GEN_1103); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1105 = 7'h39 == data1Frac_8 ? $signed(8'sh2f) : $signed(_GEN_1104); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1106 = 7'h3a == data1Frac_8 ? $signed(8'sh2f) : $signed(_GEN_1105); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1107 = 7'h3b == data1Frac_8 ? $signed(8'sh2e) : $signed(_GEN_1106); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1108 = 7'h3c == data1Frac_8 ? $signed(8'sh2e) : $signed(_GEN_1107); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1109 = 7'h3d == data1Frac_8 ? $signed(8'sh2e) : $signed(_GEN_1108); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1110 = 7'h3e == data1Frac_8 ? $signed(8'sh2e) : $signed(_GEN_1109); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1111 = 7'h3f == data1Frac_8 ? $signed(8'sh2e) : $signed(_GEN_1110); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1112 = 7'h40 == data1Frac_8 ? $signed(8'sh2d) : $signed(_GEN_1111); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1113 = 7'h41 == data1Frac_8 ? $signed(8'sh2d) : $signed(_GEN_1112); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1114 = 7'h42 == data1Frac_8 ? $signed(8'sh2d) : $signed(_GEN_1113); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1115 = 7'h43 == data1Frac_8 ? $signed(8'sh2d) : $signed(_GEN_1114); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1116 = 7'h44 == data1Frac_8 ? $signed(8'sh2c) : $signed(_GEN_1115); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1117 = 7'h45 == data1Frac_8 ? $signed(8'sh2c) : $signed(_GEN_1116); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1118 = 7'h46 == data1Frac_8 ? $signed(8'sh2c) : $signed(_GEN_1117); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1119 = 7'h47 == data1Frac_8 ? $signed(8'sh2c) : $signed(_GEN_1118); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1120 = 7'h48 == data1Frac_8 ? $signed(8'sh2b) : $signed(_GEN_1119); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1121 = 7'h49 == data1Frac_8 ? $signed(8'sh2b) : $signed(_GEN_1120); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1122 = 7'h4a == data1Frac_8 ? $signed(8'sh2b) : $signed(_GEN_1121); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1123 = 7'h4b == data1Frac_8 ? $signed(8'sh2b) : $signed(_GEN_1122); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1124 = 7'h4c == data1Frac_8 ? $signed(8'sh2a) : $signed(_GEN_1123); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1125 = 7'h4d == data1Frac_8 ? $signed(8'sh2a) : $signed(_GEN_1124); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1126 = 7'h4e == data1Frac_8 ? $signed(8'sh2a) : $signed(_GEN_1125); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1127 = 7'h4f == data1Frac_8 ? $signed(8'sh2a) : $signed(_GEN_1126); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1128 = 7'h50 == data1Frac_8 ? $signed(8'sh29) : $signed(_GEN_1127); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1129 = 7'h51 == data1Frac_8 ? $signed(8'sh29) : $signed(_GEN_1128); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1130 = 7'h52 == data1Frac_8 ? $signed(8'sh29) : $signed(_GEN_1129); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1131 = 7'h53 == data1Frac_8 ? $signed(8'sh29) : $signed(_GEN_1130); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1132 = 7'h54 == data1Frac_8 ? $signed(8'sh29) : $signed(_GEN_1131); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1133 = 7'h55 == data1Frac_8 ? $signed(8'sh28) : $signed(_GEN_1132); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1134 = 7'h56 == data1Frac_8 ? $signed(8'sh28) : $signed(_GEN_1133); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1135 = 7'h57 == data1Frac_8 ? $signed(8'sh28) : $signed(_GEN_1134); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1136 = 7'h58 == data1Frac_8 ? $signed(8'sh28) : $signed(_GEN_1135); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1137 = 7'h59 == data1Frac_8 ? $signed(8'sh28) : $signed(_GEN_1136); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1138 = 7'h5a == data1Frac_8 ? $signed(8'sh27) : $signed(_GEN_1137); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1139 = 7'h5b == data1Frac_8 ? $signed(8'sh27) : $signed(_GEN_1138); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1140 = 7'h5c == data1Frac_8 ? $signed(8'sh27) : $signed(_GEN_1139); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1141 = 7'h5d == data1Frac_8 ? $signed(8'sh27) : $signed(_GEN_1140); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1142 = 7'h5e == data1Frac_8 ? $signed(8'sh26) : $signed(_GEN_1141); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1143 = 7'h5f == data1Frac_8 ? $signed(8'sh26) : $signed(_GEN_1142); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1144 = 7'h60 == data1Frac_8 ? $signed(8'sh26) : $signed(_GEN_1143); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1145 = 7'h61 == data1Frac_8 ? $signed(8'sh26) : $signed(_GEN_1144); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1146 = 7'h62 == data1Frac_8 ? $signed(8'sh26) : $signed(_GEN_1145); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1147 = 7'h63 == data1Frac_8 ? $signed(8'sh25) : $signed(_GEN_1146); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1148 = 7'h64 == data1Frac_8 ? $signed(8'sh25) : $signed(_GEN_1147); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1149 = 7'h65 == data1Frac_8 ? $signed(8'sh25) : $signed(_GEN_1148); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1150 = 7'h66 == data1Frac_8 ? $signed(8'sh25) : $signed(_GEN_1149); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1151 = 7'h67 == data1Frac_8 ? $signed(8'sh25) : $signed(_GEN_1150); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1152 = 7'h68 == data1Frac_8 ? $signed(8'sh24) : $signed(_GEN_1151); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1153 = 7'h69 == data1Frac_8 ? $signed(8'sh24) : $signed(_GEN_1152); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1154 = 7'h6a == data1Frac_8 ? $signed(8'sh24) : $signed(_GEN_1153); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1155 = 7'h6b == data1Frac_8 ? $signed(8'sh24) : $signed(_GEN_1154); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1156 = 7'h6c == data1Frac_8 ? $signed(8'sh24) : $signed(_GEN_1155); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1157 = 7'h6d == data1Frac_8 ? $signed(8'sh23) : $signed(_GEN_1156); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1158 = 7'h6e == data1Frac_8 ? $signed(8'sh23) : $signed(_GEN_1157); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1159 = 7'h6f == data1Frac_8 ? $signed(8'sh23) : $signed(_GEN_1158); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1160 = 7'h70 == data1Frac_8 ? $signed(8'sh23) : $signed(_GEN_1159); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1161 = 7'h71 == data1Frac_8 ? $signed(8'sh23) : $signed(_GEN_1160); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1162 = 7'h72 == data1Frac_8 ? $signed(8'sh23) : $signed(_GEN_1161); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1163 = 7'h73 == data1Frac_8 ? $signed(8'sh22) : $signed(_GEN_1162); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1164 = 7'h74 == data1Frac_8 ? $signed(8'sh22) : $signed(_GEN_1163); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1165 = 7'h75 == data1Frac_8 ? $signed(8'sh22) : $signed(_GEN_1164); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1166 = 7'h76 == data1Frac_8 ? $signed(8'sh22) : $signed(_GEN_1165); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1167 = 7'h77 == data1Frac_8 ? $signed(8'sh22) : $signed(_GEN_1166); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1168 = 7'h78 == data1Frac_8 ? $signed(8'sh21) : $signed(_GEN_1167); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1169 = 7'h79 == data1Frac_8 ? $signed(8'sh21) : $signed(_GEN_1168); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1170 = 7'h7a == data1Frac_8 ? $signed(8'sh21) : $signed(_GEN_1169); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1171 = 7'h7b == data1Frac_8 ? $signed(8'sh21) : $signed(_GEN_1170); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1172 = 7'h7c == data1Frac_8 ? $signed(8'sh21) : $signed(_GEN_1171); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1173 = 7'h7d == data1Frac_8 ? $signed(8'sh21) : $signed(_GEN_1172); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1174 = 7'h7e == data1Frac_8 ? $signed(8'sh20) : $signed(_GEN_1173); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1175 = 7'h7f == data1Frac_8 ? $signed(8'sh20) : $signed(_GEN_1174); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_26 = $signed(_GEN_1175) >>> data1Int_8; // @[exponent.scala 46:85]
  reg [7:0] data2_8; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1179 = 7'h2 == data1Frac_9 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1180 = 7'h3 == data1Frac_9 ? $signed(8'sh3f) : $signed(_GEN_1179); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1181 = 7'h4 == data1Frac_9 ? $signed(8'sh3f) : $signed(_GEN_1180); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1182 = 7'h5 == data1Frac_9 ? $signed(8'sh3e) : $signed(_GEN_1181); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1183 = 7'h6 == data1Frac_9 ? $signed(8'sh3e) : $signed(_GEN_1182); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1184 = 7'h7 == data1Frac_9 ? $signed(8'sh3e) : $signed(_GEN_1183); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1185 = 7'h8 == data1Frac_9 ? $signed(8'sh3d) : $signed(_GEN_1184); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1186 = 7'h9 == data1Frac_9 ? $signed(8'sh3d) : $signed(_GEN_1185); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1187 = 7'ha == data1Frac_9 ? $signed(8'sh3d) : $signed(_GEN_1186); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1188 = 7'hb == data1Frac_9 ? $signed(8'sh3c) : $signed(_GEN_1187); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1189 = 7'hc == data1Frac_9 ? $signed(8'sh3c) : $signed(_GEN_1188); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1190 = 7'hd == data1Frac_9 ? $signed(8'sh3c) : $signed(_GEN_1189); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1191 = 7'he == data1Frac_9 ? $signed(8'sh3b) : $signed(_GEN_1190); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1192 = 7'hf == data1Frac_9 ? $signed(8'sh3b) : $signed(_GEN_1191); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1193 = 7'h10 == data1Frac_9 ? $signed(8'sh3b) : $signed(_GEN_1192); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1194 = 7'h11 == data1Frac_9 ? $signed(8'sh3a) : $signed(_GEN_1193); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1195 = 7'h12 == data1Frac_9 ? $signed(8'sh3a) : $signed(_GEN_1194); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1196 = 7'h13 == data1Frac_9 ? $signed(8'sh3a) : $signed(_GEN_1195); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1197 = 7'h14 == data1Frac_9 ? $signed(8'sh39) : $signed(_GEN_1196); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1198 = 7'h15 == data1Frac_9 ? $signed(8'sh39) : $signed(_GEN_1197); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1199 = 7'h16 == data1Frac_9 ? $signed(8'sh39) : $signed(_GEN_1198); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1200 = 7'h17 == data1Frac_9 ? $signed(8'sh39) : $signed(_GEN_1199); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1201 = 7'h18 == data1Frac_9 ? $signed(8'sh38) : $signed(_GEN_1200); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1202 = 7'h19 == data1Frac_9 ? $signed(8'sh38) : $signed(_GEN_1201); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1203 = 7'h1a == data1Frac_9 ? $signed(8'sh38) : $signed(_GEN_1202); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1204 = 7'h1b == data1Frac_9 ? $signed(8'sh37) : $signed(_GEN_1203); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1205 = 7'h1c == data1Frac_9 ? $signed(8'sh37) : $signed(_GEN_1204); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1206 = 7'h1d == data1Frac_9 ? $signed(8'sh37) : $signed(_GEN_1205); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1207 = 7'h1e == data1Frac_9 ? $signed(8'sh36) : $signed(_GEN_1206); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1208 = 7'h1f == data1Frac_9 ? $signed(8'sh36) : $signed(_GEN_1207); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1209 = 7'h20 == data1Frac_9 ? $signed(8'sh36) : $signed(_GEN_1208); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1210 = 7'h21 == data1Frac_9 ? $signed(8'sh36) : $signed(_GEN_1209); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1211 = 7'h22 == data1Frac_9 ? $signed(8'sh35) : $signed(_GEN_1210); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1212 = 7'h23 == data1Frac_9 ? $signed(8'sh35) : $signed(_GEN_1211); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1213 = 7'h24 == data1Frac_9 ? $signed(8'sh35) : $signed(_GEN_1212); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1214 = 7'h25 == data1Frac_9 ? $signed(8'sh34) : $signed(_GEN_1213); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1215 = 7'h26 == data1Frac_9 ? $signed(8'sh34) : $signed(_GEN_1214); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1216 = 7'h27 == data1Frac_9 ? $signed(8'sh34) : $signed(_GEN_1215); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1217 = 7'h28 == data1Frac_9 ? $signed(8'sh34) : $signed(_GEN_1216); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1218 = 7'h29 == data1Frac_9 ? $signed(8'sh33) : $signed(_GEN_1217); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1219 = 7'h2a == data1Frac_9 ? $signed(8'sh33) : $signed(_GEN_1218); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1220 = 7'h2b == data1Frac_9 ? $signed(8'sh33) : $signed(_GEN_1219); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1221 = 7'h2c == data1Frac_9 ? $signed(8'sh32) : $signed(_GEN_1220); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1222 = 7'h2d == data1Frac_9 ? $signed(8'sh32) : $signed(_GEN_1221); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1223 = 7'h2e == data1Frac_9 ? $signed(8'sh32) : $signed(_GEN_1222); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1224 = 7'h2f == data1Frac_9 ? $signed(8'sh32) : $signed(_GEN_1223); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1225 = 7'h30 == data1Frac_9 ? $signed(8'sh31) : $signed(_GEN_1224); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1226 = 7'h31 == data1Frac_9 ? $signed(8'sh31) : $signed(_GEN_1225); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1227 = 7'h32 == data1Frac_9 ? $signed(8'sh31) : $signed(_GEN_1226); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1228 = 7'h33 == data1Frac_9 ? $signed(8'sh31) : $signed(_GEN_1227); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1229 = 7'h34 == data1Frac_9 ? $signed(8'sh30) : $signed(_GEN_1228); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1230 = 7'h35 == data1Frac_9 ? $signed(8'sh30) : $signed(_GEN_1229); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1231 = 7'h36 == data1Frac_9 ? $signed(8'sh30) : $signed(_GEN_1230); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1232 = 7'h37 == data1Frac_9 ? $signed(8'sh30) : $signed(_GEN_1231); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1233 = 7'h38 == data1Frac_9 ? $signed(8'sh2f) : $signed(_GEN_1232); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1234 = 7'h39 == data1Frac_9 ? $signed(8'sh2f) : $signed(_GEN_1233); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1235 = 7'h3a == data1Frac_9 ? $signed(8'sh2f) : $signed(_GEN_1234); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1236 = 7'h3b == data1Frac_9 ? $signed(8'sh2e) : $signed(_GEN_1235); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1237 = 7'h3c == data1Frac_9 ? $signed(8'sh2e) : $signed(_GEN_1236); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1238 = 7'h3d == data1Frac_9 ? $signed(8'sh2e) : $signed(_GEN_1237); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1239 = 7'h3e == data1Frac_9 ? $signed(8'sh2e) : $signed(_GEN_1238); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1240 = 7'h3f == data1Frac_9 ? $signed(8'sh2e) : $signed(_GEN_1239); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1241 = 7'h40 == data1Frac_9 ? $signed(8'sh2d) : $signed(_GEN_1240); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1242 = 7'h41 == data1Frac_9 ? $signed(8'sh2d) : $signed(_GEN_1241); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1243 = 7'h42 == data1Frac_9 ? $signed(8'sh2d) : $signed(_GEN_1242); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1244 = 7'h43 == data1Frac_9 ? $signed(8'sh2d) : $signed(_GEN_1243); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1245 = 7'h44 == data1Frac_9 ? $signed(8'sh2c) : $signed(_GEN_1244); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1246 = 7'h45 == data1Frac_9 ? $signed(8'sh2c) : $signed(_GEN_1245); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1247 = 7'h46 == data1Frac_9 ? $signed(8'sh2c) : $signed(_GEN_1246); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1248 = 7'h47 == data1Frac_9 ? $signed(8'sh2c) : $signed(_GEN_1247); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1249 = 7'h48 == data1Frac_9 ? $signed(8'sh2b) : $signed(_GEN_1248); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1250 = 7'h49 == data1Frac_9 ? $signed(8'sh2b) : $signed(_GEN_1249); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1251 = 7'h4a == data1Frac_9 ? $signed(8'sh2b) : $signed(_GEN_1250); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1252 = 7'h4b == data1Frac_9 ? $signed(8'sh2b) : $signed(_GEN_1251); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1253 = 7'h4c == data1Frac_9 ? $signed(8'sh2a) : $signed(_GEN_1252); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1254 = 7'h4d == data1Frac_9 ? $signed(8'sh2a) : $signed(_GEN_1253); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1255 = 7'h4e == data1Frac_9 ? $signed(8'sh2a) : $signed(_GEN_1254); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1256 = 7'h4f == data1Frac_9 ? $signed(8'sh2a) : $signed(_GEN_1255); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1257 = 7'h50 == data1Frac_9 ? $signed(8'sh29) : $signed(_GEN_1256); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1258 = 7'h51 == data1Frac_9 ? $signed(8'sh29) : $signed(_GEN_1257); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1259 = 7'h52 == data1Frac_9 ? $signed(8'sh29) : $signed(_GEN_1258); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1260 = 7'h53 == data1Frac_9 ? $signed(8'sh29) : $signed(_GEN_1259); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1261 = 7'h54 == data1Frac_9 ? $signed(8'sh29) : $signed(_GEN_1260); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1262 = 7'h55 == data1Frac_9 ? $signed(8'sh28) : $signed(_GEN_1261); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1263 = 7'h56 == data1Frac_9 ? $signed(8'sh28) : $signed(_GEN_1262); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1264 = 7'h57 == data1Frac_9 ? $signed(8'sh28) : $signed(_GEN_1263); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1265 = 7'h58 == data1Frac_9 ? $signed(8'sh28) : $signed(_GEN_1264); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1266 = 7'h59 == data1Frac_9 ? $signed(8'sh28) : $signed(_GEN_1265); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1267 = 7'h5a == data1Frac_9 ? $signed(8'sh27) : $signed(_GEN_1266); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1268 = 7'h5b == data1Frac_9 ? $signed(8'sh27) : $signed(_GEN_1267); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1269 = 7'h5c == data1Frac_9 ? $signed(8'sh27) : $signed(_GEN_1268); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1270 = 7'h5d == data1Frac_9 ? $signed(8'sh27) : $signed(_GEN_1269); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1271 = 7'h5e == data1Frac_9 ? $signed(8'sh26) : $signed(_GEN_1270); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1272 = 7'h5f == data1Frac_9 ? $signed(8'sh26) : $signed(_GEN_1271); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1273 = 7'h60 == data1Frac_9 ? $signed(8'sh26) : $signed(_GEN_1272); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1274 = 7'h61 == data1Frac_9 ? $signed(8'sh26) : $signed(_GEN_1273); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1275 = 7'h62 == data1Frac_9 ? $signed(8'sh26) : $signed(_GEN_1274); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1276 = 7'h63 == data1Frac_9 ? $signed(8'sh25) : $signed(_GEN_1275); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1277 = 7'h64 == data1Frac_9 ? $signed(8'sh25) : $signed(_GEN_1276); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1278 = 7'h65 == data1Frac_9 ? $signed(8'sh25) : $signed(_GEN_1277); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1279 = 7'h66 == data1Frac_9 ? $signed(8'sh25) : $signed(_GEN_1278); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1280 = 7'h67 == data1Frac_9 ? $signed(8'sh25) : $signed(_GEN_1279); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1281 = 7'h68 == data1Frac_9 ? $signed(8'sh24) : $signed(_GEN_1280); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1282 = 7'h69 == data1Frac_9 ? $signed(8'sh24) : $signed(_GEN_1281); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1283 = 7'h6a == data1Frac_9 ? $signed(8'sh24) : $signed(_GEN_1282); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1284 = 7'h6b == data1Frac_9 ? $signed(8'sh24) : $signed(_GEN_1283); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1285 = 7'h6c == data1Frac_9 ? $signed(8'sh24) : $signed(_GEN_1284); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1286 = 7'h6d == data1Frac_9 ? $signed(8'sh23) : $signed(_GEN_1285); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1287 = 7'h6e == data1Frac_9 ? $signed(8'sh23) : $signed(_GEN_1286); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1288 = 7'h6f == data1Frac_9 ? $signed(8'sh23) : $signed(_GEN_1287); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1289 = 7'h70 == data1Frac_9 ? $signed(8'sh23) : $signed(_GEN_1288); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1290 = 7'h71 == data1Frac_9 ? $signed(8'sh23) : $signed(_GEN_1289); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1291 = 7'h72 == data1Frac_9 ? $signed(8'sh23) : $signed(_GEN_1290); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1292 = 7'h73 == data1Frac_9 ? $signed(8'sh22) : $signed(_GEN_1291); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1293 = 7'h74 == data1Frac_9 ? $signed(8'sh22) : $signed(_GEN_1292); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1294 = 7'h75 == data1Frac_9 ? $signed(8'sh22) : $signed(_GEN_1293); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1295 = 7'h76 == data1Frac_9 ? $signed(8'sh22) : $signed(_GEN_1294); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1296 = 7'h77 == data1Frac_9 ? $signed(8'sh22) : $signed(_GEN_1295); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1297 = 7'h78 == data1Frac_9 ? $signed(8'sh21) : $signed(_GEN_1296); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1298 = 7'h79 == data1Frac_9 ? $signed(8'sh21) : $signed(_GEN_1297); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1299 = 7'h7a == data1Frac_9 ? $signed(8'sh21) : $signed(_GEN_1298); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1300 = 7'h7b == data1Frac_9 ? $signed(8'sh21) : $signed(_GEN_1299); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1301 = 7'h7c == data1Frac_9 ? $signed(8'sh21) : $signed(_GEN_1300); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1302 = 7'h7d == data1Frac_9 ? $signed(8'sh21) : $signed(_GEN_1301); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1303 = 7'h7e == data1Frac_9 ? $signed(8'sh20) : $signed(_GEN_1302); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1304 = 7'h7f == data1Frac_9 ? $signed(8'sh20) : $signed(_GEN_1303); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_29 = $signed(_GEN_1304) >>> data1Int_9; // @[exponent.scala 46:85]
  reg [7:0] data2_9; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1308 = 7'h2 == data1Frac_10 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1309 = 7'h3 == data1Frac_10 ? $signed(8'sh3f) : $signed(_GEN_1308); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1310 = 7'h4 == data1Frac_10 ? $signed(8'sh3f) : $signed(_GEN_1309); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1311 = 7'h5 == data1Frac_10 ? $signed(8'sh3e) : $signed(_GEN_1310); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1312 = 7'h6 == data1Frac_10 ? $signed(8'sh3e) : $signed(_GEN_1311); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1313 = 7'h7 == data1Frac_10 ? $signed(8'sh3e) : $signed(_GEN_1312); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1314 = 7'h8 == data1Frac_10 ? $signed(8'sh3d) : $signed(_GEN_1313); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1315 = 7'h9 == data1Frac_10 ? $signed(8'sh3d) : $signed(_GEN_1314); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1316 = 7'ha == data1Frac_10 ? $signed(8'sh3d) : $signed(_GEN_1315); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1317 = 7'hb == data1Frac_10 ? $signed(8'sh3c) : $signed(_GEN_1316); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1318 = 7'hc == data1Frac_10 ? $signed(8'sh3c) : $signed(_GEN_1317); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1319 = 7'hd == data1Frac_10 ? $signed(8'sh3c) : $signed(_GEN_1318); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1320 = 7'he == data1Frac_10 ? $signed(8'sh3b) : $signed(_GEN_1319); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1321 = 7'hf == data1Frac_10 ? $signed(8'sh3b) : $signed(_GEN_1320); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1322 = 7'h10 == data1Frac_10 ? $signed(8'sh3b) : $signed(_GEN_1321); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1323 = 7'h11 == data1Frac_10 ? $signed(8'sh3a) : $signed(_GEN_1322); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1324 = 7'h12 == data1Frac_10 ? $signed(8'sh3a) : $signed(_GEN_1323); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1325 = 7'h13 == data1Frac_10 ? $signed(8'sh3a) : $signed(_GEN_1324); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1326 = 7'h14 == data1Frac_10 ? $signed(8'sh39) : $signed(_GEN_1325); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1327 = 7'h15 == data1Frac_10 ? $signed(8'sh39) : $signed(_GEN_1326); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1328 = 7'h16 == data1Frac_10 ? $signed(8'sh39) : $signed(_GEN_1327); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1329 = 7'h17 == data1Frac_10 ? $signed(8'sh39) : $signed(_GEN_1328); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1330 = 7'h18 == data1Frac_10 ? $signed(8'sh38) : $signed(_GEN_1329); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1331 = 7'h19 == data1Frac_10 ? $signed(8'sh38) : $signed(_GEN_1330); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1332 = 7'h1a == data1Frac_10 ? $signed(8'sh38) : $signed(_GEN_1331); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1333 = 7'h1b == data1Frac_10 ? $signed(8'sh37) : $signed(_GEN_1332); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1334 = 7'h1c == data1Frac_10 ? $signed(8'sh37) : $signed(_GEN_1333); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1335 = 7'h1d == data1Frac_10 ? $signed(8'sh37) : $signed(_GEN_1334); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1336 = 7'h1e == data1Frac_10 ? $signed(8'sh36) : $signed(_GEN_1335); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1337 = 7'h1f == data1Frac_10 ? $signed(8'sh36) : $signed(_GEN_1336); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1338 = 7'h20 == data1Frac_10 ? $signed(8'sh36) : $signed(_GEN_1337); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1339 = 7'h21 == data1Frac_10 ? $signed(8'sh36) : $signed(_GEN_1338); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1340 = 7'h22 == data1Frac_10 ? $signed(8'sh35) : $signed(_GEN_1339); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1341 = 7'h23 == data1Frac_10 ? $signed(8'sh35) : $signed(_GEN_1340); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1342 = 7'h24 == data1Frac_10 ? $signed(8'sh35) : $signed(_GEN_1341); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1343 = 7'h25 == data1Frac_10 ? $signed(8'sh34) : $signed(_GEN_1342); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1344 = 7'h26 == data1Frac_10 ? $signed(8'sh34) : $signed(_GEN_1343); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1345 = 7'h27 == data1Frac_10 ? $signed(8'sh34) : $signed(_GEN_1344); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1346 = 7'h28 == data1Frac_10 ? $signed(8'sh34) : $signed(_GEN_1345); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1347 = 7'h29 == data1Frac_10 ? $signed(8'sh33) : $signed(_GEN_1346); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1348 = 7'h2a == data1Frac_10 ? $signed(8'sh33) : $signed(_GEN_1347); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1349 = 7'h2b == data1Frac_10 ? $signed(8'sh33) : $signed(_GEN_1348); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1350 = 7'h2c == data1Frac_10 ? $signed(8'sh32) : $signed(_GEN_1349); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1351 = 7'h2d == data1Frac_10 ? $signed(8'sh32) : $signed(_GEN_1350); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1352 = 7'h2e == data1Frac_10 ? $signed(8'sh32) : $signed(_GEN_1351); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1353 = 7'h2f == data1Frac_10 ? $signed(8'sh32) : $signed(_GEN_1352); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1354 = 7'h30 == data1Frac_10 ? $signed(8'sh31) : $signed(_GEN_1353); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1355 = 7'h31 == data1Frac_10 ? $signed(8'sh31) : $signed(_GEN_1354); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1356 = 7'h32 == data1Frac_10 ? $signed(8'sh31) : $signed(_GEN_1355); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1357 = 7'h33 == data1Frac_10 ? $signed(8'sh31) : $signed(_GEN_1356); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1358 = 7'h34 == data1Frac_10 ? $signed(8'sh30) : $signed(_GEN_1357); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1359 = 7'h35 == data1Frac_10 ? $signed(8'sh30) : $signed(_GEN_1358); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1360 = 7'h36 == data1Frac_10 ? $signed(8'sh30) : $signed(_GEN_1359); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1361 = 7'h37 == data1Frac_10 ? $signed(8'sh30) : $signed(_GEN_1360); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1362 = 7'h38 == data1Frac_10 ? $signed(8'sh2f) : $signed(_GEN_1361); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1363 = 7'h39 == data1Frac_10 ? $signed(8'sh2f) : $signed(_GEN_1362); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1364 = 7'h3a == data1Frac_10 ? $signed(8'sh2f) : $signed(_GEN_1363); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1365 = 7'h3b == data1Frac_10 ? $signed(8'sh2e) : $signed(_GEN_1364); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1366 = 7'h3c == data1Frac_10 ? $signed(8'sh2e) : $signed(_GEN_1365); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1367 = 7'h3d == data1Frac_10 ? $signed(8'sh2e) : $signed(_GEN_1366); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1368 = 7'h3e == data1Frac_10 ? $signed(8'sh2e) : $signed(_GEN_1367); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1369 = 7'h3f == data1Frac_10 ? $signed(8'sh2e) : $signed(_GEN_1368); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1370 = 7'h40 == data1Frac_10 ? $signed(8'sh2d) : $signed(_GEN_1369); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1371 = 7'h41 == data1Frac_10 ? $signed(8'sh2d) : $signed(_GEN_1370); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1372 = 7'h42 == data1Frac_10 ? $signed(8'sh2d) : $signed(_GEN_1371); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1373 = 7'h43 == data1Frac_10 ? $signed(8'sh2d) : $signed(_GEN_1372); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1374 = 7'h44 == data1Frac_10 ? $signed(8'sh2c) : $signed(_GEN_1373); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1375 = 7'h45 == data1Frac_10 ? $signed(8'sh2c) : $signed(_GEN_1374); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1376 = 7'h46 == data1Frac_10 ? $signed(8'sh2c) : $signed(_GEN_1375); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1377 = 7'h47 == data1Frac_10 ? $signed(8'sh2c) : $signed(_GEN_1376); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1378 = 7'h48 == data1Frac_10 ? $signed(8'sh2b) : $signed(_GEN_1377); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1379 = 7'h49 == data1Frac_10 ? $signed(8'sh2b) : $signed(_GEN_1378); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1380 = 7'h4a == data1Frac_10 ? $signed(8'sh2b) : $signed(_GEN_1379); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1381 = 7'h4b == data1Frac_10 ? $signed(8'sh2b) : $signed(_GEN_1380); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1382 = 7'h4c == data1Frac_10 ? $signed(8'sh2a) : $signed(_GEN_1381); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1383 = 7'h4d == data1Frac_10 ? $signed(8'sh2a) : $signed(_GEN_1382); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1384 = 7'h4e == data1Frac_10 ? $signed(8'sh2a) : $signed(_GEN_1383); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1385 = 7'h4f == data1Frac_10 ? $signed(8'sh2a) : $signed(_GEN_1384); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1386 = 7'h50 == data1Frac_10 ? $signed(8'sh29) : $signed(_GEN_1385); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1387 = 7'h51 == data1Frac_10 ? $signed(8'sh29) : $signed(_GEN_1386); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1388 = 7'h52 == data1Frac_10 ? $signed(8'sh29) : $signed(_GEN_1387); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1389 = 7'h53 == data1Frac_10 ? $signed(8'sh29) : $signed(_GEN_1388); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1390 = 7'h54 == data1Frac_10 ? $signed(8'sh29) : $signed(_GEN_1389); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1391 = 7'h55 == data1Frac_10 ? $signed(8'sh28) : $signed(_GEN_1390); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1392 = 7'h56 == data1Frac_10 ? $signed(8'sh28) : $signed(_GEN_1391); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1393 = 7'h57 == data1Frac_10 ? $signed(8'sh28) : $signed(_GEN_1392); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1394 = 7'h58 == data1Frac_10 ? $signed(8'sh28) : $signed(_GEN_1393); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1395 = 7'h59 == data1Frac_10 ? $signed(8'sh28) : $signed(_GEN_1394); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1396 = 7'h5a == data1Frac_10 ? $signed(8'sh27) : $signed(_GEN_1395); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1397 = 7'h5b == data1Frac_10 ? $signed(8'sh27) : $signed(_GEN_1396); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1398 = 7'h5c == data1Frac_10 ? $signed(8'sh27) : $signed(_GEN_1397); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1399 = 7'h5d == data1Frac_10 ? $signed(8'sh27) : $signed(_GEN_1398); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1400 = 7'h5e == data1Frac_10 ? $signed(8'sh26) : $signed(_GEN_1399); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1401 = 7'h5f == data1Frac_10 ? $signed(8'sh26) : $signed(_GEN_1400); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1402 = 7'h60 == data1Frac_10 ? $signed(8'sh26) : $signed(_GEN_1401); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1403 = 7'h61 == data1Frac_10 ? $signed(8'sh26) : $signed(_GEN_1402); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1404 = 7'h62 == data1Frac_10 ? $signed(8'sh26) : $signed(_GEN_1403); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1405 = 7'h63 == data1Frac_10 ? $signed(8'sh25) : $signed(_GEN_1404); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1406 = 7'h64 == data1Frac_10 ? $signed(8'sh25) : $signed(_GEN_1405); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1407 = 7'h65 == data1Frac_10 ? $signed(8'sh25) : $signed(_GEN_1406); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1408 = 7'h66 == data1Frac_10 ? $signed(8'sh25) : $signed(_GEN_1407); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1409 = 7'h67 == data1Frac_10 ? $signed(8'sh25) : $signed(_GEN_1408); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1410 = 7'h68 == data1Frac_10 ? $signed(8'sh24) : $signed(_GEN_1409); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1411 = 7'h69 == data1Frac_10 ? $signed(8'sh24) : $signed(_GEN_1410); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1412 = 7'h6a == data1Frac_10 ? $signed(8'sh24) : $signed(_GEN_1411); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1413 = 7'h6b == data1Frac_10 ? $signed(8'sh24) : $signed(_GEN_1412); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1414 = 7'h6c == data1Frac_10 ? $signed(8'sh24) : $signed(_GEN_1413); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1415 = 7'h6d == data1Frac_10 ? $signed(8'sh23) : $signed(_GEN_1414); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1416 = 7'h6e == data1Frac_10 ? $signed(8'sh23) : $signed(_GEN_1415); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1417 = 7'h6f == data1Frac_10 ? $signed(8'sh23) : $signed(_GEN_1416); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1418 = 7'h70 == data1Frac_10 ? $signed(8'sh23) : $signed(_GEN_1417); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1419 = 7'h71 == data1Frac_10 ? $signed(8'sh23) : $signed(_GEN_1418); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1420 = 7'h72 == data1Frac_10 ? $signed(8'sh23) : $signed(_GEN_1419); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1421 = 7'h73 == data1Frac_10 ? $signed(8'sh22) : $signed(_GEN_1420); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1422 = 7'h74 == data1Frac_10 ? $signed(8'sh22) : $signed(_GEN_1421); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1423 = 7'h75 == data1Frac_10 ? $signed(8'sh22) : $signed(_GEN_1422); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1424 = 7'h76 == data1Frac_10 ? $signed(8'sh22) : $signed(_GEN_1423); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1425 = 7'h77 == data1Frac_10 ? $signed(8'sh22) : $signed(_GEN_1424); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1426 = 7'h78 == data1Frac_10 ? $signed(8'sh21) : $signed(_GEN_1425); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1427 = 7'h79 == data1Frac_10 ? $signed(8'sh21) : $signed(_GEN_1426); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1428 = 7'h7a == data1Frac_10 ? $signed(8'sh21) : $signed(_GEN_1427); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1429 = 7'h7b == data1Frac_10 ? $signed(8'sh21) : $signed(_GEN_1428); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1430 = 7'h7c == data1Frac_10 ? $signed(8'sh21) : $signed(_GEN_1429); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1431 = 7'h7d == data1Frac_10 ? $signed(8'sh21) : $signed(_GEN_1430); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1432 = 7'h7e == data1Frac_10 ? $signed(8'sh20) : $signed(_GEN_1431); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1433 = 7'h7f == data1Frac_10 ? $signed(8'sh20) : $signed(_GEN_1432); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_32 = $signed(_GEN_1433) >>> data1Int_10; // @[exponent.scala 46:85]
  reg [7:0] data2_10; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1437 = 7'h2 == data1Frac_11 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1438 = 7'h3 == data1Frac_11 ? $signed(8'sh3f) : $signed(_GEN_1437); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1439 = 7'h4 == data1Frac_11 ? $signed(8'sh3f) : $signed(_GEN_1438); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1440 = 7'h5 == data1Frac_11 ? $signed(8'sh3e) : $signed(_GEN_1439); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1441 = 7'h6 == data1Frac_11 ? $signed(8'sh3e) : $signed(_GEN_1440); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1442 = 7'h7 == data1Frac_11 ? $signed(8'sh3e) : $signed(_GEN_1441); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1443 = 7'h8 == data1Frac_11 ? $signed(8'sh3d) : $signed(_GEN_1442); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1444 = 7'h9 == data1Frac_11 ? $signed(8'sh3d) : $signed(_GEN_1443); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1445 = 7'ha == data1Frac_11 ? $signed(8'sh3d) : $signed(_GEN_1444); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1446 = 7'hb == data1Frac_11 ? $signed(8'sh3c) : $signed(_GEN_1445); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1447 = 7'hc == data1Frac_11 ? $signed(8'sh3c) : $signed(_GEN_1446); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1448 = 7'hd == data1Frac_11 ? $signed(8'sh3c) : $signed(_GEN_1447); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1449 = 7'he == data1Frac_11 ? $signed(8'sh3b) : $signed(_GEN_1448); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1450 = 7'hf == data1Frac_11 ? $signed(8'sh3b) : $signed(_GEN_1449); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1451 = 7'h10 == data1Frac_11 ? $signed(8'sh3b) : $signed(_GEN_1450); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1452 = 7'h11 == data1Frac_11 ? $signed(8'sh3a) : $signed(_GEN_1451); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1453 = 7'h12 == data1Frac_11 ? $signed(8'sh3a) : $signed(_GEN_1452); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1454 = 7'h13 == data1Frac_11 ? $signed(8'sh3a) : $signed(_GEN_1453); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1455 = 7'h14 == data1Frac_11 ? $signed(8'sh39) : $signed(_GEN_1454); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1456 = 7'h15 == data1Frac_11 ? $signed(8'sh39) : $signed(_GEN_1455); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1457 = 7'h16 == data1Frac_11 ? $signed(8'sh39) : $signed(_GEN_1456); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1458 = 7'h17 == data1Frac_11 ? $signed(8'sh39) : $signed(_GEN_1457); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1459 = 7'h18 == data1Frac_11 ? $signed(8'sh38) : $signed(_GEN_1458); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1460 = 7'h19 == data1Frac_11 ? $signed(8'sh38) : $signed(_GEN_1459); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1461 = 7'h1a == data1Frac_11 ? $signed(8'sh38) : $signed(_GEN_1460); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1462 = 7'h1b == data1Frac_11 ? $signed(8'sh37) : $signed(_GEN_1461); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1463 = 7'h1c == data1Frac_11 ? $signed(8'sh37) : $signed(_GEN_1462); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1464 = 7'h1d == data1Frac_11 ? $signed(8'sh37) : $signed(_GEN_1463); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1465 = 7'h1e == data1Frac_11 ? $signed(8'sh36) : $signed(_GEN_1464); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1466 = 7'h1f == data1Frac_11 ? $signed(8'sh36) : $signed(_GEN_1465); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1467 = 7'h20 == data1Frac_11 ? $signed(8'sh36) : $signed(_GEN_1466); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1468 = 7'h21 == data1Frac_11 ? $signed(8'sh36) : $signed(_GEN_1467); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1469 = 7'h22 == data1Frac_11 ? $signed(8'sh35) : $signed(_GEN_1468); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1470 = 7'h23 == data1Frac_11 ? $signed(8'sh35) : $signed(_GEN_1469); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1471 = 7'h24 == data1Frac_11 ? $signed(8'sh35) : $signed(_GEN_1470); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1472 = 7'h25 == data1Frac_11 ? $signed(8'sh34) : $signed(_GEN_1471); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1473 = 7'h26 == data1Frac_11 ? $signed(8'sh34) : $signed(_GEN_1472); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1474 = 7'h27 == data1Frac_11 ? $signed(8'sh34) : $signed(_GEN_1473); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1475 = 7'h28 == data1Frac_11 ? $signed(8'sh34) : $signed(_GEN_1474); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1476 = 7'h29 == data1Frac_11 ? $signed(8'sh33) : $signed(_GEN_1475); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1477 = 7'h2a == data1Frac_11 ? $signed(8'sh33) : $signed(_GEN_1476); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1478 = 7'h2b == data1Frac_11 ? $signed(8'sh33) : $signed(_GEN_1477); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1479 = 7'h2c == data1Frac_11 ? $signed(8'sh32) : $signed(_GEN_1478); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1480 = 7'h2d == data1Frac_11 ? $signed(8'sh32) : $signed(_GEN_1479); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1481 = 7'h2e == data1Frac_11 ? $signed(8'sh32) : $signed(_GEN_1480); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1482 = 7'h2f == data1Frac_11 ? $signed(8'sh32) : $signed(_GEN_1481); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1483 = 7'h30 == data1Frac_11 ? $signed(8'sh31) : $signed(_GEN_1482); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1484 = 7'h31 == data1Frac_11 ? $signed(8'sh31) : $signed(_GEN_1483); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1485 = 7'h32 == data1Frac_11 ? $signed(8'sh31) : $signed(_GEN_1484); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1486 = 7'h33 == data1Frac_11 ? $signed(8'sh31) : $signed(_GEN_1485); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1487 = 7'h34 == data1Frac_11 ? $signed(8'sh30) : $signed(_GEN_1486); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1488 = 7'h35 == data1Frac_11 ? $signed(8'sh30) : $signed(_GEN_1487); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1489 = 7'h36 == data1Frac_11 ? $signed(8'sh30) : $signed(_GEN_1488); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1490 = 7'h37 == data1Frac_11 ? $signed(8'sh30) : $signed(_GEN_1489); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1491 = 7'h38 == data1Frac_11 ? $signed(8'sh2f) : $signed(_GEN_1490); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1492 = 7'h39 == data1Frac_11 ? $signed(8'sh2f) : $signed(_GEN_1491); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1493 = 7'h3a == data1Frac_11 ? $signed(8'sh2f) : $signed(_GEN_1492); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1494 = 7'h3b == data1Frac_11 ? $signed(8'sh2e) : $signed(_GEN_1493); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1495 = 7'h3c == data1Frac_11 ? $signed(8'sh2e) : $signed(_GEN_1494); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1496 = 7'h3d == data1Frac_11 ? $signed(8'sh2e) : $signed(_GEN_1495); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1497 = 7'h3e == data1Frac_11 ? $signed(8'sh2e) : $signed(_GEN_1496); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1498 = 7'h3f == data1Frac_11 ? $signed(8'sh2e) : $signed(_GEN_1497); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1499 = 7'h40 == data1Frac_11 ? $signed(8'sh2d) : $signed(_GEN_1498); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1500 = 7'h41 == data1Frac_11 ? $signed(8'sh2d) : $signed(_GEN_1499); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1501 = 7'h42 == data1Frac_11 ? $signed(8'sh2d) : $signed(_GEN_1500); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1502 = 7'h43 == data1Frac_11 ? $signed(8'sh2d) : $signed(_GEN_1501); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1503 = 7'h44 == data1Frac_11 ? $signed(8'sh2c) : $signed(_GEN_1502); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1504 = 7'h45 == data1Frac_11 ? $signed(8'sh2c) : $signed(_GEN_1503); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1505 = 7'h46 == data1Frac_11 ? $signed(8'sh2c) : $signed(_GEN_1504); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1506 = 7'h47 == data1Frac_11 ? $signed(8'sh2c) : $signed(_GEN_1505); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1507 = 7'h48 == data1Frac_11 ? $signed(8'sh2b) : $signed(_GEN_1506); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1508 = 7'h49 == data1Frac_11 ? $signed(8'sh2b) : $signed(_GEN_1507); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1509 = 7'h4a == data1Frac_11 ? $signed(8'sh2b) : $signed(_GEN_1508); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1510 = 7'h4b == data1Frac_11 ? $signed(8'sh2b) : $signed(_GEN_1509); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1511 = 7'h4c == data1Frac_11 ? $signed(8'sh2a) : $signed(_GEN_1510); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1512 = 7'h4d == data1Frac_11 ? $signed(8'sh2a) : $signed(_GEN_1511); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1513 = 7'h4e == data1Frac_11 ? $signed(8'sh2a) : $signed(_GEN_1512); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1514 = 7'h4f == data1Frac_11 ? $signed(8'sh2a) : $signed(_GEN_1513); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1515 = 7'h50 == data1Frac_11 ? $signed(8'sh29) : $signed(_GEN_1514); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1516 = 7'h51 == data1Frac_11 ? $signed(8'sh29) : $signed(_GEN_1515); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1517 = 7'h52 == data1Frac_11 ? $signed(8'sh29) : $signed(_GEN_1516); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1518 = 7'h53 == data1Frac_11 ? $signed(8'sh29) : $signed(_GEN_1517); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1519 = 7'h54 == data1Frac_11 ? $signed(8'sh29) : $signed(_GEN_1518); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1520 = 7'h55 == data1Frac_11 ? $signed(8'sh28) : $signed(_GEN_1519); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1521 = 7'h56 == data1Frac_11 ? $signed(8'sh28) : $signed(_GEN_1520); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1522 = 7'h57 == data1Frac_11 ? $signed(8'sh28) : $signed(_GEN_1521); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1523 = 7'h58 == data1Frac_11 ? $signed(8'sh28) : $signed(_GEN_1522); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1524 = 7'h59 == data1Frac_11 ? $signed(8'sh28) : $signed(_GEN_1523); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1525 = 7'h5a == data1Frac_11 ? $signed(8'sh27) : $signed(_GEN_1524); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1526 = 7'h5b == data1Frac_11 ? $signed(8'sh27) : $signed(_GEN_1525); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1527 = 7'h5c == data1Frac_11 ? $signed(8'sh27) : $signed(_GEN_1526); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1528 = 7'h5d == data1Frac_11 ? $signed(8'sh27) : $signed(_GEN_1527); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1529 = 7'h5e == data1Frac_11 ? $signed(8'sh26) : $signed(_GEN_1528); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1530 = 7'h5f == data1Frac_11 ? $signed(8'sh26) : $signed(_GEN_1529); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1531 = 7'h60 == data1Frac_11 ? $signed(8'sh26) : $signed(_GEN_1530); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1532 = 7'h61 == data1Frac_11 ? $signed(8'sh26) : $signed(_GEN_1531); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1533 = 7'h62 == data1Frac_11 ? $signed(8'sh26) : $signed(_GEN_1532); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1534 = 7'h63 == data1Frac_11 ? $signed(8'sh25) : $signed(_GEN_1533); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1535 = 7'h64 == data1Frac_11 ? $signed(8'sh25) : $signed(_GEN_1534); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1536 = 7'h65 == data1Frac_11 ? $signed(8'sh25) : $signed(_GEN_1535); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1537 = 7'h66 == data1Frac_11 ? $signed(8'sh25) : $signed(_GEN_1536); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1538 = 7'h67 == data1Frac_11 ? $signed(8'sh25) : $signed(_GEN_1537); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1539 = 7'h68 == data1Frac_11 ? $signed(8'sh24) : $signed(_GEN_1538); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1540 = 7'h69 == data1Frac_11 ? $signed(8'sh24) : $signed(_GEN_1539); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1541 = 7'h6a == data1Frac_11 ? $signed(8'sh24) : $signed(_GEN_1540); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1542 = 7'h6b == data1Frac_11 ? $signed(8'sh24) : $signed(_GEN_1541); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1543 = 7'h6c == data1Frac_11 ? $signed(8'sh24) : $signed(_GEN_1542); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1544 = 7'h6d == data1Frac_11 ? $signed(8'sh23) : $signed(_GEN_1543); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1545 = 7'h6e == data1Frac_11 ? $signed(8'sh23) : $signed(_GEN_1544); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1546 = 7'h6f == data1Frac_11 ? $signed(8'sh23) : $signed(_GEN_1545); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1547 = 7'h70 == data1Frac_11 ? $signed(8'sh23) : $signed(_GEN_1546); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1548 = 7'h71 == data1Frac_11 ? $signed(8'sh23) : $signed(_GEN_1547); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1549 = 7'h72 == data1Frac_11 ? $signed(8'sh23) : $signed(_GEN_1548); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1550 = 7'h73 == data1Frac_11 ? $signed(8'sh22) : $signed(_GEN_1549); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1551 = 7'h74 == data1Frac_11 ? $signed(8'sh22) : $signed(_GEN_1550); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1552 = 7'h75 == data1Frac_11 ? $signed(8'sh22) : $signed(_GEN_1551); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1553 = 7'h76 == data1Frac_11 ? $signed(8'sh22) : $signed(_GEN_1552); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1554 = 7'h77 == data1Frac_11 ? $signed(8'sh22) : $signed(_GEN_1553); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1555 = 7'h78 == data1Frac_11 ? $signed(8'sh21) : $signed(_GEN_1554); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1556 = 7'h79 == data1Frac_11 ? $signed(8'sh21) : $signed(_GEN_1555); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1557 = 7'h7a == data1Frac_11 ? $signed(8'sh21) : $signed(_GEN_1556); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1558 = 7'h7b == data1Frac_11 ? $signed(8'sh21) : $signed(_GEN_1557); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1559 = 7'h7c == data1Frac_11 ? $signed(8'sh21) : $signed(_GEN_1558); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1560 = 7'h7d == data1Frac_11 ? $signed(8'sh21) : $signed(_GEN_1559); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1561 = 7'h7e == data1Frac_11 ? $signed(8'sh20) : $signed(_GEN_1560); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1562 = 7'h7f == data1Frac_11 ? $signed(8'sh20) : $signed(_GEN_1561); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_35 = $signed(_GEN_1562) >>> data1Int_11; // @[exponent.scala 46:85]
  reg [7:0] data2_11; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1566 = 7'h2 == data1Frac_12 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1567 = 7'h3 == data1Frac_12 ? $signed(8'sh3f) : $signed(_GEN_1566); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1568 = 7'h4 == data1Frac_12 ? $signed(8'sh3f) : $signed(_GEN_1567); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1569 = 7'h5 == data1Frac_12 ? $signed(8'sh3e) : $signed(_GEN_1568); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1570 = 7'h6 == data1Frac_12 ? $signed(8'sh3e) : $signed(_GEN_1569); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1571 = 7'h7 == data1Frac_12 ? $signed(8'sh3e) : $signed(_GEN_1570); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1572 = 7'h8 == data1Frac_12 ? $signed(8'sh3d) : $signed(_GEN_1571); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1573 = 7'h9 == data1Frac_12 ? $signed(8'sh3d) : $signed(_GEN_1572); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1574 = 7'ha == data1Frac_12 ? $signed(8'sh3d) : $signed(_GEN_1573); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1575 = 7'hb == data1Frac_12 ? $signed(8'sh3c) : $signed(_GEN_1574); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1576 = 7'hc == data1Frac_12 ? $signed(8'sh3c) : $signed(_GEN_1575); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1577 = 7'hd == data1Frac_12 ? $signed(8'sh3c) : $signed(_GEN_1576); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1578 = 7'he == data1Frac_12 ? $signed(8'sh3b) : $signed(_GEN_1577); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1579 = 7'hf == data1Frac_12 ? $signed(8'sh3b) : $signed(_GEN_1578); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1580 = 7'h10 == data1Frac_12 ? $signed(8'sh3b) : $signed(_GEN_1579); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1581 = 7'h11 == data1Frac_12 ? $signed(8'sh3a) : $signed(_GEN_1580); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1582 = 7'h12 == data1Frac_12 ? $signed(8'sh3a) : $signed(_GEN_1581); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1583 = 7'h13 == data1Frac_12 ? $signed(8'sh3a) : $signed(_GEN_1582); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1584 = 7'h14 == data1Frac_12 ? $signed(8'sh39) : $signed(_GEN_1583); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1585 = 7'h15 == data1Frac_12 ? $signed(8'sh39) : $signed(_GEN_1584); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1586 = 7'h16 == data1Frac_12 ? $signed(8'sh39) : $signed(_GEN_1585); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1587 = 7'h17 == data1Frac_12 ? $signed(8'sh39) : $signed(_GEN_1586); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1588 = 7'h18 == data1Frac_12 ? $signed(8'sh38) : $signed(_GEN_1587); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1589 = 7'h19 == data1Frac_12 ? $signed(8'sh38) : $signed(_GEN_1588); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1590 = 7'h1a == data1Frac_12 ? $signed(8'sh38) : $signed(_GEN_1589); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1591 = 7'h1b == data1Frac_12 ? $signed(8'sh37) : $signed(_GEN_1590); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1592 = 7'h1c == data1Frac_12 ? $signed(8'sh37) : $signed(_GEN_1591); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1593 = 7'h1d == data1Frac_12 ? $signed(8'sh37) : $signed(_GEN_1592); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1594 = 7'h1e == data1Frac_12 ? $signed(8'sh36) : $signed(_GEN_1593); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1595 = 7'h1f == data1Frac_12 ? $signed(8'sh36) : $signed(_GEN_1594); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1596 = 7'h20 == data1Frac_12 ? $signed(8'sh36) : $signed(_GEN_1595); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1597 = 7'h21 == data1Frac_12 ? $signed(8'sh36) : $signed(_GEN_1596); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1598 = 7'h22 == data1Frac_12 ? $signed(8'sh35) : $signed(_GEN_1597); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1599 = 7'h23 == data1Frac_12 ? $signed(8'sh35) : $signed(_GEN_1598); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1600 = 7'h24 == data1Frac_12 ? $signed(8'sh35) : $signed(_GEN_1599); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1601 = 7'h25 == data1Frac_12 ? $signed(8'sh34) : $signed(_GEN_1600); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1602 = 7'h26 == data1Frac_12 ? $signed(8'sh34) : $signed(_GEN_1601); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1603 = 7'h27 == data1Frac_12 ? $signed(8'sh34) : $signed(_GEN_1602); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1604 = 7'h28 == data1Frac_12 ? $signed(8'sh34) : $signed(_GEN_1603); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1605 = 7'h29 == data1Frac_12 ? $signed(8'sh33) : $signed(_GEN_1604); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1606 = 7'h2a == data1Frac_12 ? $signed(8'sh33) : $signed(_GEN_1605); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1607 = 7'h2b == data1Frac_12 ? $signed(8'sh33) : $signed(_GEN_1606); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1608 = 7'h2c == data1Frac_12 ? $signed(8'sh32) : $signed(_GEN_1607); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1609 = 7'h2d == data1Frac_12 ? $signed(8'sh32) : $signed(_GEN_1608); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1610 = 7'h2e == data1Frac_12 ? $signed(8'sh32) : $signed(_GEN_1609); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1611 = 7'h2f == data1Frac_12 ? $signed(8'sh32) : $signed(_GEN_1610); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1612 = 7'h30 == data1Frac_12 ? $signed(8'sh31) : $signed(_GEN_1611); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1613 = 7'h31 == data1Frac_12 ? $signed(8'sh31) : $signed(_GEN_1612); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1614 = 7'h32 == data1Frac_12 ? $signed(8'sh31) : $signed(_GEN_1613); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1615 = 7'h33 == data1Frac_12 ? $signed(8'sh31) : $signed(_GEN_1614); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1616 = 7'h34 == data1Frac_12 ? $signed(8'sh30) : $signed(_GEN_1615); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1617 = 7'h35 == data1Frac_12 ? $signed(8'sh30) : $signed(_GEN_1616); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1618 = 7'h36 == data1Frac_12 ? $signed(8'sh30) : $signed(_GEN_1617); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1619 = 7'h37 == data1Frac_12 ? $signed(8'sh30) : $signed(_GEN_1618); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1620 = 7'h38 == data1Frac_12 ? $signed(8'sh2f) : $signed(_GEN_1619); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1621 = 7'h39 == data1Frac_12 ? $signed(8'sh2f) : $signed(_GEN_1620); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1622 = 7'h3a == data1Frac_12 ? $signed(8'sh2f) : $signed(_GEN_1621); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1623 = 7'h3b == data1Frac_12 ? $signed(8'sh2e) : $signed(_GEN_1622); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1624 = 7'h3c == data1Frac_12 ? $signed(8'sh2e) : $signed(_GEN_1623); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1625 = 7'h3d == data1Frac_12 ? $signed(8'sh2e) : $signed(_GEN_1624); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1626 = 7'h3e == data1Frac_12 ? $signed(8'sh2e) : $signed(_GEN_1625); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1627 = 7'h3f == data1Frac_12 ? $signed(8'sh2e) : $signed(_GEN_1626); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1628 = 7'h40 == data1Frac_12 ? $signed(8'sh2d) : $signed(_GEN_1627); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1629 = 7'h41 == data1Frac_12 ? $signed(8'sh2d) : $signed(_GEN_1628); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1630 = 7'h42 == data1Frac_12 ? $signed(8'sh2d) : $signed(_GEN_1629); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1631 = 7'h43 == data1Frac_12 ? $signed(8'sh2d) : $signed(_GEN_1630); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1632 = 7'h44 == data1Frac_12 ? $signed(8'sh2c) : $signed(_GEN_1631); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1633 = 7'h45 == data1Frac_12 ? $signed(8'sh2c) : $signed(_GEN_1632); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1634 = 7'h46 == data1Frac_12 ? $signed(8'sh2c) : $signed(_GEN_1633); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1635 = 7'h47 == data1Frac_12 ? $signed(8'sh2c) : $signed(_GEN_1634); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1636 = 7'h48 == data1Frac_12 ? $signed(8'sh2b) : $signed(_GEN_1635); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1637 = 7'h49 == data1Frac_12 ? $signed(8'sh2b) : $signed(_GEN_1636); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1638 = 7'h4a == data1Frac_12 ? $signed(8'sh2b) : $signed(_GEN_1637); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1639 = 7'h4b == data1Frac_12 ? $signed(8'sh2b) : $signed(_GEN_1638); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1640 = 7'h4c == data1Frac_12 ? $signed(8'sh2a) : $signed(_GEN_1639); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1641 = 7'h4d == data1Frac_12 ? $signed(8'sh2a) : $signed(_GEN_1640); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1642 = 7'h4e == data1Frac_12 ? $signed(8'sh2a) : $signed(_GEN_1641); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1643 = 7'h4f == data1Frac_12 ? $signed(8'sh2a) : $signed(_GEN_1642); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1644 = 7'h50 == data1Frac_12 ? $signed(8'sh29) : $signed(_GEN_1643); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1645 = 7'h51 == data1Frac_12 ? $signed(8'sh29) : $signed(_GEN_1644); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1646 = 7'h52 == data1Frac_12 ? $signed(8'sh29) : $signed(_GEN_1645); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1647 = 7'h53 == data1Frac_12 ? $signed(8'sh29) : $signed(_GEN_1646); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1648 = 7'h54 == data1Frac_12 ? $signed(8'sh29) : $signed(_GEN_1647); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1649 = 7'h55 == data1Frac_12 ? $signed(8'sh28) : $signed(_GEN_1648); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1650 = 7'h56 == data1Frac_12 ? $signed(8'sh28) : $signed(_GEN_1649); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1651 = 7'h57 == data1Frac_12 ? $signed(8'sh28) : $signed(_GEN_1650); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1652 = 7'h58 == data1Frac_12 ? $signed(8'sh28) : $signed(_GEN_1651); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1653 = 7'h59 == data1Frac_12 ? $signed(8'sh28) : $signed(_GEN_1652); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1654 = 7'h5a == data1Frac_12 ? $signed(8'sh27) : $signed(_GEN_1653); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1655 = 7'h5b == data1Frac_12 ? $signed(8'sh27) : $signed(_GEN_1654); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1656 = 7'h5c == data1Frac_12 ? $signed(8'sh27) : $signed(_GEN_1655); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1657 = 7'h5d == data1Frac_12 ? $signed(8'sh27) : $signed(_GEN_1656); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1658 = 7'h5e == data1Frac_12 ? $signed(8'sh26) : $signed(_GEN_1657); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1659 = 7'h5f == data1Frac_12 ? $signed(8'sh26) : $signed(_GEN_1658); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1660 = 7'h60 == data1Frac_12 ? $signed(8'sh26) : $signed(_GEN_1659); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1661 = 7'h61 == data1Frac_12 ? $signed(8'sh26) : $signed(_GEN_1660); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1662 = 7'h62 == data1Frac_12 ? $signed(8'sh26) : $signed(_GEN_1661); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1663 = 7'h63 == data1Frac_12 ? $signed(8'sh25) : $signed(_GEN_1662); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1664 = 7'h64 == data1Frac_12 ? $signed(8'sh25) : $signed(_GEN_1663); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1665 = 7'h65 == data1Frac_12 ? $signed(8'sh25) : $signed(_GEN_1664); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1666 = 7'h66 == data1Frac_12 ? $signed(8'sh25) : $signed(_GEN_1665); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1667 = 7'h67 == data1Frac_12 ? $signed(8'sh25) : $signed(_GEN_1666); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1668 = 7'h68 == data1Frac_12 ? $signed(8'sh24) : $signed(_GEN_1667); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1669 = 7'h69 == data1Frac_12 ? $signed(8'sh24) : $signed(_GEN_1668); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1670 = 7'h6a == data1Frac_12 ? $signed(8'sh24) : $signed(_GEN_1669); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1671 = 7'h6b == data1Frac_12 ? $signed(8'sh24) : $signed(_GEN_1670); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1672 = 7'h6c == data1Frac_12 ? $signed(8'sh24) : $signed(_GEN_1671); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1673 = 7'h6d == data1Frac_12 ? $signed(8'sh23) : $signed(_GEN_1672); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1674 = 7'h6e == data1Frac_12 ? $signed(8'sh23) : $signed(_GEN_1673); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1675 = 7'h6f == data1Frac_12 ? $signed(8'sh23) : $signed(_GEN_1674); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1676 = 7'h70 == data1Frac_12 ? $signed(8'sh23) : $signed(_GEN_1675); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1677 = 7'h71 == data1Frac_12 ? $signed(8'sh23) : $signed(_GEN_1676); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1678 = 7'h72 == data1Frac_12 ? $signed(8'sh23) : $signed(_GEN_1677); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1679 = 7'h73 == data1Frac_12 ? $signed(8'sh22) : $signed(_GEN_1678); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1680 = 7'h74 == data1Frac_12 ? $signed(8'sh22) : $signed(_GEN_1679); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1681 = 7'h75 == data1Frac_12 ? $signed(8'sh22) : $signed(_GEN_1680); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1682 = 7'h76 == data1Frac_12 ? $signed(8'sh22) : $signed(_GEN_1681); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1683 = 7'h77 == data1Frac_12 ? $signed(8'sh22) : $signed(_GEN_1682); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1684 = 7'h78 == data1Frac_12 ? $signed(8'sh21) : $signed(_GEN_1683); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1685 = 7'h79 == data1Frac_12 ? $signed(8'sh21) : $signed(_GEN_1684); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1686 = 7'h7a == data1Frac_12 ? $signed(8'sh21) : $signed(_GEN_1685); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1687 = 7'h7b == data1Frac_12 ? $signed(8'sh21) : $signed(_GEN_1686); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1688 = 7'h7c == data1Frac_12 ? $signed(8'sh21) : $signed(_GEN_1687); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1689 = 7'h7d == data1Frac_12 ? $signed(8'sh21) : $signed(_GEN_1688); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1690 = 7'h7e == data1Frac_12 ? $signed(8'sh20) : $signed(_GEN_1689); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1691 = 7'h7f == data1Frac_12 ? $signed(8'sh20) : $signed(_GEN_1690); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_38 = $signed(_GEN_1691) >>> data1Int_12; // @[exponent.scala 46:85]
  reg [7:0] data2_12; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1695 = 7'h2 == data1Frac_13 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1696 = 7'h3 == data1Frac_13 ? $signed(8'sh3f) : $signed(_GEN_1695); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1697 = 7'h4 == data1Frac_13 ? $signed(8'sh3f) : $signed(_GEN_1696); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1698 = 7'h5 == data1Frac_13 ? $signed(8'sh3e) : $signed(_GEN_1697); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1699 = 7'h6 == data1Frac_13 ? $signed(8'sh3e) : $signed(_GEN_1698); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1700 = 7'h7 == data1Frac_13 ? $signed(8'sh3e) : $signed(_GEN_1699); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1701 = 7'h8 == data1Frac_13 ? $signed(8'sh3d) : $signed(_GEN_1700); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1702 = 7'h9 == data1Frac_13 ? $signed(8'sh3d) : $signed(_GEN_1701); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1703 = 7'ha == data1Frac_13 ? $signed(8'sh3d) : $signed(_GEN_1702); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1704 = 7'hb == data1Frac_13 ? $signed(8'sh3c) : $signed(_GEN_1703); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1705 = 7'hc == data1Frac_13 ? $signed(8'sh3c) : $signed(_GEN_1704); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1706 = 7'hd == data1Frac_13 ? $signed(8'sh3c) : $signed(_GEN_1705); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1707 = 7'he == data1Frac_13 ? $signed(8'sh3b) : $signed(_GEN_1706); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1708 = 7'hf == data1Frac_13 ? $signed(8'sh3b) : $signed(_GEN_1707); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1709 = 7'h10 == data1Frac_13 ? $signed(8'sh3b) : $signed(_GEN_1708); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1710 = 7'h11 == data1Frac_13 ? $signed(8'sh3a) : $signed(_GEN_1709); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1711 = 7'h12 == data1Frac_13 ? $signed(8'sh3a) : $signed(_GEN_1710); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1712 = 7'h13 == data1Frac_13 ? $signed(8'sh3a) : $signed(_GEN_1711); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1713 = 7'h14 == data1Frac_13 ? $signed(8'sh39) : $signed(_GEN_1712); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1714 = 7'h15 == data1Frac_13 ? $signed(8'sh39) : $signed(_GEN_1713); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1715 = 7'h16 == data1Frac_13 ? $signed(8'sh39) : $signed(_GEN_1714); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1716 = 7'h17 == data1Frac_13 ? $signed(8'sh39) : $signed(_GEN_1715); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1717 = 7'h18 == data1Frac_13 ? $signed(8'sh38) : $signed(_GEN_1716); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1718 = 7'h19 == data1Frac_13 ? $signed(8'sh38) : $signed(_GEN_1717); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1719 = 7'h1a == data1Frac_13 ? $signed(8'sh38) : $signed(_GEN_1718); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1720 = 7'h1b == data1Frac_13 ? $signed(8'sh37) : $signed(_GEN_1719); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1721 = 7'h1c == data1Frac_13 ? $signed(8'sh37) : $signed(_GEN_1720); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1722 = 7'h1d == data1Frac_13 ? $signed(8'sh37) : $signed(_GEN_1721); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1723 = 7'h1e == data1Frac_13 ? $signed(8'sh36) : $signed(_GEN_1722); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1724 = 7'h1f == data1Frac_13 ? $signed(8'sh36) : $signed(_GEN_1723); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1725 = 7'h20 == data1Frac_13 ? $signed(8'sh36) : $signed(_GEN_1724); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1726 = 7'h21 == data1Frac_13 ? $signed(8'sh36) : $signed(_GEN_1725); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1727 = 7'h22 == data1Frac_13 ? $signed(8'sh35) : $signed(_GEN_1726); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1728 = 7'h23 == data1Frac_13 ? $signed(8'sh35) : $signed(_GEN_1727); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1729 = 7'h24 == data1Frac_13 ? $signed(8'sh35) : $signed(_GEN_1728); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1730 = 7'h25 == data1Frac_13 ? $signed(8'sh34) : $signed(_GEN_1729); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1731 = 7'h26 == data1Frac_13 ? $signed(8'sh34) : $signed(_GEN_1730); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1732 = 7'h27 == data1Frac_13 ? $signed(8'sh34) : $signed(_GEN_1731); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1733 = 7'h28 == data1Frac_13 ? $signed(8'sh34) : $signed(_GEN_1732); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1734 = 7'h29 == data1Frac_13 ? $signed(8'sh33) : $signed(_GEN_1733); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1735 = 7'h2a == data1Frac_13 ? $signed(8'sh33) : $signed(_GEN_1734); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1736 = 7'h2b == data1Frac_13 ? $signed(8'sh33) : $signed(_GEN_1735); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1737 = 7'h2c == data1Frac_13 ? $signed(8'sh32) : $signed(_GEN_1736); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1738 = 7'h2d == data1Frac_13 ? $signed(8'sh32) : $signed(_GEN_1737); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1739 = 7'h2e == data1Frac_13 ? $signed(8'sh32) : $signed(_GEN_1738); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1740 = 7'h2f == data1Frac_13 ? $signed(8'sh32) : $signed(_GEN_1739); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1741 = 7'h30 == data1Frac_13 ? $signed(8'sh31) : $signed(_GEN_1740); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1742 = 7'h31 == data1Frac_13 ? $signed(8'sh31) : $signed(_GEN_1741); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1743 = 7'h32 == data1Frac_13 ? $signed(8'sh31) : $signed(_GEN_1742); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1744 = 7'h33 == data1Frac_13 ? $signed(8'sh31) : $signed(_GEN_1743); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1745 = 7'h34 == data1Frac_13 ? $signed(8'sh30) : $signed(_GEN_1744); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1746 = 7'h35 == data1Frac_13 ? $signed(8'sh30) : $signed(_GEN_1745); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1747 = 7'h36 == data1Frac_13 ? $signed(8'sh30) : $signed(_GEN_1746); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1748 = 7'h37 == data1Frac_13 ? $signed(8'sh30) : $signed(_GEN_1747); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1749 = 7'h38 == data1Frac_13 ? $signed(8'sh2f) : $signed(_GEN_1748); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1750 = 7'h39 == data1Frac_13 ? $signed(8'sh2f) : $signed(_GEN_1749); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1751 = 7'h3a == data1Frac_13 ? $signed(8'sh2f) : $signed(_GEN_1750); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1752 = 7'h3b == data1Frac_13 ? $signed(8'sh2e) : $signed(_GEN_1751); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1753 = 7'h3c == data1Frac_13 ? $signed(8'sh2e) : $signed(_GEN_1752); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1754 = 7'h3d == data1Frac_13 ? $signed(8'sh2e) : $signed(_GEN_1753); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1755 = 7'h3e == data1Frac_13 ? $signed(8'sh2e) : $signed(_GEN_1754); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1756 = 7'h3f == data1Frac_13 ? $signed(8'sh2e) : $signed(_GEN_1755); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1757 = 7'h40 == data1Frac_13 ? $signed(8'sh2d) : $signed(_GEN_1756); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1758 = 7'h41 == data1Frac_13 ? $signed(8'sh2d) : $signed(_GEN_1757); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1759 = 7'h42 == data1Frac_13 ? $signed(8'sh2d) : $signed(_GEN_1758); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1760 = 7'h43 == data1Frac_13 ? $signed(8'sh2d) : $signed(_GEN_1759); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1761 = 7'h44 == data1Frac_13 ? $signed(8'sh2c) : $signed(_GEN_1760); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1762 = 7'h45 == data1Frac_13 ? $signed(8'sh2c) : $signed(_GEN_1761); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1763 = 7'h46 == data1Frac_13 ? $signed(8'sh2c) : $signed(_GEN_1762); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1764 = 7'h47 == data1Frac_13 ? $signed(8'sh2c) : $signed(_GEN_1763); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1765 = 7'h48 == data1Frac_13 ? $signed(8'sh2b) : $signed(_GEN_1764); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1766 = 7'h49 == data1Frac_13 ? $signed(8'sh2b) : $signed(_GEN_1765); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1767 = 7'h4a == data1Frac_13 ? $signed(8'sh2b) : $signed(_GEN_1766); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1768 = 7'h4b == data1Frac_13 ? $signed(8'sh2b) : $signed(_GEN_1767); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1769 = 7'h4c == data1Frac_13 ? $signed(8'sh2a) : $signed(_GEN_1768); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1770 = 7'h4d == data1Frac_13 ? $signed(8'sh2a) : $signed(_GEN_1769); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1771 = 7'h4e == data1Frac_13 ? $signed(8'sh2a) : $signed(_GEN_1770); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1772 = 7'h4f == data1Frac_13 ? $signed(8'sh2a) : $signed(_GEN_1771); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1773 = 7'h50 == data1Frac_13 ? $signed(8'sh29) : $signed(_GEN_1772); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1774 = 7'h51 == data1Frac_13 ? $signed(8'sh29) : $signed(_GEN_1773); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1775 = 7'h52 == data1Frac_13 ? $signed(8'sh29) : $signed(_GEN_1774); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1776 = 7'h53 == data1Frac_13 ? $signed(8'sh29) : $signed(_GEN_1775); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1777 = 7'h54 == data1Frac_13 ? $signed(8'sh29) : $signed(_GEN_1776); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1778 = 7'h55 == data1Frac_13 ? $signed(8'sh28) : $signed(_GEN_1777); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1779 = 7'h56 == data1Frac_13 ? $signed(8'sh28) : $signed(_GEN_1778); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1780 = 7'h57 == data1Frac_13 ? $signed(8'sh28) : $signed(_GEN_1779); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1781 = 7'h58 == data1Frac_13 ? $signed(8'sh28) : $signed(_GEN_1780); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1782 = 7'h59 == data1Frac_13 ? $signed(8'sh28) : $signed(_GEN_1781); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1783 = 7'h5a == data1Frac_13 ? $signed(8'sh27) : $signed(_GEN_1782); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1784 = 7'h5b == data1Frac_13 ? $signed(8'sh27) : $signed(_GEN_1783); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1785 = 7'h5c == data1Frac_13 ? $signed(8'sh27) : $signed(_GEN_1784); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1786 = 7'h5d == data1Frac_13 ? $signed(8'sh27) : $signed(_GEN_1785); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1787 = 7'h5e == data1Frac_13 ? $signed(8'sh26) : $signed(_GEN_1786); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1788 = 7'h5f == data1Frac_13 ? $signed(8'sh26) : $signed(_GEN_1787); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1789 = 7'h60 == data1Frac_13 ? $signed(8'sh26) : $signed(_GEN_1788); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1790 = 7'h61 == data1Frac_13 ? $signed(8'sh26) : $signed(_GEN_1789); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1791 = 7'h62 == data1Frac_13 ? $signed(8'sh26) : $signed(_GEN_1790); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1792 = 7'h63 == data1Frac_13 ? $signed(8'sh25) : $signed(_GEN_1791); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1793 = 7'h64 == data1Frac_13 ? $signed(8'sh25) : $signed(_GEN_1792); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1794 = 7'h65 == data1Frac_13 ? $signed(8'sh25) : $signed(_GEN_1793); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1795 = 7'h66 == data1Frac_13 ? $signed(8'sh25) : $signed(_GEN_1794); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1796 = 7'h67 == data1Frac_13 ? $signed(8'sh25) : $signed(_GEN_1795); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1797 = 7'h68 == data1Frac_13 ? $signed(8'sh24) : $signed(_GEN_1796); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1798 = 7'h69 == data1Frac_13 ? $signed(8'sh24) : $signed(_GEN_1797); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1799 = 7'h6a == data1Frac_13 ? $signed(8'sh24) : $signed(_GEN_1798); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1800 = 7'h6b == data1Frac_13 ? $signed(8'sh24) : $signed(_GEN_1799); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1801 = 7'h6c == data1Frac_13 ? $signed(8'sh24) : $signed(_GEN_1800); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1802 = 7'h6d == data1Frac_13 ? $signed(8'sh23) : $signed(_GEN_1801); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1803 = 7'h6e == data1Frac_13 ? $signed(8'sh23) : $signed(_GEN_1802); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1804 = 7'h6f == data1Frac_13 ? $signed(8'sh23) : $signed(_GEN_1803); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1805 = 7'h70 == data1Frac_13 ? $signed(8'sh23) : $signed(_GEN_1804); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1806 = 7'h71 == data1Frac_13 ? $signed(8'sh23) : $signed(_GEN_1805); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1807 = 7'h72 == data1Frac_13 ? $signed(8'sh23) : $signed(_GEN_1806); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1808 = 7'h73 == data1Frac_13 ? $signed(8'sh22) : $signed(_GEN_1807); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1809 = 7'h74 == data1Frac_13 ? $signed(8'sh22) : $signed(_GEN_1808); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1810 = 7'h75 == data1Frac_13 ? $signed(8'sh22) : $signed(_GEN_1809); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1811 = 7'h76 == data1Frac_13 ? $signed(8'sh22) : $signed(_GEN_1810); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1812 = 7'h77 == data1Frac_13 ? $signed(8'sh22) : $signed(_GEN_1811); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1813 = 7'h78 == data1Frac_13 ? $signed(8'sh21) : $signed(_GEN_1812); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1814 = 7'h79 == data1Frac_13 ? $signed(8'sh21) : $signed(_GEN_1813); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1815 = 7'h7a == data1Frac_13 ? $signed(8'sh21) : $signed(_GEN_1814); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1816 = 7'h7b == data1Frac_13 ? $signed(8'sh21) : $signed(_GEN_1815); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1817 = 7'h7c == data1Frac_13 ? $signed(8'sh21) : $signed(_GEN_1816); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1818 = 7'h7d == data1Frac_13 ? $signed(8'sh21) : $signed(_GEN_1817); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1819 = 7'h7e == data1Frac_13 ? $signed(8'sh20) : $signed(_GEN_1818); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1820 = 7'h7f == data1Frac_13 ? $signed(8'sh20) : $signed(_GEN_1819); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_41 = $signed(_GEN_1820) >>> data1Int_13; // @[exponent.scala 46:85]
  reg [7:0] data2_13; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1824 = 7'h2 == data1Frac_14 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1825 = 7'h3 == data1Frac_14 ? $signed(8'sh3f) : $signed(_GEN_1824); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1826 = 7'h4 == data1Frac_14 ? $signed(8'sh3f) : $signed(_GEN_1825); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1827 = 7'h5 == data1Frac_14 ? $signed(8'sh3e) : $signed(_GEN_1826); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1828 = 7'h6 == data1Frac_14 ? $signed(8'sh3e) : $signed(_GEN_1827); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1829 = 7'h7 == data1Frac_14 ? $signed(8'sh3e) : $signed(_GEN_1828); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1830 = 7'h8 == data1Frac_14 ? $signed(8'sh3d) : $signed(_GEN_1829); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1831 = 7'h9 == data1Frac_14 ? $signed(8'sh3d) : $signed(_GEN_1830); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1832 = 7'ha == data1Frac_14 ? $signed(8'sh3d) : $signed(_GEN_1831); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1833 = 7'hb == data1Frac_14 ? $signed(8'sh3c) : $signed(_GEN_1832); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1834 = 7'hc == data1Frac_14 ? $signed(8'sh3c) : $signed(_GEN_1833); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1835 = 7'hd == data1Frac_14 ? $signed(8'sh3c) : $signed(_GEN_1834); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1836 = 7'he == data1Frac_14 ? $signed(8'sh3b) : $signed(_GEN_1835); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1837 = 7'hf == data1Frac_14 ? $signed(8'sh3b) : $signed(_GEN_1836); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1838 = 7'h10 == data1Frac_14 ? $signed(8'sh3b) : $signed(_GEN_1837); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1839 = 7'h11 == data1Frac_14 ? $signed(8'sh3a) : $signed(_GEN_1838); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1840 = 7'h12 == data1Frac_14 ? $signed(8'sh3a) : $signed(_GEN_1839); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1841 = 7'h13 == data1Frac_14 ? $signed(8'sh3a) : $signed(_GEN_1840); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1842 = 7'h14 == data1Frac_14 ? $signed(8'sh39) : $signed(_GEN_1841); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1843 = 7'h15 == data1Frac_14 ? $signed(8'sh39) : $signed(_GEN_1842); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1844 = 7'h16 == data1Frac_14 ? $signed(8'sh39) : $signed(_GEN_1843); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1845 = 7'h17 == data1Frac_14 ? $signed(8'sh39) : $signed(_GEN_1844); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1846 = 7'h18 == data1Frac_14 ? $signed(8'sh38) : $signed(_GEN_1845); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1847 = 7'h19 == data1Frac_14 ? $signed(8'sh38) : $signed(_GEN_1846); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1848 = 7'h1a == data1Frac_14 ? $signed(8'sh38) : $signed(_GEN_1847); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1849 = 7'h1b == data1Frac_14 ? $signed(8'sh37) : $signed(_GEN_1848); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1850 = 7'h1c == data1Frac_14 ? $signed(8'sh37) : $signed(_GEN_1849); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1851 = 7'h1d == data1Frac_14 ? $signed(8'sh37) : $signed(_GEN_1850); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1852 = 7'h1e == data1Frac_14 ? $signed(8'sh36) : $signed(_GEN_1851); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1853 = 7'h1f == data1Frac_14 ? $signed(8'sh36) : $signed(_GEN_1852); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1854 = 7'h20 == data1Frac_14 ? $signed(8'sh36) : $signed(_GEN_1853); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1855 = 7'h21 == data1Frac_14 ? $signed(8'sh36) : $signed(_GEN_1854); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1856 = 7'h22 == data1Frac_14 ? $signed(8'sh35) : $signed(_GEN_1855); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1857 = 7'h23 == data1Frac_14 ? $signed(8'sh35) : $signed(_GEN_1856); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1858 = 7'h24 == data1Frac_14 ? $signed(8'sh35) : $signed(_GEN_1857); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1859 = 7'h25 == data1Frac_14 ? $signed(8'sh34) : $signed(_GEN_1858); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1860 = 7'h26 == data1Frac_14 ? $signed(8'sh34) : $signed(_GEN_1859); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1861 = 7'h27 == data1Frac_14 ? $signed(8'sh34) : $signed(_GEN_1860); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1862 = 7'h28 == data1Frac_14 ? $signed(8'sh34) : $signed(_GEN_1861); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1863 = 7'h29 == data1Frac_14 ? $signed(8'sh33) : $signed(_GEN_1862); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1864 = 7'h2a == data1Frac_14 ? $signed(8'sh33) : $signed(_GEN_1863); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1865 = 7'h2b == data1Frac_14 ? $signed(8'sh33) : $signed(_GEN_1864); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1866 = 7'h2c == data1Frac_14 ? $signed(8'sh32) : $signed(_GEN_1865); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1867 = 7'h2d == data1Frac_14 ? $signed(8'sh32) : $signed(_GEN_1866); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1868 = 7'h2e == data1Frac_14 ? $signed(8'sh32) : $signed(_GEN_1867); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1869 = 7'h2f == data1Frac_14 ? $signed(8'sh32) : $signed(_GEN_1868); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1870 = 7'h30 == data1Frac_14 ? $signed(8'sh31) : $signed(_GEN_1869); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1871 = 7'h31 == data1Frac_14 ? $signed(8'sh31) : $signed(_GEN_1870); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1872 = 7'h32 == data1Frac_14 ? $signed(8'sh31) : $signed(_GEN_1871); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1873 = 7'h33 == data1Frac_14 ? $signed(8'sh31) : $signed(_GEN_1872); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1874 = 7'h34 == data1Frac_14 ? $signed(8'sh30) : $signed(_GEN_1873); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1875 = 7'h35 == data1Frac_14 ? $signed(8'sh30) : $signed(_GEN_1874); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1876 = 7'h36 == data1Frac_14 ? $signed(8'sh30) : $signed(_GEN_1875); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1877 = 7'h37 == data1Frac_14 ? $signed(8'sh30) : $signed(_GEN_1876); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1878 = 7'h38 == data1Frac_14 ? $signed(8'sh2f) : $signed(_GEN_1877); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1879 = 7'h39 == data1Frac_14 ? $signed(8'sh2f) : $signed(_GEN_1878); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1880 = 7'h3a == data1Frac_14 ? $signed(8'sh2f) : $signed(_GEN_1879); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1881 = 7'h3b == data1Frac_14 ? $signed(8'sh2e) : $signed(_GEN_1880); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1882 = 7'h3c == data1Frac_14 ? $signed(8'sh2e) : $signed(_GEN_1881); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1883 = 7'h3d == data1Frac_14 ? $signed(8'sh2e) : $signed(_GEN_1882); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1884 = 7'h3e == data1Frac_14 ? $signed(8'sh2e) : $signed(_GEN_1883); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1885 = 7'h3f == data1Frac_14 ? $signed(8'sh2e) : $signed(_GEN_1884); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1886 = 7'h40 == data1Frac_14 ? $signed(8'sh2d) : $signed(_GEN_1885); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1887 = 7'h41 == data1Frac_14 ? $signed(8'sh2d) : $signed(_GEN_1886); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1888 = 7'h42 == data1Frac_14 ? $signed(8'sh2d) : $signed(_GEN_1887); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1889 = 7'h43 == data1Frac_14 ? $signed(8'sh2d) : $signed(_GEN_1888); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1890 = 7'h44 == data1Frac_14 ? $signed(8'sh2c) : $signed(_GEN_1889); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1891 = 7'h45 == data1Frac_14 ? $signed(8'sh2c) : $signed(_GEN_1890); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1892 = 7'h46 == data1Frac_14 ? $signed(8'sh2c) : $signed(_GEN_1891); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1893 = 7'h47 == data1Frac_14 ? $signed(8'sh2c) : $signed(_GEN_1892); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1894 = 7'h48 == data1Frac_14 ? $signed(8'sh2b) : $signed(_GEN_1893); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1895 = 7'h49 == data1Frac_14 ? $signed(8'sh2b) : $signed(_GEN_1894); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1896 = 7'h4a == data1Frac_14 ? $signed(8'sh2b) : $signed(_GEN_1895); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1897 = 7'h4b == data1Frac_14 ? $signed(8'sh2b) : $signed(_GEN_1896); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1898 = 7'h4c == data1Frac_14 ? $signed(8'sh2a) : $signed(_GEN_1897); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1899 = 7'h4d == data1Frac_14 ? $signed(8'sh2a) : $signed(_GEN_1898); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1900 = 7'h4e == data1Frac_14 ? $signed(8'sh2a) : $signed(_GEN_1899); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1901 = 7'h4f == data1Frac_14 ? $signed(8'sh2a) : $signed(_GEN_1900); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1902 = 7'h50 == data1Frac_14 ? $signed(8'sh29) : $signed(_GEN_1901); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1903 = 7'h51 == data1Frac_14 ? $signed(8'sh29) : $signed(_GEN_1902); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1904 = 7'h52 == data1Frac_14 ? $signed(8'sh29) : $signed(_GEN_1903); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1905 = 7'h53 == data1Frac_14 ? $signed(8'sh29) : $signed(_GEN_1904); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1906 = 7'h54 == data1Frac_14 ? $signed(8'sh29) : $signed(_GEN_1905); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1907 = 7'h55 == data1Frac_14 ? $signed(8'sh28) : $signed(_GEN_1906); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1908 = 7'h56 == data1Frac_14 ? $signed(8'sh28) : $signed(_GEN_1907); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1909 = 7'h57 == data1Frac_14 ? $signed(8'sh28) : $signed(_GEN_1908); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1910 = 7'h58 == data1Frac_14 ? $signed(8'sh28) : $signed(_GEN_1909); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1911 = 7'h59 == data1Frac_14 ? $signed(8'sh28) : $signed(_GEN_1910); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1912 = 7'h5a == data1Frac_14 ? $signed(8'sh27) : $signed(_GEN_1911); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1913 = 7'h5b == data1Frac_14 ? $signed(8'sh27) : $signed(_GEN_1912); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1914 = 7'h5c == data1Frac_14 ? $signed(8'sh27) : $signed(_GEN_1913); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1915 = 7'h5d == data1Frac_14 ? $signed(8'sh27) : $signed(_GEN_1914); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1916 = 7'h5e == data1Frac_14 ? $signed(8'sh26) : $signed(_GEN_1915); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1917 = 7'h5f == data1Frac_14 ? $signed(8'sh26) : $signed(_GEN_1916); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1918 = 7'h60 == data1Frac_14 ? $signed(8'sh26) : $signed(_GEN_1917); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1919 = 7'h61 == data1Frac_14 ? $signed(8'sh26) : $signed(_GEN_1918); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1920 = 7'h62 == data1Frac_14 ? $signed(8'sh26) : $signed(_GEN_1919); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1921 = 7'h63 == data1Frac_14 ? $signed(8'sh25) : $signed(_GEN_1920); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1922 = 7'h64 == data1Frac_14 ? $signed(8'sh25) : $signed(_GEN_1921); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1923 = 7'h65 == data1Frac_14 ? $signed(8'sh25) : $signed(_GEN_1922); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1924 = 7'h66 == data1Frac_14 ? $signed(8'sh25) : $signed(_GEN_1923); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1925 = 7'h67 == data1Frac_14 ? $signed(8'sh25) : $signed(_GEN_1924); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1926 = 7'h68 == data1Frac_14 ? $signed(8'sh24) : $signed(_GEN_1925); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1927 = 7'h69 == data1Frac_14 ? $signed(8'sh24) : $signed(_GEN_1926); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1928 = 7'h6a == data1Frac_14 ? $signed(8'sh24) : $signed(_GEN_1927); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1929 = 7'h6b == data1Frac_14 ? $signed(8'sh24) : $signed(_GEN_1928); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1930 = 7'h6c == data1Frac_14 ? $signed(8'sh24) : $signed(_GEN_1929); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1931 = 7'h6d == data1Frac_14 ? $signed(8'sh23) : $signed(_GEN_1930); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1932 = 7'h6e == data1Frac_14 ? $signed(8'sh23) : $signed(_GEN_1931); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1933 = 7'h6f == data1Frac_14 ? $signed(8'sh23) : $signed(_GEN_1932); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1934 = 7'h70 == data1Frac_14 ? $signed(8'sh23) : $signed(_GEN_1933); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1935 = 7'h71 == data1Frac_14 ? $signed(8'sh23) : $signed(_GEN_1934); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1936 = 7'h72 == data1Frac_14 ? $signed(8'sh23) : $signed(_GEN_1935); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1937 = 7'h73 == data1Frac_14 ? $signed(8'sh22) : $signed(_GEN_1936); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1938 = 7'h74 == data1Frac_14 ? $signed(8'sh22) : $signed(_GEN_1937); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1939 = 7'h75 == data1Frac_14 ? $signed(8'sh22) : $signed(_GEN_1938); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1940 = 7'h76 == data1Frac_14 ? $signed(8'sh22) : $signed(_GEN_1939); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1941 = 7'h77 == data1Frac_14 ? $signed(8'sh22) : $signed(_GEN_1940); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1942 = 7'h78 == data1Frac_14 ? $signed(8'sh21) : $signed(_GEN_1941); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1943 = 7'h79 == data1Frac_14 ? $signed(8'sh21) : $signed(_GEN_1942); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1944 = 7'h7a == data1Frac_14 ? $signed(8'sh21) : $signed(_GEN_1943); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1945 = 7'h7b == data1Frac_14 ? $signed(8'sh21) : $signed(_GEN_1944); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1946 = 7'h7c == data1Frac_14 ? $signed(8'sh21) : $signed(_GEN_1945); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1947 = 7'h7d == data1Frac_14 ? $signed(8'sh21) : $signed(_GEN_1946); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1948 = 7'h7e == data1Frac_14 ? $signed(8'sh20) : $signed(_GEN_1947); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1949 = 7'h7f == data1Frac_14 ? $signed(8'sh20) : $signed(_GEN_1948); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_44 = $signed(_GEN_1949) >>> data1Int_14; // @[exponent.scala 46:85]
  reg [7:0] data2_14; // @[Reg.scala 16:16]
  wire [7:0] _GEN_1953 = 7'h2 == data1Frac_15 ? $signed(8'sh3f) : $signed(8'sh40); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1954 = 7'h3 == data1Frac_15 ? $signed(8'sh3f) : $signed(_GEN_1953); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1955 = 7'h4 == data1Frac_15 ? $signed(8'sh3f) : $signed(_GEN_1954); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1956 = 7'h5 == data1Frac_15 ? $signed(8'sh3e) : $signed(_GEN_1955); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1957 = 7'h6 == data1Frac_15 ? $signed(8'sh3e) : $signed(_GEN_1956); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1958 = 7'h7 == data1Frac_15 ? $signed(8'sh3e) : $signed(_GEN_1957); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1959 = 7'h8 == data1Frac_15 ? $signed(8'sh3d) : $signed(_GEN_1958); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1960 = 7'h9 == data1Frac_15 ? $signed(8'sh3d) : $signed(_GEN_1959); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1961 = 7'ha == data1Frac_15 ? $signed(8'sh3d) : $signed(_GEN_1960); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1962 = 7'hb == data1Frac_15 ? $signed(8'sh3c) : $signed(_GEN_1961); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1963 = 7'hc == data1Frac_15 ? $signed(8'sh3c) : $signed(_GEN_1962); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1964 = 7'hd == data1Frac_15 ? $signed(8'sh3c) : $signed(_GEN_1963); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1965 = 7'he == data1Frac_15 ? $signed(8'sh3b) : $signed(_GEN_1964); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1966 = 7'hf == data1Frac_15 ? $signed(8'sh3b) : $signed(_GEN_1965); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1967 = 7'h10 == data1Frac_15 ? $signed(8'sh3b) : $signed(_GEN_1966); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1968 = 7'h11 == data1Frac_15 ? $signed(8'sh3a) : $signed(_GEN_1967); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1969 = 7'h12 == data1Frac_15 ? $signed(8'sh3a) : $signed(_GEN_1968); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1970 = 7'h13 == data1Frac_15 ? $signed(8'sh3a) : $signed(_GEN_1969); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1971 = 7'h14 == data1Frac_15 ? $signed(8'sh39) : $signed(_GEN_1970); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1972 = 7'h15 == data1Frac_15 ? $signed(8'sh39) : $signed(_GEN_1971); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1973 = 7'h16 == data1Frac_15 ? $signed(8'sh39) : $signed(_GEN_1972); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1974 = 7'h17 == data1Frac_15 ? $signed(8'sh39) : $signed(_GEN_1973); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1975 = 7'h18 == data1Frac_15 ? $signed(8'sh38) : $signed(_GEN_1974); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1976 = 7'h19 == data1Frac_15 ? $signed(8'sh38) : $signed(_GEN_1975); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1977 = 7'h1a == data1Frac_15 ? $signed(8'sh38) : $signed(_GEN_1976); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1978 = 7'h1b == data1Frac_15 ? $signed(8'sh37) : $signed(_GEN_1977); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1979 = 7'h1c == data1Frac_15 ? $signed(8'sh37) : $signed(_GEN_1978); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1980 = 7'h1d == data1Frac_15 ? $signed(8'sh37) : $signed(_GEN_1979); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1981 = 7'h1e == data1Frac_15 ? $signed(8'sh36) : $signed(_GEN_1980); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1982 = 7'h1f == data1Frac_15 ? $signed(8'sh36) : $signed(_GEN_1981); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1983 = 7'h20 == data1Frac_15 ? $signed(8'sh36) : $signed(_GEN_1982); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1984 = 7'h21 == data1Frac_15 ? $signed(8'sh36) : $signed(_GEN_1983); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1985 = 7'h22 == data1Frac_15 ? $signed(8'sh35) : $signed(_GEN_1984); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1986 = 7'h23 == data1Frac_15 ? $signed(8'sh35) : $signed(_GEN_1985); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1987 = 7'h24 == data1Frac_15 ? $signed(8'sh35) : $signed(_GEN_1986); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1988 = 7'h25 == data1Frac_15 ? $signed(8'sh34) : $signed(_GEN_1987); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1989 = 7'h26 == data1Frac_15 ? $signed(8'sh34) : $signed(_GEN_1988); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1990 = 7'h27 == data1Frac_15 ? $signed(8'sh34) : $signed(_GEN_1989); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1991 = 7'h28 == data1Frac_15 ? $signed(8'sh34) : $signed(_GEN_1990); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1992 = 7'h29 == data1Frac_15 ? $signed(8'sh33) : $signed(_GEN_1991); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1993 = 7'h2a == data1Frac_15 ? $signed(8'sh33) : $signed(_GEN_1992); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1994 = 7'h2b == data1Frac_15 ? $signed(8'sh33) : $signed(_GEN_1993); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1995 = 7'h2c == data1Frac_15 ? $signed(8'sh32) : $signed(_GEN_1994); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1996 = 7'h2d == data1Frac_15 ? $signed(8'sh32) : $signed(_GEN_1995); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1997 = 7'h2e == data1Frac_15 ? $signed(8'sh32) : $signed(_GEN_1996); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1998 = 7'h2f == data1Frac_15 ? $signed(8'sh32) : $signed(_GEN_1997); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_1999 = 7'h30 == data1Frac_15 ? $signed(8'sh31) : $signed(_GEN_1998); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2000 = 7'h31 == data1Frac_15 ? $signed(8'sh31) : $signed(_GEN_1999); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2001 = 7'h32 == data1Frac_15 ? $signed(8'sh31) : $signed(_GEN_2000); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2002 = 7'h33 == data1Frac_15 ? $signed(8'sh31) : $signed(_GEN_2001); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2003 = 7'h34 == data1Frac_15 ? $signed(8'sh30) : $signed(_GEN_2002); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2004 = 7'h35 == data1Frac_15 ? $signed(8'sh30) : $signed(_GEN_2003); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2005 = 7'h36 == data1Frac_15 ? $signed(8'sh30) : $signed(_GEN_2004); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2006 = 7'h37 == data1Frac_15 ? $signed(8'sh30) : $signed(_GEN_2005); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2007 = 7'h38 == data1Frac_15 ? $signed(8'sh2f) : $signed(_GEN_2006); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2008 = 7'h39 == data1Frac_15 ? $signed(8'sh2f) : $signed(_GEN_2007); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2009 = 7'h3a == data1Frac_15 ? $signed(8'sh2f) : $signed(_GEN_2008); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2010 = 7'h3b == data1Frac_15 ? $signed(8'sh2e) : $signed(_GEN_2009); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2011 = 7'h3c == data1Frac_15 ? $signed(8'sh2e) : $signed(_GEN_2010); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2012 = 7'h3d == data1Frac_15 ? $signed(8'sh2e) : $signed(_GEN_2011); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2013 = 7'h3e == data1Frac_15 ? $signed(8'sh2e) : $signed(_GEN_2012); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2014 = 7'h3f == data1Frac_15 ? $signed(8'sh2e) : $signed(_GEN_2013); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2015 = 7'h40 == data1Frac_15 ? $signed(8'sh2d) : $signed(_GEN_2014); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2016 = 7'h41 == data1Frac_15 ? $signed(8'sh2d) : $signed(_GEN_2015); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2017 = 7'h42 == data1Frac_15 ? $signed(8'sh2d) : $signed(_GEN_2016); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2018 = 7'h43 == data1Frac_15 ? $signed(8'sh2d) : $signed(_GEN_2017); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2019 = 7'h44 == data1Frac_15 ? $signed(8'sh2c) : $signed(_GEN_2018); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2020 = 7'h45 == data1Frac_15 ? $signed(8'sh2c) : $signed(_GEN_2019); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2021 = 7'h46 == data1Frac_15 ? $signed(8'sh2c) : $signed(_GEN_2020); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2022 = 7'h47 == data1Frac_15 ? $signed(8'sh2c) : $signed(_GEN_2021); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2023 = 7'h48 == data1Frac_15 ? $signed(8'sh2b) : $signed(_GEN_2022); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2024 = 7'h49 == data1Frac_15 ? $signed(8'sh2b) : $signed(_GEN_2023); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2025 = 7'h4a == data1Frac_15 ? $signed(8'sh2b) : $signed(_GEN_2024); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2026 = 7'h4b == data1Frac_15 ? $signed(8'sh2b) : $signed(_GEN_2025); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2027 = 7'h4c == data1Frac_15 ? $signed(8'sh2a) : $signed(_GEN_2026); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2028 = 7'h4d == data1Frac_15 ? $signed(8'sh2a) : $signed(_GEN_2027); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2029 = 7'h4e == data1Frac_15 ? $signed(8'sh2a) : $signed(_GEN_2028); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2030 = 7'h4f == data1Frac_15 ? $signed(8'sh2a) : $signed(_GEN_2029); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2031 = 7'h50 == data1Frac_15 ? $signed(8'sh29) : $signed(_GEN_2030); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2032 = 7'h51 == data1Frac_15 ? $signed(8'sh29) : $signed(_GEN_2031); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2033 = 7'h52 == data1Frac_15 ? $signed(8'sh29) : $signed(_GEN_2032); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2034 = 7'h53 == data1Frac_15 ? $signed(8'sh29) : $signed(_GEN_2033); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2035 = 7'h54 == data1Frac_15 ? $signed(8'sh29) : $signed(_GEN_2034); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2036 = 7'h55 == data1Frac_15 ? $signed(8'sh28) : $signed(_GEN_2035); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2037 = 7'h56 == data1Frac_15 ? $signed(8'sh28) : $signed(_GEN_2036); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2038 = 7'h57 == data1Frac_15 ? $signed(8'sh28) : $signed(_GEN_2037); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2039 = 7'h58 == data1Frac_15 ? $signed(8'sh28) : $signed(_GEN_2038); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2040 = 7'h59 == data1Frac_15 ? $signed(8'sh28) : $signed(_GEN_2039); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2041 = 7'h5a == data1Frac_15 ? $signed(8'sh27) : $signed(_GEN_2040); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2042 = 7'h5b == data1Frac_15 ? $signed(8'sh27) : $signed(_GEN_2041); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2043 = 7'h5c == data1Frac_15 ? $signed(8'sh27) : $signed(_GEN_2042); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2044 = 7'h5d == data1Frac_15 ? $signed(8'sh27) : $signed(_GEN_2043); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2045 = 7'h5e == data1Frac_15 ? $signed(8'sh26) : $signed(_GEN_2044); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2046 = 7'h5f == data1Frac_15 ? $signed(8'sh26) : $signed(_GEN_2045); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2047 = 7'h60 == data1Frac_15 ? $signed(8'sh26) : $signed(_GEN_2046); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2048 = 7'h61 == data1Frac_15 ? $signed(8'sh26) : $signed(_GEN_2047); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2049 = 7'h62 == data1Frac_15 ? $signed(8'sh26) : $signed(_GEN_2048); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2050 = 7'h63 == data1Frac_15 ? $signed(8'sh25) : $signed(_GEN_2049); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2051 = 7'h64 == data1Frac_15 ? $signed(8'sh25) : $signed(_GEN_2050); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2052 = 7'h65 == data1Frac_15 ? $signed(8'sh25) : $signed(_GEN_2051); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2053 = 7'h66 == data1Frac_15 ? $signed(8'sh25) : $signed(_GEN_2052); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2054 = 7'h67 == data1Frac_15 ? $signed(8'sh25) : $signed(_GEN_2053); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2055 = 7'h68 == data1Frac_15 ? $signed(8'sh24) : $signed(_GEN_2054); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2056 = 7'h69 == data1Frac_15 ? $signed(8'sh24) : $signed(_GEN_2055); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2057 = 7'h6a == data1Frac_15 ? $signed(8'sh24) : $signed(_GEN_2056); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2058 = 7'h6b == data1Frac_15 ? $signed(8'sh24) : $signed(_GEN_2057); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2059 = 7'h6c == data1Frac_15 ? $signed(8'sh24) : $signed(_GEN_2058); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2060 = 7'h6d == data1Frac_15 ? $signed(8'sh23) : $signed(_GEN_2059); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2061 = 7'h6e == data1Frac_15 ? $signed(8'sh23) : $signed(_GEN_2060); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2062 = 7'h6f == data1Frac_15 ? $signed(8'sh23) : $signed(_GEN_2061); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2063 = 7'h70 == data1Frac_15 ? $signed(8'sh23) : $signed(_GEN_2062); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2064 = 7'h71 == data1Frac_15 ? $signed(8'sh23) : $signed(_GEN_2063); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2065 = 7'h72 == data1Frac_15 ? $signed(8'sh23) : $signed(_GEN_2064); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2066 = 7'h73 == data1Frac_15 ? $signed(8'sh22) : $signed(_GEN_2065); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2067 = 7'h74 == data1Frac_15 ? $signed(8'sh22) : $signed(_GEN_2066); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2068 = 7'h75 == data1Frac_15 ? $signed(8'sh22) : $signed(_GEN_2067); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2069 = 7'h76 == data1Frac_15 ? $signed(8'sh22) : $signed(_GEN_2068); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2070 = 7'h77 == data1Frac_15 ? $signed(8'sh22) : $signed(_GEN_2069); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2071 = 7'h78 == data1Frac_15 ? $signed(8'sh21) : $signed(_GEN_2070); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2072 = 7'h79 == data1Frac_15 ? $signed(8'sh21) : $signed(_GEN_2071); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2073 = 7'h7a == data1Frac_15 ? $signed(8'sh21) : $signed(_GEN_2072); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2074 = 7'h7b == data1Frac_15 ? $signed(8'sh21) : $signed(_GEN_2073); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2075 = 7'h7c == data1Frac_15 ? $signed(8'sh21) : $signed(_GEN_2074); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2076 = 7'h7d == data1Frac_15 ? $signed(8'sh21) : $signed(_GEN_2075); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2077 = 7'h7e == data1Frac_15 ? $signed(8'sh20) : $signed(_GEN_2076); // @[exponent.scala 46:{47,47}]
  wire [7:0] _GEN_2078 = 7'h7f == data1Frac_15 ? $signed(8'sh20) : $signed(_GEN_2077); // @[exponent.scala 46:{47,47}]
  wire [7:0] _data2_T_47 = $signed(_GEN_2078) >>> data1Int_15; // @[exponent.scala 46:85]
  reg [7:0] data2_15; // @[Reg.scala 16:16]
  PipelineHandshake hsk ( // @[exponent.scala 27:21]
    .clock(hsk_clock),
    .validPre(hsk_validPre),
    .readyPre(hsk_readyPre),
    .lastPre(hsk_lastPre),
    .validNxt(hsk_validNxt),
    .readyNxt(hsk_readyNxt),
    .regen_0(hsk_regen_0),
    .regen_1(hsk_regen_1),
    .lastNxt(hsk_lastNxt),
    .rst(hsk_rst)
  );
  assign io_input_ready = hsk_readyPre; // @[exponent.scala 29:20]
  assign io_output_valid = hsk_validNxt; // @[exponent.scala 31:21]
  assign io_output_bits_out_0 = data2_0; // @[exponent.scala 48:24]
  assign io_output_bits_out_1 = data2_1; // @[exponent.scala 48:24]
  assign io_output_bits_out_2 = data2_2; // @[exponent.scala 48:24]
  assign io_output_bits_out_3 = data2_3; // @[exponent.scala 48:24]
  assign io_output_bits_out_4 = data2_4; // @[exponent.scala 48:24]
  assign io_output_bits_out_5 = data2_5; // @[exponent.scala 48:24]
  assign io_output_bits_out_6 = data2_6; // @[exponent.scala 48:24]
  assign io_output_bits_out_7 = data2_7; // @[exponent.scala 48:24]
  assign io_output_bits_out_8 = data2_8; // @[exponent.scala 48:24]
  assign io_output_bits_out_9 = data2_9; // @[exponent.scala 48:24]
  assign io_output_bits_out_10 = data2_10; // @[exponent.scala 48:24]
  assign io_output_bits_out_11 = data2_11; // @[exponent.scala 48:24]
  assign io_output_bits_out_12 = data2_12; // @[exponent.scala 48:24]
  assign io_output_bits_out_13 = data2_13; // @[exponent.scala 48:24]
  assign io_output_bits_out_14 = data2_14; // @[exponent.scala 48:24]
  assign io_output_bits_out_15 = data2_15; // @[exponent.scala 48:24]
  assign io_output_bits_last = hsk_lastNxt; // @[exponent.scala 33:25]
  assign hsk_clock = clock;
  assign hsk_validPre = io_input_valid; // @[exponent.scala 28:18]
  assign hsk_lastPre = io_input_bits_last; // @[exponent.scala 30:17]
  assign hsk_readyNxt = io_output_ready; // @[exponent.scala 32:18]
  assign hsk_rst = rst; // @[exponent.scala 34:13]
  always @(posedge clock) begin
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_0 <= _data1_T; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_1 <= _data1_T_1; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_2 <= _data1_T_2; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_3 <= _data1_T_3; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_4 <= _data1_T_4; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_5 <= _data1_T_5; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_6 <= _data1_T_6; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_7 <= _data1_T_7; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_8 <= _data1_T_8; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_9 <= _data1_T_9; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_10 <= _data1_T_10; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_11 <= _data1_T_11; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_12 <= _data1_T_12; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_13 <= _data1_T_13; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_14 <= _data1_T_14; // @[Reg.scala 17:22]
    end
    if (hsk_regen_0) begin // @[Reg.scala 17:18]
      data1_15 <= _data1_T_15; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_0 <= _data2_T_2; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_1 <= _data2_T_5; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_2 <= _data2_T_8; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_3 <= _data2_T_11; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_4 <= _data2_T_14; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_5 <= _data2_T_17; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_6 <= _data2_T_20; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_7 <= _data2_T_23; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_8 <= _data2_T_26; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_9 <= _data2_T_29; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_10 <= _data2_T_32; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_11 <= _data2_T_35; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_12 <= _data2_T_38; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_13 <= _data2_T_41; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_14 <= _data2_T_44; // @[Reg.scala 17:22]
    end
    if (hsk_regen_1) begin // @[Reg.scala 17:18]
      data2_15 <= _data2_T_47; // @[Reg.scala 17:22]
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
  data1_0 = _RAND_0[12:0];
  _RAND_1 = {1{`RANDOM}};
  data1_1 = _RAND_1[12:0];
  _RAND_2 = {1{`RANDOM}};
  data1_2 = _RAND_2[12:0];
  _RAND_3 = {1{`RANDOM}};
  data1_3 = _RAND_3[12:0];
  _RAND_4 = {1{`RANDOM}};
  data1_4 = _RAND_4[12:0];
  _RAND_5 = {1{`RANDOM}};
  data1_5 = _RAND_5[12:0];
  _RAND_6 = {1{`RANDOM}};
  data1_6 = _RAND_6[12:0];
  _RAND_7 = {1{`RANDOM}};
  data1_7 = _RAND_7[12:0];
  _RAND_8 = {1{`RANDOM}};
  data1_8 = _RAND_8[12:0];
  _RAND_9 = {1{`RANDOM}};
  data1_9 = _RAND_9[12:0];
  _RAND_10 = {1{`RANDOM}};
  data1_10 = _RAND_10[12:0];
  _RAND_11 = {1{`RANDOM}};
  data1_11 = _RAND_11[12:0];
  _RAND_12 = {1{`RANDOM}};
  data1_12 = _RAND_12[12:0];
  _RAND_13 = {1{`RANDOM}};
  data1_13 = _RAND_13[12:0];
  _RAND_14 = {1{`RANDOM}};
  data1_14 = _RAND_14[12:0];
  _RAND_15 = {1{`RANDOM}};
  data1_15 = _RAND_15[12:0];
  _RAND_16 = {1{`RANDOM}};
  data2_0 = _RAND_16[7:0];
  _RAND_17 = {1{`RANDOM}};
  data2_1 = _RAND_17[7:0];
  _RAND_18 = {1{`RANDOM}};
  data2_2 = _RAND_18[7:0];
  _RAND_19 = {1{`RANDOM}};
  data2_3 = _RAND_19[7:0];
  _RAND_20 = {1{`RANDOM}};
  data2_4 = _RAND_20[7:0];
  _RAND_21 = {1{`RANDOM}};
  data2_5 = _RAND_21[7:0];
  _RAND_22 = {1{`RANDOM}};
  data2_6 = _RAND_22[7:0];
  _RAND_23 = {1{`RANDOM}};
  data2_7 = _RAND_23[7:0];
  _RAND_24 = {1{`RANDOM}};
  data2_8 = _RAND_24[7:0];
  _RAND_25 = {1{`RANDOM}};
  data2_9 = _RAND_25[7:0];
  _RAND_26 = {1{`RANDOM}};
  data2_10 = _RAND_26[7:0];
  _RAND_27 = {1{`RANDOM}};
  data2_11 = _RAND_27[7:0];
  _RAND_28 = {1{`RANDOM}};
  data2_12 = _RAND_28[7:0];
  _RAND_29 = {1{`RANDOM}};
  data2_13 = _RAND_29[7:0];
  _RAND_30 = {1{`RANDOM}};
  data2_14 = _RAND_30[7:0];
  _RAND_31 = {1{`RANDOM}};
  data2_15 = _RAND_31[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Hsk1ton(
  input        io_input_valid,
  input  [7:0] io_input_bits_0_in_0,
  input  [7:0] io_input_bits_0_in_1,
  input  [7:0] io_input_bits_0_in_2,
  input  [7:0] io_input_bits_0_in_3,
  input  [7:0] io_input_bits_0_in_4,
  input  [7:0] io_input_bits_0_in_5,
  input  [7:0] io_input_bits_0_in_6,
  input  [7:0] io_input_bits_0_in_7,
  input  [7:0] io_input_bits_0_in_8,
  input  [7:0] io_input_bits_0_in_9,
  input  [7:0] io_input_bits_0_in_10,
  input  [7:0] io_input_bits_0_in_11,
  input  [7:0] io_input_bits_0_in_12,
  input  [7:0] io_input_bits_0_in_13,
  input  [7:0] io_input_bits_0_in_14,
  input  [7:0] io_input_bits_0_in_15,
  input        io_input_bits_0_last,
  output       io_output_0_valid,
  output [7:0] io_output_0_bits_in_0,
  output [7:0] io_output_0_bits_in_1,
  output [7:0] io_output_0_bits_in_2,
  output [7:0] io_output_0_bits_in_3,
  output [7:0] io_output_0_bits_in_4,
  output [7:0] io_output_0_bits_in_5,
  output [7:0] io_output_0_bits_in_6,
  output [7:0] io_output_0_bits_in_7,
  output [7:0] io_output_0_bits_in_8,
  output [7:0] io_output_0_bits_in_9,
  output [7:0] io_output_0_bits_in_10,
  output [7:0] io_output_0_bits_in_11,
  output [7:0] io_output_0_bits_in_12,
  output [7:0] io_output_0_bits_in_13,
  output [7:0] io_output_0_bits_in_14,
  output [7:0] io_output_0_bits_in_15,
  output       io_output_0_bits_last
);
  assign io_output_0_valid = io_input_valid; // @[hsk1ton.scala 14:72]
  assign io_output_0_bits_in_0 = io_input_bits_0_in_0; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_1 = io_input_bits_0_in_1; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_2 = io_input_bits_0_in_2; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_3 = io_input_bits_0_in_3; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_4 = io_input_bits_0_in_4; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_5 = io_input_bits_0_in_5; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_6 = io_input_bits_0_in_6; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_7 = io_input_bits_0_in_7; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_8 = io_input_bits_0_in_8; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_9 = io_input_bits_0_in_9; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_10 = io_input_bits_0_in_10; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_11 = io_input_bits_0_in_11; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_12 = io_input_bits_0_in_12; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_13 = io_input_bits_0_in_13; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_14 = io_input_bits_0_in_14; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_in_15 = io_input_bits_0_in_15; // @[hsk1ton.scala 13:54]
  assign io_output_0_bits_last = io_input_bits_0_last; // @[hsk1ton.scala 13:54]
endmodule
module Arbiternto1(
  input        io_input_0_valid,
  input  [7:0] io_input_0_bits_in_0,
  input  [7:0] io_input_0_bits_in_1,
  input  [7:0] io_input_0_bits_in_2,
  input  [7:0] io_input_0_bits_in_3,
  input  [7:0] io_input_0_bits_in_4,
  input  [7:0] io_input_0_bits_in_5,
  input  [7:0] io_input_0_bits_in_6,
  input  [7:0] io_input_0_bits_in_7,
  input  [7:0] io_input_0_bits_in_8,
  input  [7:0] io_input_0_bits_in_9,
  input  [7:0] io_input_0_bits_in_10,
  input  [7:0] io_input_0_bits_in_11,
  input  [7:0] io_input_0_bits_in_12,
  input  [7:0] io_input_0_bits_in_13,
  input  [7:0] io_input_0_bits_in_14,
  input  [7:0] io_input_0_bits_in_15,
  input        io_input_0_bits_last,
  input  [1:0] io_sel,
  output       io_output_valid,
  output [7:0] io_output_bits_in_0,
  output [7:0] io_output_bits_in_1,
  output [7:0] io_output_bits_in_2,
  output [7:0] io_output_bits_in_3,
  output [7:0] io_output_bits_in_4,
  output [7:0] io_output_bits_in_5,
  output [7:0] io_output_bits_in_6,
  output [7:0] io_output_bits_in_7,
  output [7:0] io_output_bits_in_8,
  output [7:0] io_output_bits_in_9,
  output [7:0] io_output_bits_in_10,
  output [7:0] io_output_bits_in_11,
  output [7:0] io_output_bits_in_12,
  output [7:0] io_output_bits_in_13,
  output [7:0] io_output_bits_in_14,
  output [7:0] io_output_bits_in_15,
  output       io_output_bits_last
);
  assign io_output_valid = io_sel[0] ? 1'h0 : io_input_0_valid; // @[arbiternto1.scala 19:{21,21}]
  assign io_output_bits_in_0 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_0); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_1 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_1); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_2 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_2); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_3 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_3); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_4 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_4); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_5 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_5); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_6 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_6); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_7 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_7); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_8 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_8); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_9 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_9); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_10 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_10); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_11 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_11); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_12 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_12); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_13 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_13); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_14 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_14); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_in_15 = io_sel[0] ? $signed(8'sh0) : $signed(io_input_0_bits_in_15); // @[arbiternto1.scala 18:{20,20}]
  assign io_output_bits_last = io_sel[0] ? 1'h0 : io_input_0_bits_last; // @[arbiternto1.scala 18:{20,20}]
endmodule
module Arbiter1ton(
  output       io_input_ready,
  input  [7:0] io_input_bits_out_0,
  input  [7:0] io_input_bits_out_1,
  input  [7:0] io_input_bits_out_2,
  input  [7:0] io_input_bits_out_3,
  input  [7:0] io_input_bits_out_4,
  input  [7:0] io_input_bits_out_5,
  input  [7:0] io_input_bits_out_6,
  input  [7:0] io_input_bits_out_7,
  input  [7:0] io_input_bits_out_8,
  input  [7:0] io_input_bits_out_9,
  input  [7:0] io_input_bits_out_10,
  input  [7:0] io_input_bits_out_11,
  input  [7:0] io_input_bits_out_12,
  input  [7:0] io_input_bits_out_13,
  input  [7:0] io_input_bits_out_14,
  input  [7:0] io_input_bits_out_15,
  input        io_input_bits_last,
  input        io_sel,
  output       io_output_0_bits_last,
  input        io_output_1_ready,
  output [7:0] io_output_1_bits_out_0,
  output [7:0] io_output_1_bits_out_1,
  output [7:0] io_output_1_bits_out_2,
  output [7:0] io_output_1_bits_out_3,
  output [7:0] io_output_1_bits_out_4,
  output [7:0] io_output_1_bits_out_5,
  output [7:0] io_output_1_bits_out_6,
  output [7:0] io_output_1_bits_out_7,
  output [7:0] io_output_1_bits_out_8,
  output [7:0] io_output_1_bits_out_9,
  output [7:0] io_output_1_bits_out_10,
  output [7:0] io_output_1_bits_out_11,
  output [7:0] io_output_1_bits_out_12,
  output [7:0] io_output_1_bits_out_13,
  output [7:0] io_output_1_bits_out_14,
  output [7:0] io_output_1_bits_out_15,
  output       io_output_1_bits_last
);
  assign io_input_ready = io_sel ? io_output_1_ready : 1'h1; // @[arbiter1ton.scala 16:{20,20}]
  assign io_output_0_bits_last = io_input_bits_last; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_0 = io_input_bits_out_0; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_1 = io_input_bits_out_1; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_2 = io_input_bits_out_2; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_3 = io_input_bits_out_3; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_4 = io_input_bits_out_4; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_5 = io_input_bits_out_5; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_6 = io_input_bits_out_6; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_7 = io_input_bits_out_7; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_8 = io_input_bits_out_8; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_9 = io_input_bits_out_9; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_10 = io_input_bits_out_10; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_11 = io_input_bits_out_11; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_12 = io_input_bits_out_12; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_13 = io_input_bits_out_13; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_14 = io_input_bits_out_14; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_out_15 = io_input_bits_out_15; // @[arbiter1ton.scala 19:26]
  assign io_output_1_bits_last = io_input_bits_last; // @[arbiter1ton.scala 19:26]
endmodule
module AdderTree(
  input   clock,
  input   io_input_bits_last,
  input   rst
);
  wire  hsk_clock; // @[addertree.scala 39:21]
  wire  hsk_validPre; // @[addertree.scala 39:21]
  wire  hsk_readyPre; // @[addertree.scala 39:21]
  wire  hsk_lastPre; // @[addertree.scala 39:21]
  wire  hsk_validNxt; // @[addertree.scala 39:21]
  wire  hsk_readyNxt; // @[addertree.scala 39:21]
  wire  hsk_regen_0; // @[addertree.scala 39:21]
  wire  hsk_regen_1; // @[addertree.scala 39:21]
  wire  hsk_lastNxt; // @[addertree.scala 39:21]
  wire  hsk_rst; // @[addertree.scala 39:21]
  PipelineHandshake hsk ( // @[addertree.scala 39:21]
    .clock(hsk_clock),
    .validPre(hsk_validPre),
    .readyPre(hsk_readyPre),
    .lastPre(hsk_lastPre),
    .validNxt(hsk_validNxt),
    .readyNxt(hsk_readyNxt),
    .regen_0(hsk_regen_0),
    .regen_1(hsk_regen_1),
    .lastNxt(hsk_lastNxt),
    .rst(hsk_rst)
  );
  assign hsk_clock = clock;
  assign hsk_validPre = 1'h0; // @[addertree.scala 40:18]
  assign hsk_lastPre = io_input_bits_last; // @[addertree.scala 42:17]
  assign hsk_readyNxt = 1'h1; // @[addertree.scala 44:18]
  assign hsk_rst = rst; // @[addertree.scala 46:13]
endmodule
module Softmax(
  input        clock,
  input        reset,
  output       io_input_ready,
  input        io_input_valid,
  input  [7:0] io_input_bits_in_0,
  input  [7:0] io_input_bits_in_1,
  input  [7:0] io_input_bits_in_2,
  input  [7:0] io_input_bits_in_3,
  input  [7:0] io_input_bits_in_4,
  input  [7:0] io_input_bits_in_5,
  input  [7:0] io_input_bits_in_6,
  input  [7:0] io_input_bits_in_7,
  input  [7:0] io_input_bits_in_8,
  input  [7:0] io_input_bits_in_9,
  input  [7:0] io_input_bits_in_10,
  input  [7:0] io_input_bits_in_11,
  input  [7:0] io_input_bits_in_12,
  input  [7:0] io_input_bits_in_13,
  input  [7:0] io_input_bits_in_14,
  input  [7:0] io_input_bits_in_15,
  input        io_input_bits_last,
  input        io_output_ready,
  output       io_output_valid,
  output [7:0] io_output_bits_out_0,
  output [7:0] io_output_bits_out_1,
  output [7:0] io_output_bits_out_2,
  output [7:0] io_output_bits_out_3,
  output [7:0] io_output_bits_out_4,
  output [7:0] io_output_bits_out_5,
  output [7:0] io_output_bits_out_6,
  output [7:0] io_output_bits_out_7,
  output [7:0] io_output_bits_out_8,
  output [7:0] io_output_bits_out_9,
  output [7:0] io_output_bits_out_10,
  output [7:0] io_output_bits_out_11,
  output [7:0] io_output_bits_out_12,
  output [7:0] io_output_bits_out_13,
  output [7:0] io_output_bits_out_14,
  output [7:0] io_output_bits_out_15,
  output       io_output_bits_last,
  input        rst
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
`endif // RANDOMIZE_REG_INIT
  wire  exponentArray_clock; // @[softmax.scala 43:35]
  wire  exponentArray_io_input_ready; // @[softmax.scala 43:35]
  wire  exponentArray_io_input_valid; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_0; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_1; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_2; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_3; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_4; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_5; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_6; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_7; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_8; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_9; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_10; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_11; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_12; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_13; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_14; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_input_bits_in_15; // @[softmax.scala 43:35]
  wire  exponentArray_io_input_bits_last; // @[softmax.scala 43:35]
  wire  exponentArray_io_output_ready; // @[softmax.scala 43:35]
  wire  exponentArray_io_output_valid; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_0; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_1; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_2; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_3; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_4; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_5; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_6; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_7; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_8; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_9; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_10; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_11; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_12; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_13; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_14; // @[softmax.scala 43:35]
  wire [7:0] exponentArray_io_output_bits_out_15; // @[softmax.scala 43:35]
  wire  exponentArray_io_output_bits_last; // @[softmax.scala 43:35]
  wire  exponentArray_rst; // @[softmax.scala 43:35]
  wire  exponentArrayInHsk_io_input_valid; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_0; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_1; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_2; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_3; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_4; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_5; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_6; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_7; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_8; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_9; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_10; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_11; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_12; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_13; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_14; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_input_bits_0_in_15; // @[softmax.scala 44:40]
  wire  exponentArrayInHsk_io_input_bits_0_last; // @[softmax.scala 44:40]
  wire  exponentArrayInHsk_io_output_0_valid; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_0; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_1; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_2; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_3; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_4; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_5; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_6; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_7; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_8; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_9; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_10; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_11; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_12; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_13; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_14; // @[softmax.scala 44:40]
  wire [7:0] exponentArrayInHsk_io_output_0_bits_in_15; // @[softmax.scala 44:40]
  wire  exponentArrayInHsk_io_output_0_bits_last; // @[softmax.scala 44:40]
  wire  exponentArrayInMux_io_input_0_valid; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_0; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_1; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_2; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_3; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_4; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_5; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_6; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_7; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_8; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_9; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_10; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_11; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_12; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_13; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_14; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_input_0_bits_in_15; // @[softmax.scala 45:40]
  wire  exponentArrayInMux_io_input_0_bits_last; // @[softmax.scala 45:40]
  wire [1:0] exponentArrayInMux_io_sel; // @[softmax.scala 45:40]
  wire  exponentArrayInMux_io_output_valid; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_0; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_1; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_2; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_3; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_4; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_5; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_6; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_7; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_8; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_9; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_10; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_11; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_12; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_13; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_14; // @[softmax.scala 45:40]
  wire [7:0] exponentArrayInMux_io_output_bits_in_15; // @[softmax.scala 45:40]
  wire  exponentArrayInMux_io_output_bits_last; // @[softmax.scala 45:40]
  wire  exponentArrayOutMux_io_input_ready; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_0; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_1; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_2; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_3; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_4; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_5; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_6; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_7; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_8; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_9; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_10; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_11; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_12; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_13; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_14; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_input_bits_out_15; // @[softmax.scala 46:41]
  wire  exponentArrayOutMux_io_input_bits_last; // @[softmax.scala 46:41]
  wire  exponentArrayOutMux_io_sel; // @[softmax.scala 46:41]
  wire  exponentArrayOutMux_io_output_0_bits_last; // @[softmax.scala 46:41]
  wire  exponentArrayOutMux_io_output_1_ready; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_0; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_1; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_2; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_3; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_4; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_5; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_6; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_7; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_8; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_9; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_10; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_11; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_12; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_13; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_14; // @[softmax.scala 46:41]
  wire [7:0] exponentArrayOutMux_io_output_1_bits_out_15; // @[softmax.scala 46:41]
  wire  exponentArrayOutMux_io_output_1_bits_last; // @[softmax.scala 46:41]
  wire  adderTree_clock; // @[softmax.scala 49:31]
  wire  adderTree_io_input_bits_last; // @[softmax.scala 49:31]
  wire  adderTree_rst; // @[softmax.scala 49:31]
  reg  inPathSel; // @[Reg.scala 28:20]
  wire  inPathSelEn = exponentArray_io_input_valid & exponentArray_io_input_ready & exponentArray_io_input_bits_last; // @[softmax.scala 68:81]
  wire  inPathSelNxt = ~inPathSel; // @[softmax.scala 37:25]
  reg  outPathSel; // @[Reg.scala 28:20]
  wire  outPathSelEn = exponentArray_io_output_valid & exponentArray_io_output_ready & exponentArray_io_output_bits_last
    ; // @[softmax.scala 89:84]
  wire  outPathSelNxt = ~outPathSel; // @[softmax.scala 38:26]
  Exponent exponentArray ( // @[softmax.scala 43:35]
    .clock(exponentArray_clock),
    .io_input_ready(exponentArray_io_input_ready),
    .io_input_valid(exponentArray_io_input_valid),
    .io_input_bits_in_0(exponentArray_io_input_bits_in_0),
    .io_input_bits_in_1(exponentArray_io_input_bits_in_1),
    .io_input_bits_in_2(exponentArray_io_input_bits_in_2),
    .io_input_bits_in_3(exponentArray_io_input_bits_in_3),
    .io_input_bits_in_4(exponentArray_io_input_bits_in_4),
    .io_input_bits_in_5(exponentArray_io_input_bits_in_5),
    .io_input_bits_in_6(exponentArray_io_input_bits_in_6),
    .io_input_bits_in_7(exponentArray_io_input_bits_in_7),
    .io_input_bits_in_8(exponentArray_io_input_bits_in_8),
    .io_input_bits_in_9(exponentArray_io_input_bits_in_9),
    .io_input_bits_in_10(exponentArray_io_input_bits_in_10),
    .io_input_bits_in_11(exponentArray_io_input_bits_in_11),
    .io_input_bits_in_12(exponentArray_io_input_bits_in_12),
    .io_input_bits_in_13(exponentArray_io_input_bits_in_13),
    .io_input_bits_in_14(exponentArray_io_input_bits_in_14),
    .io_input_bits_in_15(exponentArray_io_input_bits_in_15),
    .io_input_bits_last(exponentArray_io_input_bits_last),
    .io_output_ready(exponentArray_io_output_ready),
    .io_output_valid(exponentArray_io_output_valid),
    .io_output_bits_out_0(exponentArray_io_output_bits_out_0),
    .io_output_bits_out_1(exponentArray_io_output_bits_out_1),
    .io_output_bits_out_2(exponentArray_io_output_bits_out_2),
    .io_output_bits_out_3(exponentArray_io_output_bits_out_3),
    .io_output_bits_out_4(exponentArray_io_output_bits_out_4),
    .io_output_bits_out_5(exponentArray_io_output_bits_out_5),
    .io_output_bits_out_6(exponentArray_io_output_bits_out_6),
    .io_output_bits_out_7(exponentArray_io_output_bits_out_7),
    .io_output_bits_out_8(exponentArray_io_output_bits_out_8),
    .io_output_bits_out_9(exponentArray_io_output_bits_out_9),
    .io_output_bits_out_10(exponentArray_io_output_bits_out_10),
    .io_output_bits_out_11(exponentArray_io_output_bits_out_11),
    .io_output_bits_out_12(exponentArray_io_output_bits_out_12),
    .io_output_bits_out_13(exponentArray_io_output_bits_out_13),
    .io_output_bits_out_14(exponentArray_io_output_bits_out_14),
    .io_output_bits_out_15(exponentArray_io_output_bits_out_15),
    .io_output_bits_last(exponentArray_io_output_bits_last),
    .rst(exponentArray_rst)
  );
  Hsk1ton exponentArrayInHsk ( // @[softmax.scala 44:40]
    .io_input_valid(exponentArrayInHsk_io_input_valid),
    .io_input_bits_0_in_0(exponentArrayInHsk_io_input_bits_0_in_0),
    .io_input_bits_0_in_1(exponentArrayInHsk_io_input_bits_0_in_1),
    .io_input_bits_0_in_2(exponentArrayInHsk_io_input_bits_0_in_2),
    .io_input_bits_0_in_3(exponentArrayInHsk_io_input_bits_0_in_3),
    .io_input_bits_0_in_4(exponentArrayInHsk_io_input_bits_0_in_4),
    .io_input_bits_0_in_5(exponentArrayInHsk_io_input_bits_0_in_5),
    .io_input_bits_0_in_6(exponentArrayInHsk_io_input_bits_0_in_6),
    .io_input_bits_0_in_7(exponentArrayInHsk_io_input_bits_0_in_7),
    .io_input_bits_0_in_8(exponentArrayInHsk_io_input_bits_0_in_8),
    .io_input_bits_0_in_9(exponentArrayInHsk_io_input_bits_0_in_9),
    .io_input_bits_0_in_10(exponentArrayInHsk_io_input_bits_0_in_10),
    .io_input_bits_0_in_11(exponentArrayInHsk_io_input_bits_0_in_11),
    .io_input_bits_0_in_12(exponentArrayInHsk_io_input_bits_0_in_12),
    .io_input_bits_0_in_13(exponentArrayInHsk_io_input_bits_0_in_13),
    .io_input_bits_0_in_14(exponentArrayInHsk_io_input_bits_0_in_14),
    .io_input_bits_0_in_15(exponentArrayInHsk_io_input_bits_0_in_15),
    .io_input_bits_0_last(exponentArrayInHsk_io_input_bits_0_last),
    .io_output_0_valid(exponentArrayInHsk_io_output_0_valid),
    .io_output_0_bits_in_0(exponentArrayInHsk_io_output_0_bits_in_0),
    .io_output_0_bits_in_1(exponentArrayInHsk_io_output_0_bits_in_1),
    .io_output_0_bits_in_2(exponentArrayInHsk_io_output_0_bits_in_2),
    .io_output_0_bits_in_3(exponentArrayInHsk_io_output_0_bits_in_3),
    .io_output_0_bits_in_4(exponentArrayInHsk_io_output_0_bits_in_4),
    .io_output_0_bits_in_5(exponentArrayInHsk_io_output_0_bits_in_5),
    .io_output_0_bits_in_6(exponentArrayInHsk_io_output_0_bits_in_6),
    .io_output_0_bits_in_7(exponentArrayInHsk_io_output_0_bits_in_7),
    .io_output_0_bits_in_8(exponentArrayInHsk_io_output_0_bits_in_8),
    .io_output_0_bits_in_9(exponentArrayInHsk_io_output_0_bits_in_9),
    .io_output_0_bits_in_10(exponentArrayInHsk_io_output_0_bits_in_10),
    .io_output_0_bits_in_11(exponentArrayInHsk_io_output_0_bits_in_11),
    .io_output_0_bits_in_12(exponentArrayInHsk_io_output_0_bits_in_12),
    .io_output_0_bits_in_13(exponentArrayInHsk_io_output_0_bits_in_13),
    .io_output_0_bits_in_14(exponentArrayInHsk_io_output_0_bits_in_14),
    .io_output_0_bits_in_15(exponentArrayInHsk_io_output_0_bits_in_15),
    .io_output_0_bits_last(exponentArrayInHsk_io_output_0_bits_last)
  );
  Arbiternto1 exponentArrayInMux ( // @[softmax.scala 45:40]
    .io_input_0_valid(exponentArrayInMux_io_input_0_valid),
    .io_input_0_bits_in_0(exponentArrayInMux_io_input_0_bits_in_0),
    .io_input_0_bits_in_1(exponentArrayInMux_io_input_0_bits_in_1),
    .io_input_0_bits_in_2(exponentArrayInMux_io_input_0_bits_in_2),
    .io_input_0_bits_in_3(exponentArrayInMux_io_input_0_bits_in_3),
    .io_input_0_bits_in_4(exponentArrayInMux_io_input_0_bits_in_4),
    .io_input_0_bits_in_5(exponentArrayInMux_io_input_0_bits_in_5),
    .io_input_0_bits_in_6(exponentArrayInMux_io_input_0_bits_in_6),
    .io_input_0_bits_in_7(exponentArrayInMux_io_input_0_bits_in_7),
    .io_input_0_bits_in_8(exponentArrayInMux_io_input_0_bits_in_8),
    .io_input_0_bits_in_9(exponentArrayInMux_io_input_0_bits_in_9),
    .io_input_0_bits_in_10(exponentArrayInMux_io_input_0_bits_in_10),
    .io_input_0_bits_in_11(exponentArrayInMux_io_input_0_bits_in_11),
    .io_input_0_bits_in_12(exponentArrayInMux_io_input_0_bits_in_12),
    .io_input_0_bits_in_13(exponentArrayInMux_io_input_0_bits_in_13),
    .io_input_0_bits_in_14(exponentArrayInMux_io_input_0_bits_in_14),
    .io_input_0_bits_in_15(exponentArrayInMux_io_input_0_bits_in_15),
    .io_input_0_bits_last(exponentArrayInMux_io_input_0_bits_last),
    .io_sel(exponentArrayInMux_io_sel),
    .io_output_valid(exponentArrayInMux_io_output_valid),
    .io_output_bits_in_0(exponentArrayInMux_io_output_bits_in_0),
    .io_output_bits_in_1(exponentArrayInMux_io_output_bits_in_1),
    .io_output_bits_in_2(exponentArrayInMux_io_output_bits_in_2),
    .io_output_bits_in_3(exponentArrayInMux_io_output_bits_in_3),
    .io_output_bits_in_4(exponentArrayInMux_io_output_bits_in_4),
    .io_output_bits_in_5(exponentArrayInMux_io_output_bits_in_5),
    .io_output_bits_in_6(exponentArrayInMux_io_output_bits_in_6),
    .io_output_bits_in_7(exponentArrayInMux_io_output_bits_in_7),
    .io_output_bits_in_8(exponentArrayInMux_io_output_bits_in_8),
    .io_output_bits_in_9(exponentArrayInMux_io_output_bits_in_9),
    .io_output_bits_in_10(exponentArrayInMux_io_output_bits_in_10),
    .io_output_bits_in_11(exponentArrayInMux_io_output_bits_in_11),
    .io_output_bits_in_12(exponentArrayInMux_io_output_bits_in_12),
    .io_output_bits_in_13(exponentArrayInMux_io_output_bits_in_13),
    .io_output_bits_in_14(exponentArrayInMux_io_output_bits_in_14),
    .io_output_bits_in_15(exponentArrayInMux_io_output_bits_in_15),
    .io_output_bits_last(exponentArrayInMux_io_output_bits_last)
  );
  Arbiter1ton exponentArrayOutMux ( // @[softmax.scala 46:41]
    .io_input_ready(exponentArrayOutMux_io_input_ready),
    .io_input_bits_out_0(exponentArrayOutMux_io_input_bits_out_0),
    .io_input_bits_out_1(exponentArrayOutMux_io_input_bits_out_1),
    .io_input_bits_out_2(exponentArrayOutMux_io_input_bits_out_2),
    .io_input_bits_out_3(exponentArrayOutMux_io_input_bits_out_3),
    .io_input_bits_out_4(exponentArrayOutMux_io_input_bits_out_4),
    .io_input_bits_out_5(exponentArrayOutMux_io_input_bits_out_5),
    .io_input_bits_out_6(exponentArrayOutMux_io_input_bits_out_6),
    .io_input_bits_out_7(exponentArrayOutMux_io_input_bits_out_7),
    .io_input_bits_out_8(exponentArrayOutMux_io_input_bits_out_8),
    .io_input_bits_out_9(exponentArrayOutMux_io_input_bits_out_9),
    .io_input_bits_out_10(exponentArrayOutMux_io_input_bits_out_10),
    .io_input_bits_out_11(exponentArrayOutMux_io_input_bits_out_11),
    .io_input_bits_out_12(exponentArrayOutMux_io_input_bits_out_12),
    .io_input_bits_out_13(exponentArrayOutMux_io_input_bits_out_13),
    .io_input_bits_out_14(exponentArrayOutMux_io_input_bits_out_14),
    .io_input_bits_out_15(exponentArrayOutMux_io_input_bits_out_15),
    .io_input_bits_last(exponentArrayOutMux_io_input_bits_last),
    .io_sel(exponentArrayOutMux_io_sel),
    .io_output_0_bits_last(exponentArrayOutMux_io_output_0_bits_last),
    .io_output_1_ready(exponentArrayOutMux_io_output_1_ready),
    .io_output_1_bits_out_0(exponentArrayOutMux_io_output_1_bits_out_0),
    .io_output_1_bits_out_1(exponentArrayOutMux_io_output_1_bits_out_1),
    .io_output_1_bits_out_2(exponentArrayOutMux_io_output_1_bits_out_2),
    .io_output_1_bits_out_3(exponentArrayOutMux_io_output_1_bits_out_3),
    .io_output_1_bits_out_4(exponentArrayOutMux_io_output_1_bits_out_4),
    .io_output_1_bits_out_5(exponentArrayOutMux_io_output_1_bits_out_5),
    .io_output_1_bits_out_6(exponentArrayOutMux_io_output_1_bits_out_6),
    .io_output_1_bits_out_7(exponentArrayOutMux_io_output_1_bits_out_7),
    .io_output_1_bits_out_8(exponentArrayOutMux_io_output_1_bits_out_8),
    .io_output_1_bits_out_9(exponentArrayOutMux_io_output_1_bits_out_9),
    .io_output_1_bits_out_10(exponentArrayOutMux_io_output_1_bits_out_10),
    .io_output_1_bits_out_11(exponentArrayOutMux_io_output_1_bits_out_11),
    .io_output_1_bits_out_12(exponentArrayOutMux_io_output_1_bits_out_12),
    .io_output_1_bits_out_13(exponentArrayOutMux_io_output_1_bits_out_13),
    .io_output_1_bits_out_14(exponentArrayOutMux_io_output_1_bits_out_14),
    .io_output_1_bits_out_15(exponentArrayOutMux_io_output_1_bits_out_15),
    .io_output_1_bits_last(exponentArrayOutMux_io_output_1_bits_last)
  );
  AdderTree adderTree ( // @[softmax.scala 49:31]
    .clock(adderTree_clock),
    .io_input_bits_last(adderTree_io_input_bits_last),
    .rst(adderTree_rst)
  );
  assign io_input_ready = 1'h0; // @[softmax.scala 62:24]
  assign io_output_valid = 1'h0; // @[softmax.scala 91:25]
  assign io_output_bits_out_0 = exponentArrayOutMux_io_output_1_bits_out_0; // @[softmax.scala 92:24]
  assign io_output_bits_out_1 = exponentArrayOutMux_io_output_1_bits_out_1; // @[softmax.scala 92:24]
  assign io_output_bits_out_2 = exponentArrayOutMux_io_output_1_bits_out_2; // @[softmax.scala 92:24]
  assign io_output_bits_out_3 = exponentArrayOutMux_io_output_1_bits_out_3; // @[softmax.scala 92:24]
  assign io_output_bits_out_4 = exponentArrayOutMux_io_output_1_bits_out_4; // @[softmax.scala 92:24]
  assign io_output_bits_out_5 = exponentArrayOutMux_io_output_1_bits_out_5; // @[softmax.scala 92:24]
  assign io_output_bits_out_6 = exponentArrayOutMux_io_output_1_bits_out_6; // @[softmax.scala 92:24]
  assign io_output_bits_out_7 = exponentArrayOutMux_io_output_1_bits_out_7; // @[softmax.scala 92:24]
  assign io_output_bits_out_8 = exponentArrayOutMux_io_output_1_bits_out_8; // @[softmax.scala 92:24]
  assign io_output_bits_out_9 = exponentArrayOutMux_io_output_1_bits_out_9; // @[softmax.scala 92:24]
  assign io_output_bits_out_10 = exponentArrayOutMux_io_output_1_bits_out_10; // @[softmax.scala 92:24]
  assign io_output_bits_out_11 = exponentArrayOutMux_io_output_1_bits_out_11; // @[softmax.scala 92:24]
  assign io_output_bits_out_12 = exponentArrayOutMux_io_output_1_bits_out_12; // @[softmax.scala 92:24]
  assign io_output_bits_out_13 = exponentArrayOutMux_io_output_1_bits_out_13; // @[softmax.scala 92:24]
  assign io_output_bits_out_14 = exponentArrayOutMux_io_output_1_bits_out_14; // @[softmax.scala 92:24]
  assign io_output_bits_out_15 = exponentArrayOutMux_io_output_1_bits_out_15; // @[softmax.scala 92:24]
  assign io_output_bits_last = exponentArrayOutMux_io_output_1_bits_last; // @[softmax.scala 92:24]
  assign exponentArray_clock = clock;
  assign exponentArray_io_input_valid = exponentArrayInMux_io_output_valid; // @[softmax.scala 80:38]
  assign exponentArray_io_input_bits_in_0 = exponentArrayInMux_io_output_bits_in_0; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_1 = exponentArrayInMux_io_output_bits_in_1; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_2 = exponentArrayInMux_io_output_bits_in_2; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_3 = exponentArrayInMux_io_output_bits_in_3; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_4 = exponentArrayInMux_io_output_bits_in_4; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_5 = exponentArrayInMux_io_output_bits_in_5; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_6 = exponentArrayInMux_io_output_bits_in_6; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_7 = exponentArrayInMux_io_output_bits_in_7; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_8 = exponentArrayInMux_io_output_bits_in_8; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_9 = exponentArrayInMux_io_output_bits_in_9; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_10 = exponentArrayInMux_io_output_bits_in_10; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_11 = exponentArrayInMux_io_output_bits_in_11; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_12 = exponentArrayInMux_io_output_bits_in_12; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_13 = exponentArrayInMux_io_output_bits_in_13; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_14 = exponentArrayInMux_io_output_bits_in_14; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_in_15 = exponentArrayInMux_io_output_bits_in_15; // @[softmax.scala 81:37]
  assign exponentArray_io_input_bits_last = exponentArrayInMux_io_output_bits_last; // @[softmax.scala 81:37]
  assign exponentArray_io_output_ready = exponentArrayOutMux_io_input_ready; // @[softmax.scala 87:39]
  assign exponentArray_rst = rst; // @[softmax.scala 53:27]
  assign exponentArrayInHsk_io_input_valid = io_input_valid; // @[softmax.scala 59:43]
  assign exponentArrayInHsk_io_input_bits_0_in_0 = io_input_bits_in_0; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_1 = io_input_bits_in_1; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_2 = io_input_bits_in_2; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_3 = io_input_bits_in_3; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_4 = io_input_bits_in_4; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_5 = io_input_bits_in_5; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_6 = io_input_bits_in_6; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_7 = io_input_bits_in_7; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_8 = io_input_bits_in_8; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_9 = io_input_bits_in_9; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_10 = io_input_bits_in_10; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_11 = io_input_bits_in_11; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_12 = io_input_bits_in_12; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_13 = io_input_bits_in_13; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_14 = io_input_bits_in_14; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_in_15 = io_input_bits_in_15; // @[softmax.scala 60:45]
  assign exponentArrayInHsk_io_input_bits_0_last = io_input_bits_last; // @[softmax.scala 60:45]
  assign exponentArrayInMux_io_input_0_valid = exponentArrayInHsk_io_output_0_valid; // @[softmax.scala 64:46]
  assign exponentArrayInMux_io_input_0_bits_in_0 = exponentArrayInHsk_io_output_0_bits_in_0; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_1 = exponentArrayInHsk_io_output_0_bits_in_1; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_2 = exponentArrayInHsk_io_output_0_bits_in_2; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_3 = exponentArrayInHsk_io_output_0_bits_in_3; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_4 = exponentArrayInHsk_io_output_0_bits_in_4; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_5 = exponentArrayInHsk_io_output_0_bits_in_5; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_6 = exponentArrayInHsk_io_output_0_bits_in_6; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_7 = exponentArrayInHsk_io_output_0_bits_in_7; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_8 = exponentArrayInHsk_io_output_0_bits_in_8; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_9 = exponentArrayInHsk_io_output_0_bits_in_9; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_10 = exponentArrayInHsk_io_output_0_bits_in_10; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_11 = exponentArrayInHsk_io_output_0_bits_in_11; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_12 = exponentArrayInHsk_io_output_0_bits_in_12; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_13 = exponentArrayInHsk_io_output_0_bits_in_13; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_14 = exponentArrayInHsk_io_output_0_bits_in_14; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_in_15 = exponentArrayInHsk_io_output_0_bits_in_15; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_input_0_bits_last = exponentArrayInHsk_io_output_0_bits_last; // @[softmax.scala 65:45]
  assign exponentArrayInMux_io_sel = {{1'd0}, inPathSel}; // @[softmax.scala 67:35]
  assign exponentArrayOutMux_io_input_bits_out_0 = exponentArray_io_output_bits_out_0; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_1 = exponentArray_io_output_bits_out_1; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_2 = exponentArray_io_output_bits_out_2; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_3 = exponentArray_io_output_bits_out_3; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_4 = exponentArray_io_output_bits_out_4; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_5 = exponentArray_io_output_bits_out_5; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_6 = exponentArray_io_output_bits_out_6; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_7 = exponentArray_io_output_bits_out_7; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_8 = exponentArray_io_output_bits_out_8; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_9 = exponentArray_io_output_bits_out_9; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_10 = exponentArray_io_output_bits_out_10; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_11 = exponentArray_io_output_bits_out_11; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_12 = exponentArray_io_output_bits_out_12; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_13 = exponentArray_io_output_bits_out_13; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_14 = exponentArray_io_output_bits_out_14; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_out_15 = exponentArray_io_output_bits_out_15; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_input_bits_last = exponentArray_io_output_bits_last; // @[softmax.scala 86:43]
  assign exponentArrayOutMux_io_sel = outPathSel; // @[softmax.scala 88:36]
  assign exponentArrayOutMux_io_output_1_ready = io_output_ready; // @[softmax.scala 93:48]
  assign adderTree_clock = clock;
  assign adderTree_io_input_bits_last = exponentArrayOutMux_io_output_0_bits_last; // @[softmax.scala 97:38]
  assign adderTree_rst = rst; // @[softmax.scala 54:23]
  always @(posedge clock or posedge rst) begin
    if (rst) begin // @[Reg.scala 29:18]
      inPathSel <= 1'h0; // @[Reg.scala 29:22]
    end else if (inPathSelEn) begin // @[Reg.scala 28:20]
      inPathSel <= inPathSelNxt;
    end
  end
  always @(posedge clock or posedge rst) begin
    if (rst) begin // @[Reg.scala 29:18]
      outPathSel <= 1'h0; // @[Reg.scala 29:22]
    end else if (outPathSelEn) begin // @[Reg.scala 28:20]
      outPathSel <= outPathSelNxt;
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
  inPathSel = _RAND_0[0:0];
  _RAND_1 = {1{`RANDOM}};
  outPathSel = _RAND_1[0:0];
`endif // RANDOMIZE_REG_INIT
  if (rst) begin
    inPathSel = 1'h0;
  end
  if (rst) begin
    outPathSel = 1'h0;
  end
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
