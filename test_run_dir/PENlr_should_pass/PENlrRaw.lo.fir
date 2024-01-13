circuit PENlrRaw :
  module CounterHsk :
    input clock : Clock
    input reset : UInt<1>
    input validPre : UInt<1>
    output readyPre : UInt<1>
    output validNxt : UInt<1>
    input readyNxt : UInt<1>
    input stall : UInt<1>
    output regen : UInt<1>
    input rst : AsyncReset

    reg counter : UInt<3>, clock with :
      reset => (rst, UInt<3>("h0")) @[Reg.scala 28:20]
    node _counterEn_T = and(validNxt, readyNxt) @[counterhsk.scala 29:30]
    node _counterEn_T_1 = or(_counterEn_T, regen) @[counterhsk.scala 29:39]
    node counterEn = _counterEn_T_1 @[counterhsk.scala 21:29 29:19]
    node _counterNxt_T = eq(counter, UInt<3>("h4")) @[counterhsk.scala 24:20]
    node _counterNxt_T_1 = and(validPre, readyPre) @[counterhsk.scala 25:25]
    node _counterNxt_T_2 = mux(_counterNxt_T_1, UInt<3>("h1"), UInt<3>("h0")) @[counterhsk.scala 25:16]
    node _counterNxt_T_3 = add(counter, UInt<3>("h1")) @[counterhsk.scala 26:20]
    node _counterNxt_T_4 = tail(_counterNxt_T_3, 1) @[counterhsk.scala 26:20]
    node _counterNxt_T_5 = mux(_counterNxt_T, _counterNxt_T_2, _counterNxt_T_4) @[counterhsk.scala 23:26]
    node counterNxt = _counterNxt_T_5 @[counterhsk.scala 20:30 23:20]
    node _GEN_0 = mux(counterEn, counterNxt, counter) @[Reg.scala 29:18 28:20 29:22]
    node _regen_T = not(stall) @[counterhsk.scala 28:19]
    node _regen_T_1 = and(validPre, readyPre) @[counterhsk.scala 28:36]
    node _regen_T_2 = eq(counter, UInt<3>("h0")) @[counterhsk.scala 28:57]
    node _regen_T_3 = eq(counter, UInt<3>("h4")) @[counterhsk.scala 28:89]
    node _regen_T_4 = or(_regen_T_2, _regen_T_3) @[counterhsk.scala 28:80]
    node _regen_T_5 = not(_regen_T_4) @[counterhsk.scala 28:47]
    node _regen_T_6 = or(_regen_T_1, _regen_T_5) @[counterhsk.scala 28:45]
    node _regen_T_7 = and(_regen_T, _regen_T_6) @[counterhsk.scala 28:26]
    node _readyPre_T = eq(counter, UInt<3>("h0")) @[counterhsk.scala 30:30]
    node _readyPre_T_1 = and(validNxt, readyNxt) @[counterhsk.scala 30:62]
    node _readyPre_T_2 = or(_readyPre_T, _readyPre_T_1) @[counterhsk.scala 30:53]
    node _readyPre_T_3 = not(stall) @[counterhsk.scala 30:74]
    node _readyPre_T_4 = and(_readyPre_T_2, _readyPre_T_3) @[counterhsk.scala 30:72]
    node _validNxt_T = eq(counter, UInt<3>("h4")) @[counterhsk.scala 31:29]
    node _validNxt_T_1 = not(stall) @[counterhsk.scala 31:60]
    node _validNxt_T_2 = and(_validNxt_T, _validNxt_T_1) @[counterhsk.scala 31:58]
    readyPre <= _readyPre_T_4 @[counterhsk.scala 30:18]
    validNxt <= _validNxt_T_2 @[counterhsk.scala 31:18]
    regen <= _regen_T_7 @[counterhsk.scala 28:15]
    counter <= _GEN_0 @[Reg.scala 28:{20,20}]

  module MultiplyRaw :
    input clock : Clock
    input reset : UInt<1>
    output io_in_ready : UInt<1>
    input io_in_valid : UInt<1>
    input io_in_bits_x_0 : SInt<8>
    input io_in_bits_x_1 : SInt<8>
    input io_in_bits_last : UInt<1>
    input io_out_ready : UInt<1>
    output io_out_valid : UInt<1>
    output io_out_bits_x_0 : SInt<16>
    output io_out_bits_last : UInt<1>
    input io_stall : UInt<1>
    input rst : AsyncReset

    inst counterHsk of CounterHsk @[multiply.scala 22:28]
    reg in0 : SInt<8>, clock with :
      reset => (UInt<1>("h0"), in0) @[Reg.scala 16:16]
    node _regen_T = not(io_stall) @[multiplyraw.scala 13:14]
    node regen = _regen_T @[multiply.scala 23:21 multiplyraw.scala 13:11]
    node _in0Nxt_T = and(io_in_valid, io_in_ready) @[multiply.scala 37:34]
    node _in0Nxt_T_1 = shl(io_in_bits_x_0, 2) @[multiply.scala 37:63]
    node _in0Nxt_T_2 = shl(in0, 2) @[multiply.scala 37:71]
    node _in0Nxt_T_3 = mux(_in0Nxt_T, _in0Nxt_T_1, _in0Nxt_T_2) @[multiply.scala 37:22]
    node in0Nxt = asSInt(bits(_in0Nxt_T_3, 7, 0)) @[multiply.scala 33:26 37:16]
    node _GEN_0 = mux(regen, in0Nxt, in0) @[Reg.scala 16:16 17:{18,22}]
    node _in1_T = and(io_in_valid, io_in_ready) @[multiply.scala 35:57]
    node _in1_T_1 = and(_in1_T, regen) @[multiply.scala 35:69]
    reg in1 : SInt<8>, clock with :
      reset => (UInt<1>("h0"), in1) @[Reg.scala 16:16]
    node _GEN_1 = mux(_in1_T_1, io_in_bits_x_1, in1) @[Reg.scala 16:16 17:{18,22}]
    node _last_T = and(io_in_valid, io_in_ready) @[multiply.scala 36:58]
    node _last_T_1 = and(_last_T, regen) @[multiply.scala 36:70]
    reg last : UInt<1>, clock with :
      reset => (UInt<1>("h0"), last) @[Reg.scala 16:16]
    node _GEN_2 = mux(_last_T_1, io_in_bits_last, last) @[Reg.scala 16:16 17:{18,22}]
    node _in1Inc_T = and(io_in_valid, io_in_ready) @[multiply.scala 38:37]
    node in1Inc = mux(_in1Inc_T, io_in_bits_x_1, in1) @[multiply.scala 38:25]
    reg out0 : SInt<16>, clock with :
      reset => (UInt<1>("h0"), out0) @[Reg.scala 16:16]
    node _out0Nxt_T = and(io_in_valid, io_in_ready) @[multiply.scala 43:35]
    node _out0IncMux_T = and(io_in_valid, io_in_ready) @[multiply.scala 44:41]
    node _out0IncMux_T_1 = bits(io_in_bits_x_0, 7, 5) @[multiply.scala 44:70]
    node _out0IncMux_T_2 = bits(in0, 7, 5) @[multiply.scala 44:89]
    node out0IncMux = mux(_out0IncMux_T, _out0IncMux_T_1, _out0IncMux_T_2) @[multiply.scala 44:29]
    node _out0Inc_T = eq(out0IncMux, UInt<3>("h0")) @[multiply.scala 45:35]
    node _out0Inc_T_1 = eq(out0IncMux, UInt<3>("h7")) @[multiply.scala 45:59]
    node _out0Inc_T_2 = or(_out0Inc_T, _out0Inc_T_1) @[multiply.scala 45:47]
    node _out0Inc_T_3 = eq(out0IncMux, UInt<3>("h1")) @[multiply.scala 46:28]
    node _out0Inc_T_4 = eq(out0IncMux, UInt<3>("h2")) @[multiply.scala 46:52]
    node _out0Inc_T_5 = or(_out0Inc_T_3, _out0Inc_T_4) @[multiply.scala 46:40]
    node _out0Inc_T_6 = asSInt(in1Inc) @[multiply.scala 46:85]
    node _out0Inc_T_7 = eq(out0IncMux, UInt<3>("h3")) @[multiply.scala 47:28]
    node _out0Inc_T_8 = asSInt(in1Inc) @[multiply.scala 47:61]
    node _out0Inc_T_9 = eq(out0IncMux, UInt<3>("h4")) @[multiply.scala 48:28]
    node _out0Inc_T_10 = asSInt(in1Inc) @[multiply.scala 48:62]
    node _out0Inc_T_11 = sub(shl(asSInt(UInt<1>("h0")), 7), _out0Inc_T_10) @[multiply.scala 48:42]
    node _out0Inc_T_12 = tail(_out0Inc_T_11, 1) @[multiply.scala 48:42]
    node _out0Inc_T_13 = asSInt(_out0Inc_T_12) @[multiply.scala 48:42]
    node _out0Inc_T_14 = eq(out0IncMux, UInt<3>("h5")) @[multiply.scala 49:28]
    node _out0Inc_T_15 = eq(out0IncMux, UInt<3>("h6")) @[multiply.scala 49:52]
    node _out0Inc_T_16 = or(_out0Inc_T_14, _out0Inc_T_15) @[multiply.scala 49:40]
    node _out0Inc_T_17 = asSInt(in1Inc) @[multiply.scala 49:86]
    node _out0Inc_T_18 = sub(shl(asSInt(UInt<1>("h0")), 8), _out0Inc_T_17) @[multiply.scala 49:66]
    node _out0Inc_T_19 = tail(_out0Inc_T_18, 1) @[multiply.scala 49:66]
    node _out0Inc_T_20 = asSInt(_out0Inc_T_19) @[multiply.scala 49:66]
    node _out0Inc_T_21 = mux(_out0Inc_T_16, _out0Inc_T_20, asSInt(UInt<16>("h0"))) @[multiply.scala 49:16]
    node _out0Inc_T_22 = mux(_out0Inc_T_9, shl(_out0Inc_T_13, 1), _out0Inc_T_21) @[multiply.scala 48:16]
    node _out0Inc_T_23 = mux(_out0Inc_T_7, shl(_out0Inc_T_8, 1), _out0Inc_T_22) @[multiply.scala 47:16]
    node _out0Inc_T_24 = mux(_out0Inc_T_5, _out0Inc_T_6, _out0Inc_T_23) @[multiply.scala 46:16]
    node _out0Inc_T_25 = mux(_out0Inc_T_2, asSInt(UInt<16>("h0")), _out0Inc_T_24) @[multiply.scala 45:23]
    node out0Inc = _out0Inc_T_25 @[multiply.scala 41:27 45:17]
    node _out0Nxt_T_1 = asSInt(out0) @[multiply.scala 43:75]
    node _out0Nxt_T_2 = add(shl(_out0Nxt_T_1, 2), out0Inc) @[multiply.scala 43:90]
    node _out0Nxt_T_3 = tail(_out0Nxt_T_2, 1) @[multiply.scala 43:90]
    node _out0Nxt_T_4 = asSInt(_out0Nxt_T_3) @[multiply.scala 43:90]
    node _out0Nxt_T_5 = mux(_out0Nxt_T, out0Inc, _out0Nxt_T_4) @[multiply.scala 43:23]
    node out0Nxt = asSInt(bits(_out0Nxt_T_5, 15, 0)) @[multiply.scala 40:27 43:17]
    node _GEN_3 = mux(regen, out0Nxt, out0) @[Reg.scala 16:16 17:{18,22}]
    io_in_ready <= UInt<1>("h1") @[multiplyraw.scala 14:17]
    io_out_valid <= UInt<1>("h1") @[multiplyraw.scala 15:18]
    io_out_bits_x_0 <= out0 @[multiply.scala 52:26]
    io_out_bits_last <= last @[multiply.scala 53:26]
    counterHsk.clock <= clock
    counterHsk.reset <= reset
    counterHsk.validPre <= io_in_valid @[multiply.scala 25:25]
    counterHsk.readyNxt <= io_out_ready @[multiply.scala 28:25]
    counterHsk.stall <= io_stall @[multiply.scala 30:22]
    counterHsk.rst <= rst @[multiply.scala 29:20]
    in0 <= _GEN_0
    in1 <= _GEN_1
    last <= _GEN_2
    out0 <= _GEN_3

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
    input rst : AsyncReset

    node _sum_0_T = add(io_input_bits_x_0, io_input_bits_x_1) @[adder2to1.scala 24:69]
    node _sum_0_T_1 = tail(_sum_0_T, 1) @[adder2to1.scala 24:69]
    node _sum_0_T_2 = asSInt(_sum_0_T_1) @[adder2to1.scala 24:69]
    node _T = and(io_input_valid, io_input_ready) @[adder2to1.scala 27:58]
    reg r_0 : SInt<16>, clock with :
      reset => (UInt<1>("h0"), r_0) @[Reg.scala 16:16]
    node sum_0 = _sum_0_T_2 @[adder2to1.scala 19:19 24:48]
    node _GEN_0 = mux(_T, sum_0, r_0) @[Reg.scala 16:16 17:{18,22}]
    node _io_output_bits_last_T = and(io_input_valid, io_input_ready) @[adder2to1.scala 28:76]
    reg io_output_bits_last_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_output_bits_last_r) @[Reg.scala 16:16]
    node _GEN_1 = mux(_io_output_bits_last_T, io_input_bits_last, io_output_bits_last_r) @[Reg.scala 16:16 17:{18,22}]
    reg io_output_valid_r : UInt<1>, clock with :
      reset => (UInt<1>("h0"), io_output_valid_r) @[Reg.scala 28:20]
    node _GEN_2 = mux(io_input_ready, io_input_valid, io_output_valid_r) @[Reg.scala 29:18 28:20 29:22]
    node _io_input_ready_T = not(io_output_valid) @[adder2to1.scala 30:44]
    node _io_input_ready_T_1 = or(io_output_ready, _io_input_ready_T) @[adder2to1.scala 30:42]
    io_input_ready <= _io_input_ready_T_1 @[adder2to1.scala 30:24]
    io_output_valid <= io_output_valid_r @[adder2to1.scala 29:25]
    io_output_bits_x_0 <= r_0 @[adder2to1.scala 27:26]
    io_output_bits_last <= io_output_bits_last_r @[adder2to1.scala 28:29]
    r_0 <= _GEN_0
    io_output_bits_last_r <= _GEN_1
    io_output_valid_r <= mux(reset, UInt<1>("h0"), _GEN_2) @[Reg.scala 28:{20,20}]

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

  module HskEnable :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_0_x_0 : SInt<16>
    input io_input_bits_0_last : UInt<1>
    input io_input_bits_1_x_0 : SInt<16>
    input io_input_bits_1_last : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_0_x_0 : SInt<16>
    output io_output_bits_0_last : UInt<1>
    output io_output_bits_1_x_0 : SInt<16>
    output io_output_bits_1_last : UInt<1>
    input io_en : UInt<1>

    node _io_output_valid_T = and(io_input_valid, io_en) @[hskenable.scala 14:39]
    node _io_input_ready_T = and(io_output_ready, io_en) @[hskenable.scala 15:39]
    io_input_ready <= _io_input_ready_T @[hskenable.scala 15:20]
    io_output_valid <= _io_output_valid_T @[hskenable.scala 14:21]
    io_output_bits_0_x_0 <= io_input_bits_0_x_0 @[hskenable.scala 13:20]
    io_output_bits_0_last <= io_input_bits_0_last @[hskenable.scala 13:20]
    io_output_bits_1_x_0 <= io_input_bits_1_x_0 @[hskenable.scala 13:20]
    io_output_bits_1_last <= io_input_bits_1_last @[hskenable.scala 13:20]

  module PENlrRaw :
    input clock : Clock
    input reset : UInt<1>
    output io_actWeiIn_ready : UInt<1>
    input io_actWeiIn_valid : UInt<1>
    input io_actWeiIn_bits_x_0 : SInt<8>
    input io_actWeiIn_bits_x_1 : SInt<8>
    input io_actWeiIn_bits_last : UInt<1>
    output io_sum_ready : UInt<1>
    input io_sum_valid : UInt<1>
    input io_sum_bits_x_0 : SInt<16>
    input io_sum_bits_last : UInt<1>
    input io_actOut_ready : UInt<1>
    output io_actOut_valid : UInt<1>
    output io_actOut_bits_x_0 : SInt<16>
    output io_actOut_bits_last : UInt<1>
    input io_stall : UInt<1>
    input rst : AsyncReset

    inst multiply of MultiplyRaw @[penlr.scala 16:26]
    inst adder of Adder2to1 @[penlr.scala 21:23]
    inst adderInHsk of Hsknto1 @[penlr.scala 22:28]
    inst adderInEn of HskEnable @[penlr.scala 23:27]
    node _adderInEn_io_en_T = not(io_stall) @[penlr.scala 27:24]
    io_actWeiIn_ready <= UInt<1>("h1") @[penlrraw.scala 14:23]
    io_sum_ready <= UInt<1>("h1") @[penlrraw.scala 15:18]
    io_actOut_valid <= UInt<1>("h1") @[penlrraw.scala 13:21]
    io_actOut_bits_x_0 <= adder.io_output_bits_x_0 @[penlr.scala 35:21]
    io_actOut_bits_last <= adder.io_output_bits_last @[penlr.scala 35:21]
    multiply.clock <= clock
    multiply.reset <= reset
    multiply.io_in_valid <= io_actWeiIn_valid @[penlr.scala 17:20]
    multiply.io_in_bits_x_0 <= io_actWeiIn_bits_x_0 @[penlr.scala 17:20]
    multiply.io_in_bits_x_1 <= io_actWeiIn_bits_x_1 @[penlr.scala 17:20]
    multiply.io_in_bits_last <= io_actWeiIn_bits_last @[penlr.scala 17:20]
    multiply.io_out_ready <= adderInHsk.io_input_0_ready @[penlr.scala 24:28]
    multiply.io_stall <= io_stall @[penlr.scala 18:23]
    multiply.rst <= rst @[penlr.scala 19:18]
    adder.clock <= clock
    adder.reset <= reset
    adder.io_input_valid <= adderInEn.io_output_valid @[penlr.scala 31:26]
    adder.io_input_bits_x_0 <= adderInEn.io_output_bits_0_x_0 @[penlr.scala 28:30]
    adder.io_input_bits_x_1 <= adderInEn.io_output_bits_1_x_0 @[penlr.scala 29:30]
    adder.io_input_bits_last <= adderInEn.io_output_bits_0_last @[penlr.scala 30:30]
    adder.io_output_ready <= io_actOut_ready @[penlr.scala 35:21]
    adder.rst <= rst @[penlr.scala 33:15]
    adderInHsk.clock <= clock
    adderInHsk.reset <= reset
    adderInHsk.io_input_0_valid <= multiply.io_out_valid @[penlr.scala 24:28]
    adderInHsk.io_input_0_bits_x_0 <= multiply.io_out_bits_x_0 @[penlr.scala 24:28]
    adderInHsk.io_input_0_bits_last <= multiply.io_out_bits_last @[penlr.scala 24:28]
    adderInHsk.io_input_1_valid <= io_sum_valid @[penlr.scala 25:28]
    adderInHsk.io_input_1_bits_x_0 <= io_sum_bits_x_0 @[penlr.scala 25:28]
    adderInHsk.io_input_1_bits_last <= io_sum_bits_last @[penlr.scala 25:28]
    adderInHsk.io_output_ready <= adderInEn.io_input_ready @[penlr.scala 26:26]
    adderInEn.clock <= clock
    adderInEn.reset <= reset
    adderInEn.io_input_valid <= adderInHsk.io_output_valid @[penlr.scala 26:26]
    adderInEn.io_input_bits_0_x_0 <= adderInHsk.io_output_bits_0_x_0 @[penlr.scala 26:26]
    adderInEn.io_input_bits_0_last <= adderInHsk.io_output_bits_0_last @[penlr.scala 26:26]
    adderInEn.io_input_bits_1_x_0 <= adderInHsk.io_output_bits_1_x_0 @[penlr.scala 26:26]
    adderInEn.io_input_bits_1_last <= adderInHsk.io_output_bits_1_last @[penlr.scala 26:26]
    adderInEn.io_output_ready <= adder.io_input_ready @[penlr.scala 32:31]
    adderInEn.io_en <= _adderInEn_io_en_T @[penlr.scala 27:21]
