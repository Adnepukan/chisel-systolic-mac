import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class Hsknto1[T <: Data](n: Int, sig: T) extends Module{
    val io = IO(new Bundle{
        val input = Vec(n, Flipped(Decoupled(sig)))
        val output = Decoupled(Vec(n, sig))
    })

    io.output.valid := io.input.map(_.valid).fold(1.B)(_ & _)
    io.output.bits.zipWithIndex.map({case (x, i) => x := io.input(i).bits})
    io.input.zipWithIndex.map({case (x, i) => x.ready := io.output.ready&(~x.valid|(io.input.zipWithIndex
        .map({case (y, j) => Mux((j==i).B, 1.B, y.valid)}).fold(1.B)(_ & _)))})
}
