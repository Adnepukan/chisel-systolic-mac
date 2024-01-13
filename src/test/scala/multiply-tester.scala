import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class MultiplyTester extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "Multiply"
    it should "pass" in {
        test(new Multiply(8, 4, 16, 8)).withAnnotations(Seq(WriteVcdAnnotation)){ dut =>
            dut.clock.setTimeout(0)
            dut.clock.step(10)
            dut.io.output.ready.poke(true.B)
            dut.io.input.valid.poke(true.B)
            dut.io.input.bits.x(0).poke(-5.F(8.W, 4.BP))
            dut.io.input.bits.x(1).poke(6.F(8.W, 4.BP))
            dut.io.input.bits.last.poke(true.B)
            dut.clock.step(1)
            dut.io.input.valid.poke(false.B)
            dut.clock.step(3)
            dut.io.output.valid.expect(true.B)
            dut.io.output.bits.x(0).expect(-30.F(16.W, 8.BP))
            println("\nEnd Testing Multiply.")
        }
    }
}
