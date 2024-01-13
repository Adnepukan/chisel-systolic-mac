import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class PECrossTester extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "PECross"
    it should "pass" in {
        test(new PECross(8, 4, 16, 8)).withAnnotations(Seq(WriteVcdAnnotation)){ dut =>
            dut.clock.setTimeout(0)
            dut.clock.step(10)
            dut.io.sumOut.ready.poke(true.B)
            dut.io.weiOut.ready.poke(true.B)
            dut.io.actOut.ready.poke(true.B)
            dut.io.actIn.bits.x(0).poke(6.F(8.W, 4.BP))
            dut.io.actIn.bits.last.poke(true.B)
            dut.io.weiIn.bits.x(0).poke(-5.F(8.W, 4.BP))
            dut.io.weiIn.bits.last.poke(true.B)
            dut.io.sumIn.bits.x(0).poke(13.F(16.W, 8.BP))
            dut.io.sumIn.bits.last.poke(true.B)
            dut.io.statSel.poke(0.U)
            dut.io.actEn.poke(false.B)
            dut.io.weiEn.poke(false.B)
            dut.io.actIn.valid.poke(true.B)
            dut.io.weiIn.valid.poke(true.B)
            dut.io.sumIn.valid.poke(true.B)
            // dut.clock.step(1)
            // dut.io.weiEn.poke(true.B)
            // dut.io.actIn.valid.poke(true.B)
            // dut.io.weiIn.valid.poke(false.B)
            dut.clock.step(1)
            dut.io.actOut.valid.expect(true.B)
            dut.io.actOut.bits.x(0).expect(6.F(8.W, 4.BP))
            dut.io.actOut.bits.last.expect(true.B)
            dut.io.weiOut.valid.expect(true.B)
            dut.io.weiOut.bits.x(0).expect(-5.F(8.W, 4.BP))
            dut.io.weiOut.bits.last.expect(true.B)
            dut.clock.step(4)
            dut.io.sumOut.valid.expect(true.B)
            dut.io.sumOut.bits.x(0).expect(-17.F(16.W, 8.BP))
            dut.io.sumOut.bits.last.expect(true.B)
            // dut.io.actEn.poke(false.B)
            // dut.clock.step(1)
            // dut.io.sumOut.valid.expect(true.B)
            // dut.io.sumOut.bits.x(0).expect(13.F(16.W, 8.BP))
            // dut.io.sumOut.bits.last.expect(true.B)
            println("\nEnd Testing PECross.")
        }
    }
}
