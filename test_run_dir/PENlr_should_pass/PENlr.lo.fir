circuit PENlr :
  module CounterHsk :
    input clock : Clock
    input reset : UInt<1>
    input io_validPre : UInt<1>
    output io_readyPre : UInt<1>
    output io_validNxt : UInt<1>
    input io_readyNxt : UInt<1>
    input io_lastPre : UInt<1>
    output io_lastNxt : UInt<1>
    output io_regen : UInt<1>

    reg counter : UInt<3>, clock with :
      reset => (UInt<1>("h0"), counter) @[Reg.scala 28:20]
    node _counterEn_T = and(io_validNxt, io_readyNxt) @[counterhsk.scala 30:29]
    node _counterEn_T_1 = or(_counterEn_T, io_regen) @[counterhsk.scala 30:41]
    node counterEn = _counterEn_T_1 @[counterhsk.scala 22:25 30:15]
    node _counterNxt_T = eq(counter, UInt<3>("h4")) @[counterhsk.scala 25:16]
    node _counterNxt_T_1 = and(io_validPre, io_readyPre) @[counterhsk.scala 26:24]
    node _counterNxt_T_2 = mux(_counterNxt_T_1, UInt<3>("h1"), UInt<3>("h0")) @[counterhsk.scala 26:12]
    node _counterNxt_T_3 = add(counter, UInt<3>("h1")) @[counterhsk.scala 27:16]
    node _counterNxt_T_4 = tail(_counterNxt_T_3, 1) @[counterhsk.scala 27:16]
    node _counterNxt_T_5 = mux(_counterNxt_T, _counterNxt_T_2, _counterNxt_T_4) @[counterhsk.scala 24:22]
    node counterNxt = _counterNxt_T_5 @[counterhsk.scala 21:26 24:16]
    node _GEN_0 = mux(counterEn, counterNxt, counter) @[Reg.scala 29:18 28:20 29:22]
    node _io_regen_T = and(io_validPre, io_readyPre) @[counterhsk.scala 29:29]
    node _io_regen_T_1 = eq(counter, UInt<3>("h0")) @[counterhsk.scala 29:53]
    node _io_regen_T_2 = eq(counter, UInt<3>("h4")) @[counterhsk.scala 29:85]
    node _io_regen_T_3 = or(_io_regen_T_1, _io_regen_T_2) @[counterhsk.scala 29:76]
    node _io_regen_T_4 = not(_io_regen_T_3) @[counterhsk.scala 29:43]
    node _io_regen_T_5 = or(_io_regen_T, _io_regen_T_4) @[counterhsk.scala 29:41]
    node _io_readyPre_T = eq(counter, UInt<3>("h0")) @[counterhsk.scala 31:29]
    node _io_readyPre_T_1 = and(io_validNxt, io_readyNxt) @[counterhsk.scala 31:64]
    node _io_readyPre_T_2 = or(_io_readyPre_T, _io_readyPre_T_1) @[counterhsk.scala 31:52]
    node _io_validNxt_T = eq(counter, UInt<3>("h4")) @[counterhsk.scala 32:28]
    node _io_lastNxt_T = and(io_validPre, io_validNxt) @[counterhsk.scala 33:57]
    node _io_lastNxt_T_1 = and(_io_lastNxt_T, io_regen) @[counterhsk.scala 33:69]
    reg io_lastNxt_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_lastNxt_r) @[Reg.scala 28:20]
    node _GEN_1 = mux(_io_lastNxt_T_1, io_lastPre, io_lastNxt_r) @[Reg.scala 29:18 28:20 29:22]
    io_readyPre <= _io_readyPre_T_2 @[counterhsk.scala 31:17]
    io_validNxt <= _io_validNxt_T @[counterhsk.scala 32:17]
    io_lastNxt <= io_lastNxt_r @[counterhsk.scala 33:16]
    io_regen <= _io_regen_T_5 @[counterhsk.scala 29:14]
    counter <= mux(reset, UInt<3>("h0"), _GEN_0) @[Reg.scala 28:{20,20}]
    io_lastNxt_r <= mux(reset, UInt<1>("h0"), _GEN_1) @[Reg.scala 28:{20,20}]

  module Multiply :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_x_0 : SInt<8>
    input io_input_bits_x_1 : SInt<8>
    input io_input_bits_last : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_x_0 : SInt<16>
    output io_output_bits_last : UInt<1>

    inst counterHsk of CounterHsk @[multiply.scala 20:28]
    reg in0 : SInt<8>, clock with :
      reset => (UInt<1>("h0"), in0) @[Reg.scala 16:16]
    node _in0Nxt_T = and(io_input_valid, io_input_ready) @[multiply.scala 31:33]
    node _in0Nxt_T_1 = shl(io_input_bits_x_0, 2) @[multiply.scala 31:68]
    node _in0Nxt_T_2 = shl(in0, 2) @[multiply.scala 31:76]
    node _in0Nxt_T_3 = mux(_in0Nxt_T, _in0Nxt_T_1, _in0Nxt_T_2) @[multiply.scala 31:18]
    node in0Nxt = asSInt(bits(_in0Nxt_T_3, 7, 0)) @[multiply.scala 28:22 31:12]
    node _GEN_0 = mux(counterHsk.io_regen, in0Nxt, in0) @[Reg.scala 16:16 17:{18,22}]
    node _in1_T = and(io_input_valid, io_input_ready) @[multiply.scala 30:59]
    node _in1_T_1 = and(_in1_T, counterHsk.io_regen) @[multiply.scala 30:74]
    reg in1 : SInt<8>, clock with :
      reset => (UInt<1>("h0"), in1) @[Reg.scala 16:16]
    node _GEN_1 = mux(_in1_T_1, io_input_bits_x_1, in1) @[Reg.scala 16:16 17:{18,22}]
    node _in1Inc_T = and(io_input_valid, io_input_ready) @[multiply.scala 32:36]
    node in1Inc = mux(_in1Inc_T, io_input_bits_x_1, in1) @[multiply.scala 32:21]
    reg out0 : SInt<16>, clock with :
      reset => (UInt<1>("h0"), out0) @[Reg.scala 16:16]
    node _out0Nxt_T = and(io_input_valid, io_input_ready) @[multiply.scala 37:34]
    node _out0IncMux_T = and(io_input_valid, io_input_ready) @[multiply.scala 38:40]
    node _out0IncMux_T_1 = bits(io_input_bits_x_0, 7, 5) @[multiply.scala 38:75]
    node _out0IncMux_T_2 = bits(in0, 7, 5) @[multiply.scala 38:94]
    node out0IncMux = mux(_out0IncMux_T, _out0IncMux_T_1, _out0IncMux_T_2) @[multiply.scala 38:25]
    node _out0Inc_T = eq(out0IncMux, UInt<3>("h0")) @[multiply.scala 39:31]
    node _out0Inc_T_1 = eq(out0IncMux, UInt<3>("h7")) @[multiply.scala 39:55]
    node _out0Inc_T_2 = or(_out0Inc_T, _out0Inc_T_1) @[multiply.scala 39:43]
    node _out0Inc_T_3 = eq(out0IncMux, UInt<3>("h1")) @[multiply.scala 40:24]
    node _out0Inc_T_4 = eq(out0IncMux, UInt<3>("h2")) @[multiply.scala 40:48]
    node _out0Inc_T_5 = or(_out0Inc_T_3, _out0Inc_T_4) @[multiply.scala 40:36]
    node _out0Inc_T_6 = asSInt(in1Inc) @[multiply.scala 40:81]
    node _out0Inc_T_7 = eq(out0IncMux, UInt<3>("h3")) @[multiply.scala 41:24]
    node _out0Inc_T_8 = asSInt(in1Inc) @[multiply.scala 41:57]
    node _out0Inc_T_9 = eq(out0IncMux, UInt<3>("h4")) @[multiply.scala 42:24]
    node _out0Inc_T_10 = asSInt(in1Inc) @[multiply.scala 42:58]
    node _out0Inc_T_11 = sub(shl(asSInt(UInt<1>("h0")), 7), _out0Inc_T_10) @[multiply.scala 42:38]
    node _out0Inc_T_12 = tail(_out0Inc_T_11, 1) @[multiply.scala 42:38]
    node _out0Inc_T_13 = asSInt(_out0Inc_T_12) @[multiply.scala 42:38]
    node _out0Inc_T_14 = eq(out0IncMux, UInt<3>("h5")) @[multiply.scala 43:24]
    node _out0Inc_T_15 = eq(out0IncMux, UInt<3>("h6")) @[multiply.scala 43:48]
    node _out0Inc_T_16 = or(_out0Inc_T_14, _out0Inc_T_15) @[multiply.scala 43:36]
    node _out0Inc_T_17 = asSInt(in1Inc) @[multiply.scala 43:82]
    node _out0Inc_T_18 = sub(shl(asSInt(UInt<1>("h0")), 8), _out0Inc_T_17) @[multiply.scala 43:62]
    node _out0Inc_T_19 = tail(_out0Inc_T_18, 1) @[multiply.scala 43:62]
    node _out0Inc_T_20 = asSInt(_out0Inc_T_19) @[multiply.scala 43:62]
    node _out0Inc_T_21 = mux(_out0Inc_T_16, _out0Inc_T_20, shl(asSInt(UInt<1>("h0")), 8)) @[multiply.scala 43:12]
    node _out0Inc_T_22 = mux(_out0Inc_T_9, shl(_out0Inc_T_13, 1), _out0Inc_T_21) @[multiply.scala 42:12]
    node _out0Inc_T_23 = mux(_out0Inc_T_7, shl(_out0Inc_T_8, 1), _out0Inc_T_22) @[multiply.scala 41:12]
    node _out0Inc_T_24 = mux(_out0Inc_T_5, _out0Inc_T_6, _out0Inc_T_23) @[multiply.scala 40:12]
    node _out0Inc_T_25 = mux(_out0Inc_T_2, shl(asSInt(UInt<1>("h0")), 8), _out0Inc_T_24) @[multiply.scala 39:19]
    node out0Inc = pad(_out0Inc_T_25, 16) @[multiply.scala 35:23 39:13]
    node _out0Nxt_T_1 = asSInt(out0) @[multiply.scala 37:77]
    node _out0Nxt_T_2 = add(shl(_out0Nxt_T_1, 2), out0Inc) @[multiply.scala 37:92]
    node _out0Nxt_T_3 = tail(_out0Nxt_T_2, 1) @[multiply.scala 37:92]
    node _out0Nxt_T_4 = asSInt(_out0Nxt_T_3) @[multiply.scala 37:92]
    node _out0Nxt_T_5 = mux(_out0Nxt_T, out0Inc, _out0Nxt_T_4) @[multiply.scala 37:19]
    node out0Nxt = asSInt(bits(_out0Nxt_T_5, 15, 0)) @[multiply.scala 34:23 37:13]
    node _GEN_2 = mux(counterHsk.io_regen, out0Nxt, out0) @[Reg.scala 16:16 17:{18,22}]
    io_input_ready <= counterHsk.io_readyPre @[multiply.scala 22:20]
    io_output_valid <= counterHsk.io_validNxt @[multiply.scala 23:21]
    io_output_bits_x_0 <= out0 @[multiply.scala 46:25]
    io_output_bits_last <= counterHsk.io_lastNxt @[multiply.scala 26:25]
    counterHsk.clock <= clock
    counterHsk.reset <= reset
    counterHsk.io_validPre <= io_input_valid @[multiply.scala 21:28]
    counterHsk.io_readyNxt <= io_output_ready @[multiply.scala 24:28]
    counterHsk.io_lastPre <= io_input_bits_last @[multiply.scala 25:27]
    in0 <= _GEN_0
    in1 <= _GEN_1
    out0 <= _GEN_2

  module PipelineHsk :
    input clock : Clock
    input reset : UInt<1>
    input io_validPre : UInt<1>
    output io_readyPre : UInt<1>
    input io_lastPre : UInt<1>
    output io_validNxt : UInt<1>
    input io_readyNxt : UInt<1>
    output io_regen_0 : UInt<1>
    output io_lastNxt : UInt<1>

    reg valid_1_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), valid_1_r) @[Reg.scala 28:20]
    node ready_1 = io_readyNxt @[pipelinehsk.scala 18:21 30:18]
    node valid_1 = valid_1_r @[pipelinehsk.scala 17:21 22:20]
    node _ready_0_T = not(valid_1) @[pipelinehsk.scala 24:34]
    node _ready_0_T_1 = or(ready_1, _ready_0_T) @[pipelinehsk.scala 24:32]
    node ready_0 = _ready_0_T_1 @[pipelinehsk.scala 18:21 24:18]
    node valid_0 = io_validPre @[pipelinehsk.scala 17:21 27:14]
    node _GEN_0 = mux(ready_0, valid_0, valid_1_r) @[Reg.scala 29:18 28:20 29:22]
    reg last_1_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), last_1_r) @[Reg.scala 28:20]
    node last_0 = io_lastPre @[pipelinehsk.scala 19:20 31:13]
    node _GEN_1 = mux(io_regen_0, last_0, last_1_r) @[Reg.scala 29:18 28:20 29:22]
    node _io_regen_0_T = and(valid_0, ready_0) @[pipelinehsk.scala 25:33]
    node last_1 = last_1_r @[pipelinehsk.scala 19:20 23:19]
    io_readyPre <= ready_0 @[pipelinehsk.scala 28:17]
    io_validNxt <= valid_1 @[pipelinehsk.scala 29:17]
    io_regen_0 <= _io_regen_0_T @[pipelinehsk.scala 25:21]
    io_lastNxt <= last_1 @[pipelinehsk.scala 32:16]
    valid_1_r <= mux(reset, UInt<1>("h0"), _GEN_0) @[Reg.scala 28:{20,20}]
    last_1_r <= mux(reset, UInt<1>("h0"), _GEN_1) @[Reg.scala 28:{20,20}]

  module Adder2to1 :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_x_0 : SInt<16>
    input io_input_bits_x_1 : SInt<16>
    input io_input_bits_last : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_x_0 : SInt<16>
    output io_output_bits_last : UInt<1>

    inst hsk of PipelineHsk @[adder2to1.scala 26:25]
    node _sum_0_T = add(io_input_bits_x_0, io_input_bits_x_1) @[adder2to1.scala 23:69]
    node _sum_0_T_1 = tail(_sum_0_T, 1) @[adder2to1.scala 23:69]
    node _sum_0_T_2 = asSInt(_sum_0_T_1) @[adder2to1.scala 23:69]
    reg r_0 : SInt<16>, clock with :
      reset => (UInt<1>("h0"), r_0) @[Reg.scala 16:16]
    node sum_0 = _sum_0_T_2 @[adder2to1.scala 18:19 23:48]
    node _GEN_0 = mux(hsk.io_regen_0, sum_0, r_0) @[Reg.scala 16:16 17:{18,22}]
    io_input_ready <= hsk.io_readyPre @[adder2to1.scala 28:24]
    io_output_valid <= hsk.io_validNxt @[adder2to1.scala 29:25]
    io_output_bits_x_0 <= r_0 @[adder2to1.scala 33:26]
    io_output_bits_last <= hsk.io_lastNxt @[adder2to1.scala 32:29]
    hsk.clock <= clock
    hsk.reset <= reset
    hsk.io_validPre <= io_input_valid @[adder2to1.scala 27:25]
    hsk.io_lastPre <= io_input_bits_last @[adder2to1.scala 31:24]
    hsk.io_readyNxt <= io_output_ready @[adder2to1.scala 30:25]
    r_0 <= _GEN_0

  module Hsknto1 :
    input clock : Clock
    input reset : UInt<1>
    output io_input_0_ready : UInt<1>
    input io_input_0_valid : UInt<1>
    input io_input_0_bits_x_0 : SInt<16>
    input io_input_0_bits_last : UInt<1>
    output io_input_1_ready : UInt<1>
    input io_input_1_valid : UInt<1>
    input io_input_1_bits_x_0 : SInt<16>
    input io_input_1_bits_last : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_0_x_0 : SInt<16>
    output io_output_bits_0_last : UInt<1>
    output io_output_bits_1_x_0 : SInt<16>
    output io_output_bits_1_last : UInt<1>

    node _io_output_valid_T = and(UInt<1>("h1"), io_input_0_valid) @[hsknto1.scala 12:58]
    node _io_output_valid_T_1 = and(_io_output_valid_T, io_input_1_valid) @[hsknto1.scala 12:58]
    node _io_input_0_ready_T = not(io_input_0_valid) @[hsknto1.scala 14:75]
    node _io_input_0_ready_T_1 = mux(UInt<1>("h1"), UInt<1>("h1"), io_input_0_valid) @[hsknto1.scala 15:33]
    node _io_input_0_ready_T_2 = mux(UInt<1>("h0"), UInt<1>("h1"), io_input_1_valid) @[hsknto1.scala 15:33]
    node _io_input_0_ready_T_3 = and(UInt<1>("h1"), _io_input_0_ready_T_1) @[hsknto1.scala 15:72]
    node _io_input_0_ready_T_4 = and(_io_input_0_ready_T_3, _io_input_0_ready_T_2) @[hsknto1.scala 15:72]
    node _io_input_0_ready_T_5 = or(_io_input_0_ready_T, _io_input_0_ready_T_4) @[hsknto1.scala 14:83]
    node _io_input_0_ready_T_6 = and(io_output_ready, _io_input_0_ready_T_5) @[hsknto1.scala 14:73]
    node _io_input_1_ready_T = not(io_input_1_valid) @[hsknto1.scala 14:75]
    node _io_input_1_ready_T_1 = mux(UInt<1>("h0"), UInt<1>("h1"), io_input_0_valid) @[hsknto1.scala 15:33]
    node _io_input_1_ready_T_2 = mux(UInt<1>("h1"), UInt<1>("h1"), io_input_1_valid) @[hsknto1.scala 15:33]
    node _io_input_1_ready_T_3 = and(UInt<1>("h1"), _io_input_1_ready_T_1) @[hsknto1.scala 15:72]
    node _io_input_1_ready_T_4 = and(_io_input_1_ready_T_3, _io_input_1_ready_T_2) @[hsknto1.scala 15:72]
    node _io_input_1_ready_T_5 = or(_io_input_1_ready_T, _io_input_1_ready_T_4) @[hsknto1.scala 14:83]
    node _io_input_1_ready_T_6 = and(io_output_ready, _io_input_1_ready_T_5) @[hsknto1.scala 14:73]
    io_input_0_ready <= _io_input_0_ready_T_6 @[hsknto1.scala 14:55]
    io_input_1_ready <= _io_input_1_ready_T_6 @[hsknto1.scala 14:55]
    io_output_valid <= _io_output_valid_T_1 @[hsknto1.scala 12:21]
    io_output_bits_0_x_0 <= io_input_0_bits_x_0 @[hsknto1.scala 13:55]
    io_output_bits_0_last <= io_input_0_bits_last @[hsknto1.scala 13:55]
    io_output_bits_1_x_0 <= io_input_1_bits_x_0 @[hsknto1.scala 13:55]
    io_output_bits_1_last <= io_input_1_bits_last @[hsknto1.scala 13:55]

  module PENlr :
    input clock : Clock
    input reset : UInt<1>
    output multiply_io_input_io_actWeiIn_ready : UInt<1>
    input multiply_io_input_io_actWeiIn_valid : UInt<1>
    input multiply_io_input_io_actWeiIn_bits_x_0 : SInt<8>
    input multiply_io_input_io_actWeiIn_bits_x_1 : SInt<8>
    input multiply_io_input_io_actWeiIn_bits_last : UInt<1>
    output multiply_io_input_io_sumIn_ready : UInt<1>
    input multiply_io_input_io_sumIn_valid : UInt<1>
    input multiply_io_input_io_sumIn_bits_x_0 : SInt<16>
    input multiply_io_input_io_sumIn_bits_last : UInt<1>
    input multiply_io_input_io_sumOut_ready : UInt<1>
    output multiply_io_input_io_sumOut_valid : UInt<1>
    output multiply_io_input_io_sumOut_bits_x_0 : SInt<16>
    output multiply_io_input_io_sumOut_bits_last : UInt<1>

    inst multiply of Multiply @[penlr.scala 14:26]
    inst adder of Adder2to1 @[penlr.scala 17:23]
    inst adderInHsk of Hsknto1 @[penlr.scala 18:28]
    multiply_io_input_io_actWeiIn_ready <= multiply.io_input_ready @[penlr.scala 15:23]
    multiply_io_input_io_sumIn_ready <= adderInHsk.io_input_1_ready @[penlr.scala 20:28]
    multiply_io_input_io_sumOut_valid <= adder.io_output_valid @[penlr.scala 23:21]
    multiply_io_input_io_sumOut_bits_x_0 <= adder.io_output_bits_x_0 @[penlr.scala 23:21]
    multiply_io_input_io_sumOut_bits_last <= adder.io_output_bits_last @[penlr.scala 23:21]
    multiply.clock <= clock
    multiply.reset <= reset
    multiply.io_input_valid <= multiply_io_input_io_actWeiIn_valid @[penlr.scala 15:23]
    multiply.io_input_bits_x_0 <= multiply_io_input_io_actWeiIn_bits_x_0 @[penlr.scala 15:23]
    multiply.io_input_bits_x_1 <= multiply_io_input_io_actWeiIn_bits_x_1 @[penlr.scala 15:23]
    multiply.io_input_bits_last <= multiply_io_input_io_actWeiIn_bits_last @[penlr.scala 15:23]
    multiply.io_output_ready <= adderInHsk.io_input_0_ready @[penlr.scala 19:28]
    adder.clock <= clock
    adder.reset <= reset
    adder.io_input_valid <= adderInHsk.io_output_valid @[port.scala 24:19]
    adder.io_input_bits_x_0 <= adderInHsk.io_output_bits_0_x_0 @[port.scala 20:37]
    adder.io_input_bits_x_1 <= adderInHsk.io_output_bits_1_x_0 @[port.scala 20:37]
    adder.io_input_bits_last <= adderInHsk.io_output_bits_1_last @[port.scala 23:23]
    adder.io_output_ready <= multiply_io_input_io_sumOut_ready @[penlr.scala 23:21]
    adderInHsk.clock <= clock
    adderInHsk.reset <= reset
    adderInHsk.io_input_0_valid <= multiply.io_output_valid @[penlr.scala 19:28]
    adderInHsk.io_input_0_bits_x_0 <= multiply.io_output_bits_x_0 @[penlr.scala 19:28]
    adderInHsk.io_input_0_bits_last <= multiply.io_output_bits_last @[penlr.scala 19:28]
    adderInHsk.io_input_1_valid <= multiply_io_input_io_sumIn_valid @[penlr.scala 20:28]
    adderInHsk.io_input_1_bits_x_0 <= multiply_io_input_io_sumIn_bits_x_0 @[penlr.scala 20:28]
    adderInHsk.io_input_1_bits_last <= multiply_io_input_io_sumIn_bits_last @[penlr.scala 20:28]
    adderInHsk.io_output_ready <= adder.io_input_ready @[port.scala 25:19]
