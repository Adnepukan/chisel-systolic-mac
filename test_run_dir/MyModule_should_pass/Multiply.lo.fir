circuit Multiply :
  module CounterHsk :
    input clock : Clock
    input reset : UInt<1>
    input validPre : UInt<1>
    output readyPre : UInt<1>
    output validNxt : UInt<1>
    input readyNxt : UInt<1>
    output regen : UInt<1>
    input rst : AsyncReset

    reg counter : UInt<3>, clock with :
      reset => (rst, UInt<3>("h0")) @[Reg.scala 28:20]
    node _counterEn_T = and(validNxt, readyNxt) @[counterhsk.scala 28:30]
    node _counterEn_T_1 = or(_counterEn_T, regen) @[counterhsk.scala 28:39]
    node counterEn = _counterEn_T_1 @[counterhsk.scala 20:29 28:19]
    node _counterNxt_T = eq(counter, UInt<3>("h4")) @[counterhsk.scala 23:20]
    node _counterNxt_T_1 = and(validPre, readyPre) @[counterhsk.scala 24:25]
    node _counterNxt_T_2 = mux(_counterNxt_T_1, UInt<3>("h1"), UInt<3>("h0")) @[counterhsk.scala 24:16]
    node _counterNxt_T_3 = add(counter, UInt<3>("h1")) @[counterhsk.scala 25:20]
    node _counterNxt_T_4 = tail(_counterNxt_T_3, 1) @[counterhsk.scala 25:20]
    node _counterNxt_T_5 = mux(_counterNxt_T, _counterNxt_T_2, _counterNxt_T_4) @[counterhsk.scala 22:26]
    node counterNxt = _counterNxt_T_5 @[counterhsk.scala 19:30 22:20]
    node _GEN_0 = mux(counterEn, counterNxt, counter) @[Reg.scala 29:18 28:20 29:22]
    node _regen_T = and(validPre, readyPre) @[counterhsk.scala 27:26]
    node _regen_T_1 = eq(counter, UInt<3>("h0")) @[counterhsk.scala 27:47]
    node _regen_T_2 = eq(counter, UInt<3>("h4")) @[counterhsk.scala 27:79]
    node _regen_T_3 = or(_regen_T_1, _regen_T_2) @[counterhsk.scala 27:70]
    node _regen_T_4 = not(_regen_T_3) @[counterhsk.scala 27:37]
    node _regen_T_5 = or(_regen_T, _regen_T_4) @[counterhsk.scala 27:35]
    node _readyPre_T = eq(counter, UInt<3>("h0")) @[counterhsk.scala 29:29]
    node _readyPre_T_1 = and(validNxt, readyNxt) @[counterhsk.scala 29:61]
    node _readyPre_T_2 = or(_readyPre_T, _readyPre_T_1) @[counterhsk.scala 29:52]
    node _validNxt_T = eq(counter, UInt<3>("h4")) @[counterhsk.scala 30:28]
    readyPre <= _readyPre_T_2 @[counterhsk.scala 29:18]
    validNxt <= _validNxt_T @[counterhsk.scala 30:18]
    regen <= _regen_T_5 @[counterhsk.scala 27:15]
    counter <= _GEN_0 @[Reg.scala 28:{20,20}]

  module Multiply :
    input clock : Clock
    input reset : UInt<1>
    output in_ready : UInt<1>
    input in_valid : UInt<1>
    input in_bits_x_0 : SInt<8>
    input in_bits_x_1 : SInt<8>
    input in_bits_last : UInt<1>
    input out_ready : UInt<1>
    output out_valid : UInt<1>
    output out_bits_x_0 : SInt<16>
    output out_bits_last : UInt<1>
    input rst : AsyncReset

    inst counterHsk of CounterHsk @[multiply.scala 19:28]
    reg in0 : SInt<8>, clock with :
      reset => (UInt<1>("h0"), in0) @[Reg.scala 16:16]
    node _in0Nxt_T = and(in_valid, in_ready) @[multiply.scala 30:27]
    node _in0Nxt_T_1 = shl(in_bits_x_0, 2) @[multiply.scala 30:50]
    node _in0Nxt_T_2 = shl(in0, 2) @[multiply.scala 30:58]
    node _in0Nxt_T_3 = mux(_in0Nxt_T, _in0Nxt_T_1, _in0Nxt_T_2) @[multiply.scala 30:18]
    node in0Nxt = asSInt(bits(_in0Nxt_T_3, 7, 0)) @[multiply.scala 26:22 30:12]
    node _GEN_0 = mux(counterHsk.regen, in0Nxt, in0) @[Reg.scala 16:16 17:{18,22}]
    node _in1_T = and(in_valid, in_ready) @[multiply.scala 28:47]
    reg in1 : SInt<8>, clock with :
      reset => (UInt<1>("h0"), in1) @[Reg.scala 16:16]
    node _GEN_1 = mux(_in1_T, in_bits_x_1, in1) @[Reg.scala 16:16 17:{18,22}]
    node _last_T = and(in_valid, in_ready) @[multiply.scala 29:48]
    reg last : UInt<1>, clock with :
      reset => (UInt<1>("h0"), last) @[Reg.scala 16:16]
    node _GEN_2 = mux(_last_T, in_bits_last, last) @[Reg.scala 16:16 17:{18,22}]
    reg out0 : SInt<16>, clock with :
      reset => (UInt<1>("h0"), out0) @[Reg.scala 16:16]
    node _out0Nxt_T = and(in_valid, in_ready) @[multiply.scala 35:28]
    node _out0IncMux_T = and(in_valid, in_ready) @[multiply.scala 36:34]
    node _out0IncMux_T_1 = bits(in_bits_x_0, 7, 5) @[multiply.scala 36:57]
    node _out0IncMux_T_2 = bits(in0, 7, 5) @[multiply.scala 36:76]
    node out0IncMux = mux(_out0IncMux_T, _out0IncMux_T_1, _out0IncMux_T_2) @[multiply.scala 36:25]
    node _out0Inc_T = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 37:31]
    node _out0Inc_T_1 = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 37:53]
    node _out0Inc_T_2 = or(_out0Inc_T, _out0Inc_T_1) @[multiply.scala 37:41]
    node _out0Inc_T_3 = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 38:24]
    node _out0Inc_T_4 = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 38:46]
    node _out0Inc_T_5 = or(_out0Inc_T_3, _out0Inc_T_4) @[multiply.scala 38:34]
    node _out0Inc_T_6 = asSInt(in1) @[multiply.scala 38:74]
    node _out0Inc_T_7 = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 39:24]
    node _out0Inc_T_8 = asSInt(in1) @[multiply.scala 39:52]
    node _out0Inc_T_9 = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 40:24]
    node _out0Inc_T_10 = asSInt(in1) @[multiply.scala 40:53]
    node _out0Inc_T_11 = sub(shl(asSInt(UInt<1>("h0")), 7), _out0Inc_T_10) @[multiply.scala 40:36]
    node _out0Inc_T_12 = tail(_out0Inc_T_11, 1) @[multiply.scala 40:36]
    node _out0Inc_T_13 = asSInt(_out0Inc_T_12) @[multiply.scala 40:36]
    node _out0Inc_T_14 = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 41:24]
    node _out0Inc_T_15 = eq(out0IncMux, UInt<1>("h0")) @[multiply.scala 41:46]
    node _out0Inc_T_16 = or(_out0Inc_T_14, _out0Inc_T_15) @[multiply.scala 41:34]
    node _out0Inc_T_17 = asSInt(in1) @[multiply.scala 41:75]
    node _out0Inc_T_18 = sub(shl(asSInt(UInt<1>("h0")), 8), _out0Inc_T_17) @[multiply.scala 41:58]
    node _out0Inc_T_19 = tail(_out0Inc_T_18, 1) @[multiply.scala 41:58]
    node _out0Inc_T_20 = asSInt(_out0Inc_T_19) @[multiply.scala 41:58]
    node _out0Inc_T_21 = mux(_out0Inc_T_16, _out0Inc_T_20, asSInt(UInt<16>("h0"))) @[multiply.scala 41:12]
    node _out0Inc_T_22 = mux(_out0Inc_T_9, shl(_out0Inc_T_13, 1), _out0Inc_T_21) @[multiply.scala 40:12]
    node _out0Inc_T_23 = mux(_out0Inc_T_7, shl(_out0Inc_T_8, 1), _out0Inc_T_22) @[multiply.scala 39:12]
    node _out0Inc_T_24 = mux(_out0Inc_T_5, _out0Inc_T_6, _out0Inc_T_23) @[multiply.scala 38:12]
    node _out0Inc_T_25 = mux(_out0Inc_T_2, asSInt(UInt<16>("h0")), _out0Inc_T_24) @[multiply.scala 37:19]
    node out0Inc = _out0Inc_T_25 @[multiply.scala 33:23 37:13]
    node _out0Nxt_T_1 = asSInt(out0) @[multiply.scala 35:65]
    node _out0Nxt_T_2 = add(shl(_out0Nxt_T_1, 2), out0Inc) @[multiply.scala 35:80]
    node _out0Nxt_T_3 = tail(_out0Nxt_T_2, 1) @[multiply.scala 35:80]
    node _out0Nxt_T_4 = asSInt(_out0Nxt_T_3) @[multiply.scala 35:80]
    node _out0Nxt_T_5 = mux(_out0Nxt_T, out0Inc, _out0Nxt_T_4) @[multiply.scala 35:19]
    node out0Nxt = asSInt(bits(_out0Nxt_T_5, 15, 0)) @[multiply.scala 32:23 35:13]
    node _GEN_3 = mux(counterHsk.regen, out0Nxt, out0) @[Reg.scala 16:16 17:{18,22}]
    in_ready <= counterHsk.readyPre @[multiply.scala 21:14]
    out_valid <= counterHsk.validNxt @[multiply.scala 22:15]
    out_bits_x_0 <= out0 @[multiply.scala 44:19]
    out_bits_last <= last @[multiply.scala 45:19]
    counterHsk.clock <= clock
    counterHsk.reset <= reset
    counterHsk.validPre <= in_valid @[multiply.scala 20:25]
    counterHsk.readyNxt <= out_ready @[multiply.scala 23:25]
    counterHsk.rst <= rst @[multiply.scala 24:20]
    in0 <= _GEN_0
    in1 <= _GEN_1
    last <= _GEN_2
    out0 <= _GEN_3
