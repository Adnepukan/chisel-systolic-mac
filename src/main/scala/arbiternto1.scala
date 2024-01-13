import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class Arbiternto1[T <: Data](n: Int, sig: T) extends Module{
    val selWidth = (log(n-1)/log(2)+1).toInt
    val io = IO(new Bundle{
        val input = Vec(n, Flipped(Decoupled(sig)))
        val sel = Input(UInt(selWidth.W))
        val output = Decoupled(sig)
    })

    io.output.bits := io.input(io.sel).bits
    io.output.valid := io.input(io.sel).valid
    io.input.zipWithIndex
        .map({case (x, i) => x.ready := Mux(i.U(selWidth.W)===io.sel, io.output.ready, 0.B)})
}
