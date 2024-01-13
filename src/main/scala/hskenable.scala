import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class HskEnable[T <: Data](sig: T) extends Module{
    val io = IO(new Bundle{
        val input = Flipped(Decoupled(sig))
        val output = Decoupled(sig)
        val en = Input(Bool())
    })

    io.output.bits := io.input.bits
    io.output.valid := io.input.valid & io.en
    io.input.ready := io.output.ready & io.en
}
