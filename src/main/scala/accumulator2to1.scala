import chisel3._
import chisel3.util._
import chisel3.experimental._
import chiseltest._

class Accumulator2to1(
    outW: Int,
    outBP: Int
) extends Module{
    val io = IO(new Bundle{
        val input = Flipped(Decoupled(new VecFixed(1, outW, outBP)))
        val output = Decoupled(new VecFixed(1, outW, outBP))
    })

    io.input.ready := 1.B
    val sumNxt = Wire(FixedPoint(outW.W, outBP.BP))
    io.output.bits.last := RegEnable(io.input.bits.last, 0.B, io.input.valid&io.input.ready)
    io.output.bits.x(0) := RegEnable(sumNxt, 0.F(outW.W, outBP.BP), io.input.valid&io.input.ready)
    sumNxt := Mux(io.output.bits.last, io.input.bits.x(0), io.output.bits.x(0)+io.input.bits.x(0))
    io.output.valid := io.output.bits.last
}

object Accumulator2to1 extends App{
    println(getVerilogString(new Accumulator2to1(9, 4)))
}
