import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class Hsk1ton[T <: Data](n: Int, sig: T) extends Module{
    val io = IO(new Bundle{
        val input = Flipped(Decoupled(Vec(n, sig)))
        val output = Vec(n, Decoupled(sig))
    })

    io.input.ready := io.output.map(_.ready).fold(1.B)(_ & _)
    io.output.zipWithIndex.map({case (x,i) => x.bits := io.input.bits(i)})
    io.output.zipWithIndex.map({case(x, i) => x.valid := io.input.valid&(~x.ready|(io.output.zipWithIndex
        .map({case (y, j) => Mux((j==i).B, 1.B, y.ready)}).fold(1.B)(_ & _)))})
}
