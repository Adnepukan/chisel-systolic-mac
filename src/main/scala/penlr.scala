import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class PENlr(
    mulW: Int,
    mulBP: Int,
    addW: Int,
    addBP: Int
) extends Module{
    lazy val io = IO(new PEnlrPort(mulW, mulBP, addW, addBP))

    val multiply = Module(new Multiply(mulW, mulBP, addW, addBP))
    multiply.io.input <> io.actWeiIn

    val adder = Module(new Adder2to1(addW, addBP, 1, false, true))
    val adderInHsk = Module(new Hsknto1(2, io.sumIn.bits.cloneType))
    adderInHsk.io.input(0) <> multiply.io.output
    adderInHsk.io.input(1) <> io.sumIn
    VecFixed.combine(adderInHsk.io.output, adder.io.input, 1)

    adder.io.output <> io.sumOut
}

object PENlr extends App{
    println(getVerilogString(new PENlr(8, 4, 16, 8)))
}
