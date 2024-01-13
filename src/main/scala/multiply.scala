import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._


class Multiply(
    inW: Int,
    inBP: Int,
    outW: Int,
    outBP: Int
) extends Module{
    val latency = (inW/2).toInt

    val io = IO(new Bundle{
        val input = Flipped(Decoupled(new VecFixed(2, inW, inBP)))
        val output = Decoupled(new VecFixed(1, outW, outBP))
    })

    val counterHsk = Module(new CounterHsk(latency))
    counterHsk.io.validPre := io.input.valid
    io.input.ready := counterHsk.io.readyPre
    io.output.valid := counterHsk.io.validNxt
    counterHsk.io.readyNxt := io.output.ready
    counterHsk.io.lastPre := io.input.bits.last
    io.output.bits.last := counterHsk.io.lastNxt

    val in0Nxt = Wire(FixedPoint(inW.W, inBP.BP))
    val in0 = RegEnable(in0Nxt, counterHsk.io.regen)
    val in1 = RegEnable(io.input.bits.x(1), io.input.valid&io.input.ready&counterHsk.io.regen)
    in0Nxt := Mux(io.input.valid&io.input.ready, io.input.bits.x(0)<<2, in0<<2)
    val in1Inc = Mux(io.input.valid&io.input.ready, io.input.bits.x(1), in1)

    val out0Nxt = Wire(FixedPoint((inW*2).W, (inBP*2).BP))
    val out0Inc = Wire(FixedPoint((inW*2).W, (inBP*2).BP))
    val out0 = RegEnable(out0Nxt, counterHsk.io.regen)
    out0Nxt := Mux(io.input.valid&io.input.ready, out0Inc, out0.asFixedPoint((inBP*2-2).BP)+out0Inc)
    val out0IncMux = Mux(io.input.valid&io.input.ready, io.input.bits.x(0)(inW-1, inW-3), in0(inW-1, inW-3))
    out0Inc := Mux((out0IncMux===0.U(3.W))|(out0IncMux===7.U(3.W)), 0.F(1.W, 0.BP),
        Mux((out0IncMux===1.U(3.W))|(out0IncMux===2.U(3.W)), in1Inc.asFixedPoint((inBP*2).BP),
        Mux((out0IncMux===3.U(3.W)), in1Inc.asFixedPoint((inBP*2-1).BP),
        Mux((out0IncMux===4.U(3.W)), -in1Inc.asFixedPoint((inBP*2-1).BP),
        Mux((out0IncMux===5.U(3.W))|(out0IncMux===6.U(3.W)), -in1Inc.asFixedPoint((inBP*2).BP), 0.F(1.W, 0.BP))
    ))))

    io.output.bits.x(0) := out0
}

object Multiply extends App{
    println(getVerilogString(new Multiply(8, 4, 16, 8)))
}
