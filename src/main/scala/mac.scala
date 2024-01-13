import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._
import java.io.PrintWriter

class MAC(
    mulW: Int,
    mulBP: Int,
    addW: Int,
    addBP: Int,
    actDim: Int,
    weiDim: Int
) extends Module{
    val io = IO(new Bundle{
        val actIn = Vec(actDim, Flipped(Decoupled(new VecFixed(1, mulW, mulBP))))
        val weiIn = Vec(weiDim, Flipped(Decoupled(new VecFixed(1, mulW, mulBP))))
        val sumIn = Vec(actDim, Flipped(Decoupled(new VecFixed(1, addW, addBP))))
        val sumOut = Vec(actDim, Decoupled(new VecFixed(1, addW, addBP)))
        val statSel = Input(UInt(2.W))
        val actEn = Input(Bool())
        val weiEn = Input(Bool())
        val actOutReady = Input(Bool())
        val weiOutReady = Input(Bool())
    })
    val rst = IO(Input(AsyncReset()))

    withReset(rst){
        val mac = Array.fill(actDim)(Array.fill(weiDim)(Module(new PECross(mulW, mulBP, addW, addBP))))
        mac.zipWithIndex.map({case (x, i) => x.zipWithIndex.map({case (y, j) =>
            if(j==0){
                y.io.actIn <> io.actIn(i)
                y.io.sumIn <> io.sumIn(i)
            }
            else{
                y.io.actIn <> mac(i)(j-1).io.actOut
                y.io.sumIn <> mac(i)(j-1).io.sumOut
            }
            if(i==0)
                y.io.weiIn <> io.weiIn(j)
            else
                y.io.weiIn <> mac(i-1)(j).io.weiOut
            if(j==weiDim-1){
                y.io.actOut.ready := io.actOutReady
                y.io.sumOut <> io.sumOut(i)
            }
            if(i==actDim-1)
                y.io.weiOut.ready := io.weiOutReady
            y.io.actWeiIn.valid := false.B
            y.io.actWeiIn.bits.x(0) := 0.F(1.W, 0.BP)
            y.io.actWeiIn.bits.x(1) := 0.F(1.W, 0.BP)
            y.io.actWeiIn.bits.last := false.B
            y.io.statSel := io.statSel
            y.io.actEn := io.actEn
            y.io.weiEn := io.weiEn
        })})
    }
}

object MAC extends App{
     new PrintWriter("vivado/mac.v"){
         write(getVerilogString(new MAC(8, 4, 20, 8, 16, 16)))
         close()
     }
}
