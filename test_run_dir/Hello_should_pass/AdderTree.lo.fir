circuit AdderTree :
  module PipelineHandshake :
    input clock : Clock
    input reset : UInt<1>
    input validPre : UInt<1>
    output readyPre : UInt<1>
    input lastPre : UInt<1>
    output validNxt : UInt<1>
    input readyNxt : UInt<1>
    output regen_0 : UInt<1>
    output lastNxt : UInt<1>
    input rst : AsyncReset

    reg valid_1_r : UInt<1>, clock with :
      reset => (rst, UInt<1>("h0")) @[Reg.scala 28:20]
    node ready_1 = readyNxt @[pipelinehsk.scala 17:21 30:22]
    node valid_1 = valid_1_r @[pipelinehsk.scala 16:21 22:24]
    node _ready_0_T = not(valid_1) @[pipelinehsk.scala 24:38]
    node _ready_0_T_1 = or(ready_1, _ready_0_T) @[pipelinehsk.scala 24:36]
    node ready_0 = _ready_0_T_1 @[pipelinehsk.scala 17:21 24:22]
    node valid_0 = validPre @[pipelinehsk.scala 16:21 27:18]
    node _GEN_0 = mux(ready_0, valid_0, valid_1_r) @[Reg.scala 29:18 28:20 29:22]
    reg last_1_r : UInt<1>, clock with :
      reset => (rst, UInt<1>("h0")) @[Reg.scala 28:20]
    node last_0 = lastPre @[pipelinehsk.scala 18:20 31:17]
    node _GEN_1 = mux(regen_0, last_0, last_1_r) @[Reg.scala 29:18 28:20 29:22]
    node _regen_0_T = and(valid_0, ready_0) @[pipelinehsk.scala 25:34]
    node last_1 = last_1_r @[pipelinehsk.scala 18:20 23:23]
    readyPre <= ready_0 @[pipelinehsk.scala 28:18]
    validNxt <= valid_1 @[pipelinehsk.scala 29:18]
    regen_0 <= _regen_0_T @[pipelinehsk.scala 25:22]
    lastNxt <= last_1 @[pipelinehsk.scala 32:17]
    valid_1_r <= _GEN_0 @[Reg.scala 28:{20,20}]
    last_1_r <= _GEN_1 @[Reg.scala 28:{20,20}]

  module AdderTree :
    input clock : Clock
    input reset : UInt<1>
    output io_input_ready : UInt<1>
    input io_input_valid : UInt<1>
    input io_input_bits_in_0 : SInt<9>
    input io_input_bits_in_1 : SInt<9>
    input io_input_bits_last : UInt<1>
    input io_output_ready : UInt<1>
    output io_output_valid : UInt<1>
    output io_output_bits_out : SInt<9>
    output io_output_bits_last : UInt<1>
    input rst : AsyncReset

    inst hsk of PipelineHandshake @[addertree.scala 39:21]
    reg r : SInt<9>, clock with :
      reset => (UInt<1>("h0"), r) @[Reg.scala 16:16]
    node sumIn_0_0 = io_input_bits_in_0 @[addertree.scala 49:21 92:21]
    node sumOut_0_0 = sumIn_0_0 @[addertree.scala 50:22 56:23]
    node sumIn_0_1 = io_input_bits_in_1 @[addertree.scala 49:21 92:21]
    node sumOut_0_1 = sumIn_0_1 @[addertree.scala 50:22 56:23]
    node _sumIn_1_0_T = add(sumOut_0_0, sumOut_0_1) @[addertree.scala 96:63]
    node _sumIn_1_0_T_1 = tail(_sumIn_1_0_T, 1) @[addertree.scala 96:63]
    node _sumIn_1_0_T_2 = asSInt(_sumIn_1_0_T_1) @[addertree.scala 96:63]
    node sumIn_1_0 = _sumIn_1_0_T_2 @[addertree.scala 49:21 96:31]
    node _GEN_0 = mux(hsk.regen_0, sumIn_1_0, r) @[Reg.scala 16:16 17:{18,22}]
    reg r_1 : SInt<9>, clock with :
      reset => (UInt<1>("h0"), r_1) @[Reg.scala 16:16]
    node sumIn_1_1 = asSInt(UInt<9>("h0")) @[addertree.scala 49:21 98:35]
    node _GEN_1 = mux(hsk.regen_0, sumIn_1_1, r_1) @[Reg.scala 16:16 17:{18,22}]
    node sumOut_1_0 = r @[addertree.scala 50:22 59:31]
    node sumOut_1_1 = r_1 @[addertree.scala 50:22 59:31]
    io_input_ready <= io_output_ready @[addertree.scala 102:20]
    io_output_valid <= io_input_valid @[addertree.scala 101:21]
    io_output_bits_out <= sumOut_1_0 @[addertree.scala 100:24]
    io_output_bits_last <= hsk.lastNxt @[addertree.scala 45:25]
    hsk.clock <= clock
    hsk.reset <= reset
    hsk.validPre <= io_input_valid @[addertree.scala 40:18]
    hsk.lastPre <= io_input_bits_last @[addertree.scala 42:17]
    hsk.readyNxt <= io_output_ready @[addertree.scala 44:18]
    hsk.rst <= rst @[addertree.scala 46:13]
    r <= _GEN_0
    r_1 <= _GEN_1
