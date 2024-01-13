import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class Adder2to1(
    outW: Int,
    outBP: Int,
    n: Int,
    sub: Boolean = false,
    reg: Boolean = false
) extends Module{
    val io = IO(new Bundle{
        val input = Flipped(Decoupled(new VecFixed(2*n, outW, outBP)))
        val output = Decoupled(new VecFixed(n, outW, outBP))
    })

    val sum = Wire(io.output.bits.x.cloneType)

    if(sub)
        sum.zipWithIndex.map({case (x, i) => x := io.input.bits.x(i)-io.input.bits.x(i+n)})
    else
        sum.zipWithIndex.map({case (x, i) => x := io.input.bits.x(i)+io.input.bits.x(i+n)})

    if(reg){
        val hsk = Module(new PipelineHsk(1))
        hsk.io.validPre := io.input.valid
        io.input.ready := hsk.io.readyPre
        io.output.valid := hsk.io.validNxt
        hsk.io.readyNxt := io.output.ready
        hsk.io.lastPre := io.input.bits.last
        io.output.bits.last := hsk.io.lastNxt
        io.output.bits.x := RegEnable(sum, hsk.io.regen(0))
    }
    else{
        io.output.bits.x := sum
        io.output.bits.last := io.input.bits.last
        io.output.valid := io.input.valid
        io.input.ready := io.output.ready
    }
}

object Adder2to1 extends App{
    println(getVerilogString(new Adder2to1(8, 4, 2, false, false)))
}
