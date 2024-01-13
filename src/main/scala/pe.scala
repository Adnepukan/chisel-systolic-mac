import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class PE(
    mulW: Int,
    mulBP: Int,
    addW: Int,
    addBP: Int
) extends PENlr(mulW, mulBP, addW, addBP){
    override lazy val io = IO(new PEPort(mulW, mulBP, addW, addBP))

    // For WEIGHT-STATIONARY (statSel==1)
    val weiOut = RegEnable(io.actWeiIn.bits.x(1), (io.statSel===1.U(2.W))&io.weiEn)
    multiply.io.input.bits.x(1) := Mux(io.statSel===1.U(2.W), weiOut, io.actWeiIn.bits.x(1))

    // For OUTPUT-STATIONARY (statSel==2)
    val accumulator = Module(new Accumulator2to1(addW, addBP))
    val multiplyOutMux = Module(new Arbiter1ton(2, io.sumIn.bits.cloneType))
    val sumOutMux = Module(new Arbiternto1(2, io.sumIn.bits.cloneType))
    multiplyOutMux.io.sel := (io.statSel===2.U(2.W))&io.actEn
    sumOutMux.io.sel := (io.statSel===2.U(2.W))&io.actEn
    multiplyOutMux.io.input <> multiply.io.output
    multiplyOutMux.io.output(0) <> adderInHsk.io.input(0)
    multiplyOutMux.io.output(1) <> accumulator.io.input
    sumOutMux.io.input(0) <> adder.io.output
    sumOutMux.io.input(1) <> accumulator.io.output
    sumOutMux.io.output <> io.sumOut
}

object PE extends App{
    println(getVerilogString(new PE(8, 4, 16, 8)))
}
