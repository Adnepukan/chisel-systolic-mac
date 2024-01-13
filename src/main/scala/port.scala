import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class VecFixed(
    n: Int,
    w: Int,
    bp: Int
) extends Bundle{
    val x = Vec(n, FixedPoint(w.W, bp.BP))
    val last = Bool()
}

object VecFixed{
    def combine(src: DecoupledIO[Vec[VecFixed]], dst: DecoupledIO[VecFixed], i: Int) = {
        var counter = 0
        for(vecFixed <- src.bits)
            for(f <- vecFixed.x){
                dst.bits.x(counter) := f
                counter += 1
            }
        dst.bits.last := src.bits(i).last
        dst.valid := src.valid
        src.ready := dst.ready
    }

    def combine(src: Vec[VecFixed], dst: VecFixed, i: Int) = {
        var counter = 0
        for(vecFixed <- src)
            for(f <- vecFixed.x){
                dst.x(counter) := f
                counter += 1
            }
        dst.last := src(i).last
    }

    def repeat(src: DecoupledIO[VecFixed], dst: DecoupledIO[VecFixed]) = {
        var counter = 0
        for(f <- dst.bits.x){
            f := src.bits.x(counter%src.bits.x.length)
            counter += 1
        }
        dst.bits.last := src.bits.last
        dst.valid := src.valid
        src.ready := dst.ready
    }

    def repeat(src: VecFixed, dst: VecFixed) = {
        var counter = 0
        for(f <- dst.x){
            f := src.x(counter%src.x.length)
            counter += 1
        }
        dst.last := src.last
    }

    def depart(src: DecoupledIO[VecFixed], dst: DecoupledIO[Vec[VecFixed]]) = {
        var counter = 0
        for(vecFixed <- dst.bits){
            for(f <- vecFixed.x){
                f := src.bits.x(counter%src.bits.x.length)
                counter += 1
            }
            vecFixed.last := src.bits.last
        }
        dst.valid := src.valid
        src.ready := dst.ready
    }

    def depart(src: VecFixed, dst: Vec[VecFixed]) = {
        var counter = 0
        for(vecFixed <- dst){
            for(f <- vecFixed.x){
                f := src.x(counter%src.x.length)
                counter += 1
            }
            vecFixed.last := src.last
        }
    }
}

class PEnlrPort(
    mulW: Int,
    mulBP: Int,
    addW: Int,
    addBP: Int
) extends Bundle{
    val actWeiIn = Flipped(Decoupled(new VecFixed(2, mulW, mulBP)))
    val sumIn = Flipped(Decoupled(new VecFixed(1, addW, addBP)))
    val sumOut = Decoupled(new VecFixed(1, addW, addBP))
}

class PEPort(
    mulW: Int,
    mulBP: Int,
    addW: Int,
    addBP: Int
) extends PEnlrPort(mulW, mulBP, addW, addBP){
    val statSel = Input(UInt(2.W))
    val weiEn = Input(Bool())
    val actEn = Input(Bool())
}

class PECrossPort(
    mulW: Int,
    mulBP: Int,
    addW: Int,
    addBP: Int
) extends PEPort(mulW, mulBP, addW, addBP){
    val actIn = Flipped(Decoupled(new VecFixed(1, mulW, mulBP)))
    val weiIn = Flipped(Decoupled(new VecFixed(1, mulW, mulBP)))
    val actOut = Decoupled(new VecFixed(1, mulW, mulBP))
    val weiOut = Decoupled(new VecFixed(1, mulW, mulBP))
}
