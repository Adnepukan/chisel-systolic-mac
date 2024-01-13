import chisel3._
import chisel3.util._
import chisel3.experimental._
import scala.math._

class CounterHsk(
    latency: Int
) extends Module{
    val counterWidth = (log(latency)/log(2)).toInt+1

    val io = IO(new Bundle{
        val validPre = Input(Bool())
        val readyPre = Output(Bool())
        val validNxt = Output(Bool())
        val readyNxt = Input(Bool())
        val lastPre = Input(Bool())
        val lastNxt = Output(Bool())
        val regen = Output(Bool())
    })

    val counterNxt = Wire(UInt(counterWidth.W))
    val counterEn = Wire(Bool())
    val counter = RegEnable(counterNxt, 0.U(counterWidth.W), counterEn)
    counterNxt := Mux(
        counter===latency.U(counterWidth.W),
        Mux(io.validPre&io.readyPre, 1.U(counterWidth.W), 0.U(counterWidth.W)),
        counter+1.U(counterWidth.W)
    )
    io.regen := (io.validPre&io.readyPre|(~((counter===0.U(counterWidth.W))|(counter===latency.U(counterWidth.W)))))
    counterEn := io.validNxt&io.readyNxt|io.regen
    io.readyPre := ((counter===0.U(counterWidth.W))|io.validNxt&io.readyNxt)
    io.validNxt := (counter===latency.U(counterWidth.W))
    io.lastNxt := RegEnable(io.lastPre, 0.U, io.validPre&io.validNxt&io.regen)
}

object CounterHsk extends App{
    println(getVerilogString(new CounterHsk(4)))
}
