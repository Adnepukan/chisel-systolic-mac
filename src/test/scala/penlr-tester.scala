import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PENlrTester extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "PENlr"
    it should "pass" in {
        test(new PENlr(8, 4, 16, 8)).withAnnotations(Seq(WriteVcdAnnotation)){ dut =>
            dut.clock.setTimeout(0)
            dut.clock.step(10)
            dut.io.sumOut.ready.poke(true.B)
            dut.io.actWeiIn.valid.poke(true.B)
            dut.io.actWeiIn.bits.x(0).poke(-5.F(8.W, 4.BP))
            dut.io.actWeiIn.bits.x(1).poke(6.F(8.W, 4.BP))
            dut.io.actWeiIn.bits.last.poke(true.B)
            dut.io.sumIn.valid.poke(true.B)
            dut.io.sumIn.bits.x(0).poke(13.F(16.W, 8.BP))
            dut.io.sumIn.bits.last.poke(true.B)
            dut.io.sumIn.bits.last.poke(true.B)
            dut.clock.step(1)
            dut.io.actWeiIn.valid.poke(false.B)
            dut.clock.step(4)
            dut.io.sumOut.valid.expect(true.B)
            dut.io.sumOut.bits.x(0).expect(-17.F(16.W, 8.BP))
            println("\nEnd Testing PENlr.")
        }
    }
}
