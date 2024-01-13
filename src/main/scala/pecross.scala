import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class PECross(
    mulW: Int,
    mulBP: Int,
    addW: Int,
    addBP: Int
) extends PE(mulW, mulBP, addW, addBP){
    override lazy val io = IO(new PECrossPort(mulW, mulBP, addW, addBP))

    val actWeiInHsk = Module(new Hsknto1(2, io.actIn.bits.cloneType))
    val multiplyInHsk = Module(new Hsk1ton(3, multiply.io.input.bits.cloneType))
    val weiInMux = Module(new Arbiternto1(2, io.actIn.bits.cloneType))
    val actInMux = Module(new Arbiternto1(2, io.actIn.bits.cloneType))
    val multiplyInMux = Module(new Arbiter1ton(2, multiply.io.input.bits.cloneType))
    val actOutMux = Module(new Arbiter1ton(2, multiply.io.input.bits.cloneType))
    val weiOutMux = Module(new Arbiter1ton(2, multiply.io.input.bits.cloneType))
    val adderInMux = Module(new Arbiternto1(2, io.sumIn.bits.cloneType))

    io.actIn <> actInMux.io.input(0)
    actInMux.io.input(1).valid := true.B
    actInMux.io.input(1).bits.x(0) := 0.F(1.W, 0.BP)
    actInMux.io.input(1).bits.last := false.B

    io.weiIn <> weiInMux.io.input(0)
    weiInMux.io.input(1).valid := true.B
    weiInMux.io.input(1).bits.x(0) := 0.F(1.W, 0.BP)
    weiInMux.io.input(1).bits.last := false.B

    actInMux.io.output <> actWeiInHsk.io.input(0)
    weiInMux.io.output <> actWeiInHsk.io.input(1)
    multiplyInHsk.io.input.valid := actWeiInHsk.io.output.valid
    actWeiInHsk.io.output.ready := multiplyInHsk.io.input.ready
    VecFixed.combine(actWeiInHsk.io.output.bits, multiplyInHsk.io.input.bits(0), 0)
    VecFixed.combine(actWeiInHsk.io.output.bits, multiplyInHsk.io.input.bits(1), 0)
    VecFixed.combine(actWeiInHsk.io.output.bits, multiplyInHsk.io.input.bits(2), 1)

    multiplyInMux.io.input <> multiplyInHsk.io.output(0)
    multiplyInMux.io.output(0) <> multiply.io.input
    multiplyInMux.io.output(1).ready := true.B

    actOutMux.io.input <> multiplyInHsk.io.output(1)
    actOutMux.io.output(1).ready := true.B
    val actOutHsk = Module(new PipelineHsk(1))
    actOutHsk.io.validPre := actOutMux.io.output(0).valid
    actOutMux.io.output(0).ready := actOutHsk.io.readyPre
    io.actOut.valid := actOutHsk.io.validNxt
    actOutHsk.io.readyNxt := io.actOut.ready
    actOutHsk.io.lastPre := actOutMux.io.output(0).bits.last
    io.actOut.bits.last := actOutHsk.io.lastNxt
    io.actOut.bits.x(0) := RegEnable(actOutMux.io.output(0).bits.x(0), actOutHsk.io.regen(0))

    weiOutMux.io.input <> multiplyInHsk.io.output(2)
    weiOutMux.io.output(1).ready := true.B
    val weiOutHsk = Module(new PipelineHsk(1))
    weiOutHsk.io.validPre := weiOutMux.io.output(0).valid
    weiOutMux.io.output(0).ready := weiOutHsk.io.readyPre
    io.weiOut.valid := weiOutHsk.io.validNxt
    weiOutHsk.io.readyNxt := io.weiOut.ready
    weiOutHsk.io.lastPre := weiOutMux.io.output(0).bits.last
    io.weiOut.bits.last := weiOutHsk.io.lastNxt
    io.weiOut.bits.x(0) := RegEnable(weiOutMux.io.output(0).bits.x(1), weiOutHsk.io.regen(0))

    // For WEIGHT-STATIONARY (statSel==1)
    actInMux.io.sel := (io.statSel===1.U(2.W))&(~io.weiEn)
    weiInMux.io.sel := (io.statSel===1.U(2.W))&io.weiEn
    multiplyInMux.io.sel := (io.statSel===1.U(2.W))&(~io.weiEn)
    actOutMux.io.sel := (io.statSel===1.U(2.W))&(~io.weiEn)
    weiOutMux.io.sel := (io.statSel===1.U(2.W))&io.weiEn
    multiply.io.input.bits.x(1) := Mux((io.statSel===1.U(2.W))&io.weiEn, io.weiOut.bits.x(0), multiplyInMux.io.output(0).bits.x(1))

    // For OUTPUT-STATIONARY (statSel==2)
    multiplyOutMux.io.output(0) <> adderInMux.io.input(0)
    adderInMux.io.input(1).valid := true.B
    adderInMux.io.input(1).bits.x(0) := 0.F(1.W, 0.BP)
    adderInMux.io.input(1).bits.last := false.B
    adderInMux.io.output <> adderInHsk.io.input(0)
    adderInMux.io.sel := (io.statSel===2.U(2.W))&(~io.actEn)
}

object PECross extends App{
    println(getVerilogString(new PECross(8, 4, 16, 8)))
}
