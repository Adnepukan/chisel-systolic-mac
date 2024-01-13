import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class PipelineHsk(level: Int) extends Module{
    val io = IO(new Bundle{
        val validPre = Input(Bool())
        val readyPre = Output(Bool())
        val lastPre = Input(Bool())
        val validNxt = Output(Bool())
        val readyNxt = Input(Bool())
        val regen = Output(Vec(level, Bool()))
        val lastNxt = Output(Bool())
    })

    val valid = Wire(Vec(level+1, Bool()))
    val ready = Wire(Vec(level+1, Bool()))
    val last = Wire(Vec(level+1, Bool()))

    for(i<-0 until level){
        valid(i+1) := RegEnable(valid(i), 0.B, ready(i))
        last(i+1) := RegEnable(last(i), 0.B, io.regen(i))
        ready(i) := ready(i+1) | ~valid(i+1)
        io.regen(i) := valid(i) & ready(i)
    }
    valid(0) := io.validPre
    io.readyPre := ready(0)
    io.validNxt := valid(level)
    ready(level) := io.readyNxt
    last(0) := io.lastPre
    io.lastNxt := last(level)
}
