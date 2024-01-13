import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PETester extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "PE"
    it should "pass" in {
        test(new PE(8, 4, 16, 8)).withAnnotations(Seq(WriteVcdAnnotation)){ dut =>
            dut.clock.setTimeout(0)
            dut.clock.step(10)
            dut.io.sumOut.ready.poke(true.B)
            dut.io.actWeiIn.valid.poke(true.B)
            dut.io.actWeiIn.bits.x(0).poke(-5.F(8.W, 4.BP))
            dut.io.actWeiIn.bits.x(1).poke(6.F(8.W, 4.BP))
            dut.io.actWeiIn.bits.last.poke(true.B)
            dut.io.statSel.poke(0.U)
            dut.io.actEn.poke(0.B)
            dut.io.weiEn.poke(0.B)
            dut.io.sumIn.valid.poke(true.B)
            dut.io.sumIn.bits.x(0).poke(13.F(16.W, 8.BP))
            dut.io.sumIn.bits.last.poke(true.B)
            dut.io.sumIn.bits.last.poke(true.B)
            dut.clock.step(5)
            dut.io.sumOut.valid.expect(true.B)
            dut.io.sumOut.bits.x(0).expect(-17.F(16.W, 8.BP))
            println("\nEnd Testing PE.")
        }
    }
}
