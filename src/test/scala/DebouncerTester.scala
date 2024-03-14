import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DebouncerTester extends AnyFlatSpec with ChiselScalatestTester {
    "debouncer test" should "pass" in {
    test(new Debouncer(5)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
        println("We are generting a VCD file with the test of the debouncer")

        dut.clock.step(2)
        dut.io.in.poke(false.B)
        dut.clock.step(6)
        dut.io.in.poke(true.B)
        dut.clock.step(6)
        dut.io.in.poke(false.B)
        dut.clock.step(1)
        dut.io.in.poke(true.B)
        dut.clock.step(1)
        dut.io.in.poke(false.B)
        dut.clock.step(2)

        dut.io.in.poke(true.B)
        dut.clock.step(1)
        dut.io.in.poke(false.B)
        dut.clock.step(3)

        dut.io.in.poke(true.B)
        dut.clock.step(1)
        dut.io.in.poke(false.B)
        dut.clock.step(4)

        dut.io.in.poke(true.B)
        dut.clock.step(1)
        dut.io.in.poke(false.B)
        dut.clock.step(5)

        dut.io.in.poke(true.B)
        dut.clock.step(1)
        dut.io.in.poke(false.B)
        dut.clock.step(6)

        dut.io.in.poke(true.B)
        dut.clock.step(1)
        dut.io.in.poke(false.B)
        dut.clock.step(10)

        dut.io.in.poke(true.B)
        dut.clock.step(1)
        dut.io.in.poke(false.B)
        dut.clock.step(10)


      
    }
  }
}
