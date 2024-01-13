import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class Arbiter1ton[T <: Data](n: Int, sig: T) extends Module{
    val selWidth = (log(n-1)/log(2)+1).toInt
    val io = IO(new Bundle{
        val input = Flipped(Decoupled(sig))
        val sel = Input(UInt(selWidth.W))
        val output = Vec(n, Decoupled(sig))
    })

    val readyVec = Wire(Vec(n, Bool()))
    readyVec := io.output.map(_.ready)
    io.input.ready := readyVec(io.sel)
    io.output.zipWithIndex
        .map({case (x, i) => x.valid := Mux(i.U(selWidth.W)===io.sel, io.input.valid, 0.B)})
    io.output.map(_.bits := io.input.bits)
}

object Arbiter1ton extends App{
    val input = Vec(2, UInt(16.W))
    println(getVerilogString(new Arbiter1ton(2, input)))
}
