circuit PECross :
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

  module Accumulator2to1 :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_x_0 : SInt<16>
    input io_input_bits_last : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_x_0 : SInt<16>
    output io_output_bits_last : UInt<1>

    node _io_output_bits_last_T = and(io_input_valid, io_input_ready) @[accumulator2to1.scala 17:77]
    reg io_output_bits_last_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_output_bits_last_r) @[Reg.scala 28:20]
    node _GEN_0 = mux(_io_output_bits_last_T, io_input_bits_last, io_output_bits_last_r) @[Reg.scala 29:18 28:20 29:22]
    node _io_output_bits_x_0_T = and(io_input_valid, io_input_ready) @[accumulator2to1.scala 18:83]
    reg io_output_bits_x_0_r : SInt<16>, clock with :
      reset => (UInt<1>("h0"), io_output_bits_x_0_r) @[Reg.scala 28:20]
    node _sumNxt_T = add(io_output_bits_x_0, io_input_bits_x_0) @[accumulator2to1.scala 19:79]
    node _sumNxt_T_1 = tail(_sumNxt_T, 1) @[accumulator2to1.scala 19:79]
    node _sumNxt_T_2 = asSInt(_sumNxt_T_1) @[accumulator2to1.scala 19:79]
    node _sumNxt_T_3 = mux(io_output_bits_last, io_input_bits_x_0, _sumNxt_T_2) @[accumulator2to1.scala 19:18]
    node sumNxt = _sumNxt_T_3 @[accumulator2to1.scala 16:22 19:12]
    node _GEN_1 = mux(_io_output_bits_x_0_T, sumNxt, io_output_bits_x_0_r) @[Reg.scala 29:18 28:20 29:22]
    io_input_ready <= UInt<1>("h1") @[accumulator2to1.scala 15:20]
    io_output_valid <= io_output_bits_last @[accumulator2to1.scala 20:21]
    io_output_bits_x_0 <= io_output_bits_x_0_r @[accumulator2to1.scala 18:25]
    io_output_bits_last <= io_output_bits_last_r @[accumulator2to1.scala 17:25]
    io_output_bits_last_r <= mux(reset, UInt<1>("h0"), _GEN_0) @[Reg.scala 28:{20,20}]
    io_output_bits_x_0_r <= mux(reset, asSInt(UInt<16>("h0")), _GEN_1) @[Reg.scala 28:{20,20}]

  module Arbiter1ton :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_x_0 : SInt<16>
    input io_input_bits_last : UInt<1>
    input io_sel : UInt<1>
    input io_output_0_ready : UInt<1>
    output io_output_0_valid : UInt<1>
    output io_output_0_bits_x_0 : SInt<16>
    output io_output_0_bits_last : UInt<1>
    input io_output_1_ready : UInt<1>
    output io_output_1_valid : UInt<1>
    output io_output_1_bits_x_0 : SInt<16>
    output io_output_1_bits_last : UInt<1>

    node readyVec_0 = io_output_0_ready @[arbiter1ton.scala 14:24 15:14]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_sel), readyVec_0) @[arbiter1ton.scala 16:{20,20}]
    node readyVec_1 = io_output_1_ready @[arbiter1ton.scala 14:24 15:14]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_sel), readyVec_1, _GEN_0) @[arbiter1ton.scala 16:{20,20}]
    node _io_output_0_valid_T = eq(UInt<1>("h0"), io_sel) @[arbiter1ton.scala 18:60]
    node _io_output_0_valid_T_1 = mux(_io_output_0_valid_T, io_input_valid, UInt<1>("h0")) @[arbiter1ton.scala 18:44]
    node _io_output_1_valid_T = eq(UInt<1>("h1"), io_sel) @[arbiter1ton.scala 18:60]
    node _io_output_1_valid_T_1 = mux(_io_output_1_valid_T, io_input_valid, UInt<1>("h0")) @[arbiter1ton.scala 18:44]
    node _readyVec_io_sel = _GEN_1 @[arbiter1ton.scala 16:20]
    io_input_ready <= _readyVec_io_sel @[arbiter1ton.scala 16:20]
    io_output_0_valid <= _io_output_0_valid_T_1 @[arbiter1ton.scala 18:38]
    io_output_0_bits_x_0 <= io_input_bits_x_0 @[arbiter1ton.scala 19:26]
    io_output_0_bits_last <= io_input_bits_last @[arbiter1ton.scala 19:26]
    io_output_1_valid <= _io_output_1_valid_T_1 @[arbiter1ton.scala 18:38]
    io_output_1_bits_x_0 <= io_input_bits_x_0 @[arbiter1ton.scala 19:26]
    io_output_1_bits_last <= io_input_bits_last @[arbiter1ton.scala 19:26]

  module Arbiternto1 :
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
    input io_sel : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_x_0 : SInt<16>
    output io_output_bits_last : UInt<1>

    node _GEN_0 = validif(eq(UInt<1>("h0"), io_sel), io_input_0_bits_x_0) @[arbiternto1.scala 14:{20,20}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_sel), io_input_1_bits_x_0, _GEN_0) @[arbiternto1.scala 14:{20,20}]
    node _GEN_2 = validif(eq(UInt<1>("h0"), io_sel), io_input_0_bits_last) @[arbiternto1.scala 14:{20,20}]
    node _GEN_3 = mux(eq(UInt<1>("h1"), io_sel), io_input_1_bits_last, _GEN_2) @[arbiternto1.scala 14:{20,20}]
    node _GEN_4 = validif(eq(UInt<1>("h0"), io_sel), io_input_0_valid) @[arbiternto1.scala 15:{21,21}]
    node _GEN_5 = mux(eq(UInt<1>("h1"), io_sel), io_input_1_valid, _GEN_4) @[arbiternto1.scala 15:{21,21}]
    node _io_input_0_ready_T = eq(UInt<1>("h0"), io_sel) @[arbiternto1.scala 17:60]
    node _io_input_0_ready_T_1 = mux(_io_input_0_ready_T, io_output_ready, UInt<1>("h0")) @[arbiternto1.scala 17:44]
    node _io_input_1_ready_T = eq(UInt<1>("h1"), io_sel) @[arbiternto1.scala 17:60]
    node _io_input_1_ready_T_1 = mux(_io_input_1_ready_T, io_output_ready, UInt<1>("h0")) @[arbiternto1.scala 17:44]
    node _io_input_io_sel_bits_x_0 = _GEN_1 @[arbiternto1.scala 14:20]
    node _io_input_io_sel_bits_last = _GEN_3 @[arbiternto1.scala 14:20]
    node _io_input_io_sel_valid = _GEN_5 @[arbiternto1.scala 15:21]
    io_input_0_ready <= _io_input_0_ready_T_1 @[arbiternto1.scala 17:38]
    io_input_1_ready <= _io_input_1_ready_T_1 @[arbiternto1.scala 17:38]
    io_output_valid <= _io_input_io_sel_valid @[arbiternto1.scala 15:21]
    io_output_bits_x_0 <= _io_input_io_sel_bits_x_0 @[arbiternto1.scala 14:20]
    io_output_bits_last <= _io_input_io_sel_bits_last @[arbiternto1.scala 14:20]

  module Hsknto1_1 :
    input clock : Clock
    input reset : UInt<1>
    output io_input_0_ready : UInt<1>
    input io_input_0_valid : UInt<1>
    input io_input_0_bits_x_0 : SInt<8>
    input io_input_0_bits_last : UInt<1>
    output io_input_1_ready : UInt<1>
    input io_input_1_valid : UInt<1>
    input io_input_1_bits_x_0 : SInt<8>
    input io_input_1_bits_last : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_0_x_0 : SInt<8>
    output io_output_bits_0_last : UInt<1>
    output io_output_bits_1_x_0 : SInt<8>
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

  module Hsk1ton :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_0_x_0 : SInt<8>
    input io_input_bits_0_x_1 : SInt<8>
    input io_input_bits_0_last : UInt<1>
    input io_input_bits_1_x_0 : SInt<8>
    input io_input_bits_1_x_1 : SInt<8>
    input io_input_bits_1_last : UInt<1>
    input io_input_bits_2_x_0 : SInt<8>
    input io_input_bits_2_x_1 : SInt<8>
    input io_input_bits_2_last : UInt<1>
    input io_output_0_ready : UInt<1>
    output io_output_0_valid : UInt<1>
    output io_output_0_bits_x_0 : SInt<8>
    output io_output_0_bits_x_1 : SInt<8>
    output io_output_0_bits_last : UInt<1>
    input io_output_1_ready : UInt<1>
    output io_output_1_valid : UInt<1>
    output io_output_1_bits_x_0 : SInt<8>
    output io_output_1_bits_x_1 : SInt<8>
    output io_output_1_bits_last : UInt<1>
    input io_output_2_ready : UInt<1>
    output io_output_2_valid : UInt<1>
    output io_output_2_bits_x_0 : SInt<8>
    output io_output_2_bits_x_1 : SInt<8>
    output io_output_2_bits_last : UInt<1>

    node _io_input_ready_T = and(UInt<1>("h1"), io_output_0_ready) @[hsk1ton.scala 12:58]
    node _io_input_ready_T_1 = and(_io_input_ready_T, io_output_1_ready) @[hsk1ton.scala 12:58]
    node _io_input_ready_T_2 = and(_io_input_ready_T_1, io_output_2_ready) @[hsk1ton.scala 12:58]
    node _io_output_0_valid_T = not(io_output_0_ready) @[hsk1ton.scala 14:74]
    node _io_output_0_valid_T_1 = mux(UInt<1>("h1"), UInt<1>("h1"), io_output_0_ready) @[hsk1ton.scala 15:33]
    node _io_output_0_valid_T_2 = mux(UInt<1>("h0"), UInt<1>("h1"), io_output_1_ready) @[hsk1ton.scala 15:33]
    node _io_output_0_valid_T_3 = mux(UInt<1>("h0"), UInt<1>("h1"), io_output_2_ready) @[hsk1ton.scala 15:33]
    node _io_output_0_valid_T_4 = and(UInt<1>("h1"), _io_output_0_valid_T_1) @[hsk1ton.scala 15:72]
    node _io_output_0_valid_T_5 = and(_io_output_0_valid_T_4, _io_output_0_valid_T_2) @[hsk1ton.scala 15:72]
    node _io_output_0_valid_T_6 = and(_io_output_0_valid_T_5, _io_output_0_valid_T_3) @[hsk1ton.scala 15:72]
    node _io_output_0_valid_T_7 = or(_io_output_0_valid_T, _io_output_0_valid_T_6) @[hsk1ton.scala 14:82]
    node _io_output_0_valid_T_8 = and(io_input_valid, _io_output_0_valid_T_7) @[hsk1ton.scala 14:72]
    node _io_output_1_valid_T = not(io_output_1_ready) @[hsk1ton.scala 14:74]
    node _io_output_1_valid_T_1 = mux(UInt<1>("h0"), UInt<1>("h1"), io_output_0_ready) @[hsk1ton.scala 15:33]
    node _io_output_1_valid_T_2 = mux(UInt<1>("h1"), UInt<1>("h1"), io_output_1_ready) @[hsk1ton.scala 15:33]
    node _io_output_1_valid_T_3 = mux(UInt<1>("h0"), UInt<1>("h1"), io_output_2_ready) @[hsk1ton.scala 15:33]
    node _io_output_1_valid_T_4 = and(UInt<1>("h1"), _io_output_1_valid_T_1) @[hsk1ton.scala 15:72]
    node _io_output_1_valid_T_5 = and(_io_output_1_valid_T_4, _io_output_1_valid_T_2) @[hsk1ton.scala 15:72]
    node _io_output_1_valid_T_6 = and(_io_output_1_valid_T_5, _io_output_1_valid_T_3) @[hsk1ton.scala 15:72]
    node _io_output_1_valid_T_7 = or(_io_output_1_valid_T, _io_output_1_valid_T_6) @[hsk1ton.scala 14:82]
    node _io_output_1_valid_T_8 = and(io_input_valid, _io_output_1_valid_T_7) @[hsk1ton.scala 14:72]
    node _io_output_2_valid_T = not(io_output_2_ready) @[hsk1ton.scala 14:74]
    node _io_output_2_valid_T_1 = mux(UInt<1>("h0"), UInt<1>("h1"), io_output_0_ready) @[hsk1ton.scala 15:33]
    node _io_output_2_valid_T_2 = mux(UInt<1>("h0"), UInt<1>("h1"), io_output_1_ready) @[hsk1ton.scala 15:33]
    node _io_output_2_valid_T_3 = mux(UInt<1>("h1"), UInt<1>("h1"), io_output_2_ready) @[hsk1ton.scala 15:33]
    node _io_output_2_valid_T_4 = and(UInt<1>("h1"), _io_output_2_valid_T_1) @[hsk1ton.scala 15:72]
    node _io_output_2_valid_T_5 = and(_io_output_2_valid_T_4, _io_output_2_valid_T_2) @[hsk1ton.scala 15:72]
    node _io_output_2_valid_T_6 = and(_io_output_2_valid_T_5, _io_output_2_valid_T_3) @[hsk1ton.scala 15:72]
    node _io_output_2_valid_T_7 = or(_io_output_2_valid_T, _io_output_2_valid_T_6) @[hsk1ton.scala 14:82]
    node _io_output_2_valid_T_8 = and(io_input_valid, _io_output_2_valid_T_7) @[hsk1ton.scala 14:72]
    io_input_ready <= _io_input_ready_T_2 @[hsk1ton.scala 12:20]
    io_output_0_valid <= _io_output_0_valid_T_8 @[hsk1ton.scala 14:55]
    io_output_0_bits_x_0 <= io_input_bits_0_x_0 @[hsk1ton.scala 13:54]
    io_output_0_bits_x_1 <= io_input_bits_0_x_1 @[hsk1ton.scala 13:54]
    io_output_0_bits_last <= io_input_bits_0_last @[hsk1ton.scala 13:54]
    io_output_1_valid <= _io_output_1_valid_T_8 @[hsk1ton.scala 14:55]
    io_output_1_bits_x_0 <= io_input_bits_1_x_0 @[hsk1ton.scala 13:54]
    io_output_1_bits_x_1 <= io_input_bits_1_x_1 @[hsk1ton.scala 13:54]
    io_output_1_bits_last <= io_input_bits_1_last @[hsk1ton.scala 13:54]
    io_output_2_valid <= _io_output_2_valid_T_8 @[hsk1ton.scala 14:55]
    io_output_2_bits_x_0 <= io_input_bits_2_x_0 @[hsk1ton.scala 13:54]
    io_output_2_bits_x_1 <= io_input_bits_2_x_1 @[hsk1ton.scala 13:54]
    io_output_2_bits_last <= io_input_bits_2_last @[hsk1ton.scala 13:54]

  module Arbiternto1_1 :
    input clock : Clock
    input reset : UInt<1>
    output io_input_0_ready : UInt<1>
    input io_input_0_valid : UInt<1>
    input io_input_0_bits_x_0 : SInt<8>
    input io_input_0_bits_last : UInt<1>
    output io_input_1_ready : UInt<1>
    input io_input_1_valid : UInt<1>
    input io_input_1_bits_x_0 : SInt<8>
    input io_input_1_bits_last : UInt<1>
    input io_sel : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_x_0 : SInt<8>
    output io_output_bits_last : UInt<1>

    node _GEN_0 = validif(eq(UInt<1>("h0"), io_sel), io_input_0_bits_x_0) @[arbiternto1.scala 14:{20,20}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_sel), io_input_1_bits_x_0, _GEN_0) @[arbiternto1.scala 14:{20,20}]
    node _GEN_2 = validif(eq(UInt<1>("h0"), io_sel), io_input_0_bits_last) @[arbiternto1.scala 14:{20,20}]
    node _GEN_3 = mux(eq(UInt<1>("h1"), io_sel), io_input_1_bits_last, _GEN_2) @[arbiternto1.scala 14:{20,20}]
    node _GEN_4 = validif(eq(UInt<1>("h0"), io_sel), io_input_0_valid) @[arbiternto1.scala 15:{21,21}]
    node _GEN_5 = mux(eq(UInt<1>("h1"), io_sel), io_input_1_valid, _GEN_4) @[arbiternto1.scala 15:{21,21}]
    node _io_input_0_ready_T = eq(UInt<1>("h0"), io_sel) @[arbiternto1.scala 17:60]
    node _io_input_0_ready_T_1 = mux(_io_input_0_ready_T, io_output_ready, UInt<1>("h0")) @[arbiternto1.scala 17:44]
    node _io_input_1_ready_T = eq(UInt<1>("h1"), io_sel) @[arbiternto1.scala 17:60]
    node _io_input_1_ready_T_1 = mux(_io_input_1_ready_T, io_output_ready, UInt<1>("h0")) @[arbiternto1.scala 17:44]
    node _io_input_io_sel_bits_x_0 = _GEN_1 @[arbiternto1.scala 14:20]
    node _io_input_io_sel_bits_last = _GEN_3 @[arbiternto1.scala 14:20]
    node _io_input_io_sel_valid = _GEN_5 @[arbiternto1.scala 15:21]
    io_input_0_ready <= _io_input_0_ready_T_1 @[arbiternto1.scala 17:38]
    io_input_1_ready <= _io_input_1_ready_T_1 @[arbiternto1.scala 17:38]
    io_output_valid <= _io_input_io_sel_valid @[arbiternto1.scala 15:21]
    io_output_bits_x_0 <= _io_input_io_sel_bits_x_0 @[arbiternto1.scala 14:20]
    io_output_bits_last <= _io_input_io_sel_bits_last @[arbiternto1.scala 14:20]

  module Arbiter1ton_1 :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_x_0 : SInt<8>
    input io_input_bits_x_1 : SInt<8>
    input io_input_bits_last : UInt<1>
    input io_sel : UInt<1>
    input io_output_0_ready : UInt<1>
    output io_output_0_valid : UInt<1>
    output io_output_0_bits_x_0 : SInt<8>
    output io_output_0_bits_x_1 : SInt<8>
    output io_output_0_bits_last : UInt<1>
    input io_output_1_ready : UInt<1>
    output io_output_1_valid : UInt<1>
    output io_output_1_bits_x_0 : SInt<8>
    output io_output_1_bits_x_1 : SInt<8>
    output io_output_1_bits_last : UInt<1>

    node readyVec_0 = io_output_0_ready @[arbiter1ton.scala 14:24 15:14]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_sel), readyVec_0) @[arbiter1ton.scala 16:{20,20}]
    node readyVec_1 = io_output_1_ready @[arbiter1ton.scala 14:24 15:14]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_sel), readyVec_1, _GEN_0) @[arbiter1ton.scala 16:{20,20}]
    node _io_output_0_valid_T = eq(UInt<1>("h0"), io_sel) @[arbiter1ton.scala 18:60]
    node _io_output_0_valid_T_1 = mux(_io_output_0_valid_T, io_input_valid, UInt<1>("h0")) @[arbiter1ton.scala 18:44]
    node _io_output_1_valid_T = eq(UInt<1>("h1"), io_sel) @[arbiter1ton.scala 18:60]
    node _io_output_1_valid_T_1 = mux(_io_output_1_valid_T, io_input_valid, UInt<1>("h0")) @[arbiter1ton.scala 18:44]
    node _readyVec_io_sel = _GEN_1 @[arbiter1ton.scala 16:20]
    io_input_ready <= _readyVec_io_sel @[arbiter1ton.scala 16:20]
    io_output_0_valid <= _io_output_0_valid_T_1 @[arbiter1ton.scala 18:38]
    io_output_0_bits_x_0 <= io_input_bits_x_0 @[arbiter1ton.scala 19:26]
    io_output_0_bits_x_1 <= io_input_bits_x_1 @[arbiter1ton.scala 19:26]
    io_output_0_bits_last <= io_input_bits_last @[arbiter1ton.scala 19:26]
    io_output_1_valid <= _io_output_1_valid_T_1 @[arbiter1ton.scala 18:38]
    io_output_1_bits_x_0 <= io_input_bits_x_0 @[arbiter1ton.scala 19:26]
    io_output_1_bits_x_1 <= io_input_bits_x_1 @[arbiter1ton.scala 19:26]
    io_output_1_bits_last <= io_input_bits_last @[arbiter1ton.scala 19:26]

  module PECross :
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
    input multiply_io_input_io_statSel : UInt<2>
    input multiply_io_input_io_weiEn : UInt<1>
    input multiply_io_input_io_actEn : UInt<1>
    output multiply_io_input_io_actIn_ready : UInt<1>
    input multiply_io_input_io_actIn_valid : UInt<1>
    input multiply_io_input_io_actIn_bits_x_0 : SInt<8>
    input multiply_io_input_io_actIn_bits_last : UInt<1>
    output multiply_io_input_io_weiIn_ready : UInt<1>
    input multiply_io_input_io_weiIn_valid : UInt<1>
    input multiply_io_input_io_weiIn_bits_x_0 : SInt<8>
    input multiply_io_input_io_weiIn_bits_last : UInt<1>
    input multiply_io_input_io_actOut_ready : UInt<1>
    output multiply_io_input_io_actOut_valid : UInt<1>
    output multiply_io_input_io_actOut_bits_x_0 : SInt<8>
    output multiply_io_input_io_actOut_bits_last : UInt<1>
    input multiply_io_input_io_weiOut_ready : UInt<1>
    output multiply_io_input_io_weiOut_valid : UInt<1>
    output multiply_io_input_io_weiOut_bits_x_0 : SInt<8>
    output multiply_io_input_io_weiOut_bits_last : UInt<1>

    inst multiply of Multiply @[penlr.scala 14:26]
    inst adder of Adder2to1 @[penlr.scala 17:23]
    inst adderInHsk of Hsknto1 @[penlr.scala 18:28]
    inst accumulator of Accumulator2to1 @[pe.scala 19:29]
    inst multiplyOutMux of Arbiter1ton @[pe.scala 20:32]
    inst sumOutMux of Arbiternto1 @[pe.scala 21:27]
    inst actWeiInHsk of Hsknto1_1 @[pecross.scala 14:29]
    inst multiplyInHsk of Hsk1ton @[pecross.scala 15:31]
    inst weiInMux of Arbiternto1_1 @[pecross.scala 16:26]
    inst actInMux of Arbiternto1_1 @[pecross.scala 17:26]
    inst multiplyInMux of Arbiter1ton_1 @[pecross.scala 18:31]
    inst actOutMux of Arbiter1ton_1 @[pecross.scala 19:27]
    inst weiOutMux of Arbiter1ton_1 @[pecross.scala 20:27]
    inst adderInMux of Arbiternto1 @[pecross.scala 21:28]
    inst actOutHsk of PipelineHsk @[pecross.scala 47:27]
    inst weiOutHsk of PipelineHsk @[pecross.scala 58:27]
    node _weiOut_T = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pe.scala 15:62]
    node _weiOut_T_1 = and(_weiOut_T, multiply_io_input_io_weiEn) @[pe.scala 15:74]
    reg weiOut : SInt<8>, clock with :
      reset => (UInt<1>("h0"), weiOut) @[Reg.scala 16:16]
    node _GEN_0 = mux(_weiOut_T_1, multiply_io_input_io_actWeiIn_bits_x_1, weiOut) @[Reg.scala 16:16 17:{18,22}]
    node _multiply_io_input_bits_x_1_T = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pe.scala 16:50]
    node _multiply_io_input_bits_x_1_T_1 = mux(_multiply_io_input_bits_x_1_T, weiOut, multiply_io_input_io_actWeiIn_bits_x_1) @[pe.scala 16:39]
    node _multiplyOutMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h2")) @[pe.scala 22:41]
    node _multiplyOutMux_io_sel_T_1 = and(_multiplyOutMux_io_sel_T, multiply_io_input_io_actEn) @[pe.scala 22:53]
    node _sumOutMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h2")) @[pe.scala 23:36]
    node _sumOutMux_io_sel_T_1 = and(_sumOutMux_io_sel_T, multiply_io_input_io_actEn) @[pe.scala 23:48]
    reg io_actOut_bits_x_0_r : SInt<8>, clock with :
      reset => (UInt<1>("h0"), io_actOut_bits_x_0_r) @[Reg.scala 16:16]
    node _GEN_1 = mux(actOutHsk.io_regen_0, actOutMux.io_output_0_bits_x_0, io_actOut_bits_x_0_r) @[Reg.scala 16:16 17:{18,22}]
    reg io_weiOut_bits_x_0_r : SInt<8>, clock with :
      reset => (UInt<1>("h0"), io_weiOut_bits_x_0_r) @[Reg.scala 16:16]
    node _GEN_2 = mux(weiOutHsk.io_regen_0, weiOutMux.io_output_0_bits_x_1, io_weiOut_bits_x_0_r) @[Reg.scala 16:16 17:{18,22}]
    node _actInMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pecross.scala 68:35]
    node _actInMux_io_sel_T_1 = not(multiply_io_input_io_weiEn) @[pecross.scala 68:49]
    node _actInMux_io_sel_T_2 = and(_actInMux_io_sel_T, _actInMux_io_sel_T_1) @[pecross.scala 68:47]
    node _weiInMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pecross.scala 69:35]
    node _weiInMux_io_sel_T_1 = and(_weiInMux_io_sel_T, multiply_io_input_io_weiEn) @[pecross.scala 69:47]
    node _multiplyInMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pecross.scala 70:40]
    node _multiplyInMux_io_sel_T_1 = not(multiply_io_input_io_weiEn) @[pecross.scala 70:54]
    node _multiplyInMux_io_sel_T_2 = and(_multiplyInMux_io_sel_T, _multiplyInMux_io_sel_T_1) @[pecross.scala 70:52]
    node _actOutMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pecross.scala 71:36]
    node _actOutMux_io_sel_T_1 = not(multiply_io_input_io_weiEn) @[pecross.scala 71:50]
    node _actOutMux_io_sel_T_2 = and(_actOutMux_io_sel_T, _actOutMux_io_sel_T_1) @[pecross.scala 71:48]
    node _weiOutMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pecross.scala 72:36]
    node _weiOutMux_io_sel_T_1 = and(_weiOutMux_io_sel_T, multiply_io_input_io_weiEn) @[pecross.scala 72:48]
    node _multiply_io_input_bits_x_1_T_2 = eq(multiply_io_input_io_statSel, UInt<2>("h1")) @[pecross.scala 73:51]
    node _multiply_io_input_bits_x_1_T_3 = and(_multiply_io_input_bits_x_1_T_2, multiply_io_input_io_weiEn) @[pecross.scala 73:63]
    node _multiply_io_input_bits_x_1_T_4 = mux(_multiply_io_input_bits_x_1_T_3, multiply_io_input_io_weiOut_bits_x_0, multiplyInMux.io_output_0_bits_x_1) @[pecross.scala 73:39]
    node _adderInMux_io_sel_T = eq(multiply_io_input_io_statSel, UInt<2>("h2")) @[pecross.scala 81:37]
    node _adderInMux_io_sel_T_1 = not(multiply_io_input_io_actEn) @[pecross.scala 81:51]
    node _adderInMux_io_sel_T_2 = and(_adderInMux_io_sel_T, _adderInMux_io_sel_T_1) @[pecross.scala 81:49]
    multiply_io_input_io_actWeiIn_ready <= multiply.io_input_ready @[penlr.scala 15:23]
    multiply_io_input_io_sumIn_ready <= adderInHsk.io_input_1_ready @[penlr.scala 20:28]
    multiply_io_input_io_sumOut_valid <= sumOutMux.io_output_valid @[pe.scala 29:25]
    multiply_io_input_io_sumOut_bits_x_0 <= sumOutMux.io_output_bits_x_0 @[pe.scala 29:25]
    multiply_io_input_io_sumOut_bits_last <= sumOutMux.io_output_bits_last @[pe.scala 29:25]
    multiply_io_input_io_actIn_ready <= actInMux.io_input_0_ready @[pecross.scala 23:14]
    multiply_io_input_io_weiIn_ready <= weiInMux.io_input_0_ready @[pecross.scala 28:14]
    multiply_io_input_io_actOut_valid <= actOutHsk.io_validNxt @[pecross.scala 50:21]
    multiply_io_input_io_actOut_bits_x_0 <= io_actOut_bits_x_0_r @[pecross.scala 54:25]
    multiply_io_input_io_actOut_bits_last <= actOutHsk.io_lastNxt @[pecross.scala 53:25]
    multiply_io_input_io_weiOut_valid <= weiOutHsk.io_validNxt @[pecross.scala 61:21]
    multiply_io_input_io_weiOut_bits_x_0 <= io_weiOut_bits_x_0_r @[pecross.scala 65:25]
    multiply_io_input_io_weiOut_bits_last <= weiOutHsk.io_lastNxt @[pecross.scala 64:25]
    multiply.clock <= clock
    multiply.reset <= reset
    multiply.io_input_valid <= multiplyInMux.io_output_0_valid @[pecross.scala 42:32]
    multiply.io_input_bits_x_0 <= multiplyInMux.io_output_0_bits_x_0 @[pecross.scala 42:32]
    multiply.io_input_bits_x_1 <= _multiply_io_input_bits_x_1_T_4 @[pecross.scala 73:33]
    multiply.io_input_bits_last <= multiplyInMux.io_output_0_bits_last @[pecross.scala 42:32]
    multiply.io_output_ready <= multiplyOutMux.io_input_ready @[pe.scala 24:29]
    adder.clock <= clock
    adder.reset <= reset
    adder.io_input_valid <= adderInHsk.io_output_valid @[port.scala 24:19]
    adder.io_input_bits_x_0 <= adderInHsk.io_output_bits_0_x_0 @[port.scala 20:37]
    adder.io_input_bits_x_1 <= adderInHsk.io_output_bits_1_x_0 @[port.scala 20:37]
    adder.io_input_bits_last <= adderInHsk.io_output_bits_1_last @[port.scala 23:23]
    adder.io_output_ready <= sumOutMux.io_input_0_ready @[pe.scala 27:27]
    adderInHsk.clock <= clock
    adderInHsk.reset <= reset
    adderInHsk.io_input_0_valid <= adderInMux.io_output_valid @[pecross.scala 80:26]
    adderInHsk.io_input_0_bits_x_0 <= adderInMux.io_output_bits_x_0 @[pecross.scala 80:26]
    adderInHsk.io_input_0_bits_last <= adderInMux.io_output_bits_last @[pecross.scala 80:26]
    adderInHsk.io_input_1_valid <= multiply_io_input_io_sumIn_valid @[penlr.scala 20:28]
    adderInHsk.io_input_1_bits_x_0 <= multiply_io_input_io_sumIn_bits_x_0 @[penlr.scala 20:28]
    adderInHsk.io_input_1_bits_last <= multiply_io_input_io_sumIn_bits_last @[penlr.scala 20:28]
    adderInHsk.io_output_ready <= adder.io_input_ready @[port.scala 25:19]
    weiOut <= _GEN_0
    accumulator.clock <= clock
    accumulator.reset <= reset
    accumulator.io_input_valid <= multiplyOutMux.io_output_1_valid @[pe.scala 26:33]
    accumulator.io_input_bits_x_0 <= multiplyOutMux.io_output_1_bits_x_0 @[pe.scala 26:33]
    accumulator.io_input_bits_last <= multiplyOutMux.io_output_1_bits_last @[pe.scala 26:33]
    accumulator.io_output_ready <= sumOutMux.io_input_1_ready @[pe.scala 28:27]
    multiplyOutMux.clock <= clock
    multiplyOutMux.reset <= reset
    multiplyOutMux.io_input_valid <= multiply.io_output_valid @[pe.scala 24:29]
    multiplyOutMux.io_input_bits_x_0 <= multiply.io_output_bits_x_0 @[pe.scala 24:29]
    multiplyOutMux.io_input_bits_last <= multiply.io_output_bits_last @[pe.scala 24:29]
    multiplyOutMux.io_sel <= _multiplyOutMux_io_sel_T_1 @[pe.scala 22:27]
    multiplyOutMux.io_output_0_ready <= adderInMux.io_input_0_ready @[pecross.scala 76:33]
    multiplyOutMux.io_output_1_ready <= accumulator.io_input_ready @[pe.scala 26:33]
    sumOutMux.clock <= clock
    sumOutMux.reset <= reset
    sumOutMux.io_input_0_valid <= adder.io_output_valid @[pe.scala 27:27]
    sumOutMux.io_input_0_bits_x_0 <= adder.io_output_bits_x_0 @[pe.scala 27:27]
    sumOutMux.io_input_0_bits_last <= adder.io_output_bits_last @[pe.scala 27:27]
    sumOutMux.io_input_1_valid <= accumulator.io_output_valid @[pe.scala 28:27]
    sumOutMux.io_input_1_bits_x_0 <= accumulator.io_output_bits_x_0 @[pe.scala 28:27]
    sumOutMux.io_input_1_bits_last <= accumulator.io_output_bits_last @[pe.scala 28:27]
    sumOutMux.io_sel <= _sumOutMux_io_sel_T_1 @[pe.scala 23:22]
    sumOutMux.io_output_ready <= multiply_io_input_io_sumOut_ready @[pe.scala 29:25]
    actWeiInHsk.clock <= clock
    actWeiInHsk.reset <= reset
    actWeiInHsk.io_input_0_valid <= actInMux.io_output_valid @[pecross.scala 33:24]
    actWeiInHsk.io_input_0_bits_x_0 <= actInMux.io_output_bits_x_0 @[pecross.scala 33:24]
    actWeiInHsk.io_input_0_bits_last <= actInMux.io_output_bits_last @[pecross.scala 33:24]
    actWeiInHsk.io_input_1_valid <= weiInMux.io_output_valid @[pecross.scala 34:24]
    actWeiInHsk.io_input_1_bits_x_0 <= weiInMux.io_output_bits_x_0 @[pecross.scala 34:24]
    actWeiInHsk.io_input_1_bits_last <= weiInMux.io_output_bits_last @[pecross.scala 34:24]
    actWeiInHsk.io_output_ready <= multiplyInHsk.io_input_ready @[pecross.scala 36:33]
    multiplyInHsk.clock <= clock
    multiplyInHsk.reset <= reset
    multiplyInHsk.io_input_valid <= actWeiInHsk.io_output_valid @[pecross.scala 35:34]
    multiplyInHsk.io_input_bits_0_x_0 <= actWeiInHsk.io_output_bits_0_x_0 @[port.scala 32:32]
    multiplyInHsk.io_input_bits_0_x_1 <= actWeiInHsk.io_output_bits_1_x_0 @[port.scala 32:32]
    multiplyInHsk.io_input_bits_0_last <= actWeiInHsk.io_output_bits_0_last @[port.scala 35:18]
    multiplyInHsk.io_input_bits_1_x_0 <= actWeiInHsk.io_output_bits_0_x_0 @[port.scala 32:32]
    multiplyInHsk.io_input_bits_1_x_1 <= actWeiInHsk.io_output_bits_1_x_0 @[port.scala 32:32]
    multiplyInHsk.io_input_bits_1_last <= actWeiInHsk.io_output_bits_0_last @[port.scala 35:18]
    multiplyInHsk.io_input_bits_2_x_0 <= actWeiInHsk.io_output_bits_0_x_0 @[port.scala 32:32]
    multiplyInHsk.io_input_bits_2_x_1 <= actWeiInHsk.io_output_bits_1_x_0 @[port.scala 32:32]
    multiplyInHsk.io_input_bits_2_last <= actWeiInHsk.io_output_bits_1_last @[port.scala 35:18]
    multiplyInHsk.io_output_0_ready <= multiplyInMux.io_input_ready @[pecross.scala 41:28]
    multiplyInHsk.io_output_1_ready <= actOutMux.io_input_ready @[pecross.scala 45:24]
    multiplyInHsk.io_output_2_ready <= weiOutMux.io_input_ready @[pecross.scala 56:24]
    weiInMux.clock <= clock
    weiInMux.reset <= reset
    weiInMux.io_input_0_valid <= multiply_io_input_io_weiIn_valid @[pecross.scala 28:14]
    weiInMux.io_input_0_bits_x_0 <= multiply_io_input_io_weiIn_bits_x_0 @[pecross.scala 28:14]
    weiInMux.io_input_0_bits_last <= multiply_io_input_io_weiIn_bits_last @[pecross.scala 28:14]
    weiInMux.io_input_1_valid <= UInt<1>("h1") @[pecross.scala 29:32]
    weiInMux.io_input_1_bits_x_0 <= pad(shl(asSInt(UInt<1>("h0")), 4), 8) @[pecross.scala 30:36]
    weiInMux.io_input_1_bits_last <= UInt<1>("h0") @[pecross.scala 31:36]
    weiInMux.io_sel <= _weiInMux_io_sel_T_1 @[pecross.scala 69:21]
    weiInMux.io_output_ready <= actWeiInHsk.io_input_1_ready @[pecross.scala 34:24]
    actInMux.clock <= clock
    actInMux.reset <= reset
    actInMux.io_input_0_valid <= multiply_io_input_io_actIn_valid @[pecross.scala 23:14]
    actInMux.io_input_0_bits_x_0 <= multiply_io_input_io_actIn_bits_x_0 @[pecross.scala 23:14]
    actInMux.io_input_0_bits_last <= multiply_io_input_io_actIn_bits_last @[pecross.scala 23:14]
    actInMux.io_input_1_valid <= UInt<1>("h1") @[pecross.scala 24:32]
    actInMux.io_input_1_bits_x_0 <= pad(shl(asSInt(UInt<1>("h0")), 4), 8) @[pecross.scala 25:36]
    actInMux.io_input_1_bits_last <= UInt<1>("h0") @[pecross.scala 26:36]
    actInMux.io_sel <= _actInMux_io_sel_T_2 @[pecross.scala 68:21]
    actInMux.io_output_ready <= actWeiInHsk.io_input_0_ready @[pecross.scala 33:24]
    multiplyInMux.clock <= clock
    multiplyInMux.reset <= reset
    multiplyInMux.io_input_valid <= multiplyInHsk.io_output_0_valid @[pecross.scala 41:28]
    multiplyInMux.io_input_bits_x_0 <= multiplyInHsk.io_output_0_bits_x_0 @[pecross.scala 41:28]
    multiplyInMux.io_input_bits_x_1 <= multiplyInHsk.io_output_0_bits_x_1 @[pecross.scala 41:28]
    multiplyInMux.io_input_bits_last <= multiplyInHsk.io_output_0_bits_last @[pecross.scala 41:28]
    multiplyInMux.io_sel <= _multiplyInMux_io_sel_T_2 @[pecross.scala 70:26]
    multiplyInMux.io_output_0_ready <= multiply.io_input_ready @[pecross.scala 42:32]
    multiplyInMux.io_output_1_ready <= UInt<1>("h1") @[pecross.scala 43:38]
    actOutMux.clock <= clock
    actOutMux.reset <= reset
    actOutMux.io_input_valid <= multiplyInHsk.io_output_1_valid @[pecross.scala 45:24]
    actOutMux.io_input_bits_x_0 <= multiplyInHsk.io_output_1_bits_x_0 @[pecross.scala 45:24]
    actOutMux.io_input_bits_x_1 <= multiplyInHsk.io_output_1_bits_x_1 @[pecross.scala 45:24]
    actOutMux.io_input_bits_last <= multiplyInHsk.io_output_1_bits_last @[pecross.scala 45:24]
    actOutMux.io_sel <= _actOutMux_io_sel_T_2 @[pecross.scala 71:22]
    actOutMux.io_output_0_ready <= actOutHsk.io_readyPre @[pecross.scala 49:34]
    actOutMux.io_output_1_ready <= UInt<1>("h1") @[pecross.scala 46:34]
    weiOutMux.clock <= clock
    weiOutMux.reset <= reset
    weiOutMux.io_input_valid <= multiplyInHsk.io_output_2_valid @[pecross.scala 56:24]
    weiOutMux.io_input_bits_x_0 <= multiplyInHsk.io_output_2_bits_x_0 @[pecross.scala 56:24]
    weiOutMux.io_input_bits_x_1 <= multiplyInHsk.io_output_2_bits_x_1 @[pecross.scala 56:24]
    weiOutMux.io_input_bits_last <= multiplyInHsk.io_output_2_bits_last @[pecross.scala 56:24]
    weiOutMux.io_sel <= _weiOutMux_io_sel_T_1 @[pecross.scala 72:22]
    weiOutMux.io_output_0_ready <= weiOutHsk.io_readyPre @[pecross.scala 60:34]
    weiOutMux.io_output_1_ready <= UInt<1>("h1") @[pecross.scala 57:34]
    adderInMux.clock <= clock
    adderInMux.reset <= reset
    adderInMux.io_input_0_valid <= multiplyOutMux.io_output_0_valid @[pecross.scala 76:33]
    adderInMux.io_input_0_bits_x_0 <= multiplyOutMux.io_output_0_bits_x_0 @[pecross.scala 76:33]
    adderInMux.io_input_0_bits_last <= multiplyOutMux.io_output_0_bits_last @[pecross.scala 76:33]
    adderInMux.io_input_1_valid <= UInt<1>("h1") @[pecross.scala 77:34]
    adderInMux.io_input_1_bits_x_0 <= pad(shl(asSInt(UInt<1>("h0")), 8), 16) @[pecross.scala 78:38]
    adderInMux.io_input_1_bits_last <= UInt<1>("h0") @[pecross.scala 79:38]
    adderInMux.io_sel <= _adderInMux_io_sel_T_2 @[pecross.scala 81:23]
    adderInMux.io_output_ready <= adderInHsk.io_input_0_ready @[pecross.scala 80:26]
    actOutHsk.clock <= clock
    actOutHsk.reset <= reset
    actOutHsk.io_validPre <= actOutMux.io_output_0_valid @[pecross.scala 48:27]
    actOutHsk.io_lastPre <= actOutMux.io_output_0_bits_last @[pecross.scala 52:26]
    actOutHsk.io_readyNxt <= multiply_io_input_io_actOut_ready @[pecross.scala 51:27]
    io_actOut_bits_x_0_r <= _GEN_1
    weiOutHsk.clock <= clock
    weiOutHsk.reset <= reset
    weiOutHsk.io_validPre <= weiOutMux.io_output_0_valid @[pecross.scala 59:27]
    weiOutHsk.io_lastPre <= weiOutMux.io_output_0_bits_last @[pecross.scala 63:26]
    weiOutHsk.io_readyNxt <= multiply_io_input_io_weiOut_ready @[pecross.scala 62:27]
    io_weiOut_bits_x_0_r <= _GEN_2
