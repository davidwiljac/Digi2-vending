import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class VendingTester extends AnyFlatSpec with ChiselScalatestTester {
  "Vending machine test" should "pass" in {
    test(new VendingMachine(20, 2)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      println("We are generting a VCD file with the test of the vending machine")
      dut.io.price.poke(7.U)
      dut.clock.step(6)
      dut.io.coin2Raw.poke(true.B)
      dut.clock.step(6)
      dut.io.coin2Raw.poke(false.B)
      dut.clock.step(6)
      dut.io.coin5Raw.poke(true.B)
      dut.clock.step(6)
      dut.io.coin5Raw.poke(false.B)
      dut.clock.step(8)
      dut.io.buyRaw.poke(true.B)
      dut.clock.step(6)
      dut.io.buyRaw.poke(false.B)
      dut.clock.step(10)
    }
  }
  "Vending machine" should "Release can" in {
    test(new VendingMachine(20, 2)) { dut =>
      dut.io.price.poke(7.U)
      dut.clock.step(20)
      for(i <- 0 until 4){
        dut.io.coin2Raw.poke(true.B)
        dut.clock.step(20)
        dut.io.coin2Raw.poke(false.B)
        dut.clock.step(20)
      }
      dut.io.buyRaw.poke(true.B)
      dut.clock.step(20)
      dut.io.releaseCan.expect(true.B)
    }
  }
  "Vending machine" should "Not release can" in {
    test(new VendingMachine(20,2)) { dut =>
      dut.io.price.poke(7.U)
      dut.clock.step(20)
      for(i <- 0 until 2){
        dut.io.coin2Raw.poke(true.B)
        dut.clock.step(20)
        dut.io.coin2Raw.poke(false.B)
        dut.clock.step(20)
      }
      dut.io.buyRaw.poke(false.B)
      dut.clock.step(20)
      dut.io.releaseCan.expect(false.B)  
    }
  }
  "Vending machine" should "Pass in this random test" in {
    test(new VendingMachine(20,2)) { dut =>
      val r = new Random
      for(i <- 0 until 10){
        val price = r.nextInt(32)
        val numOf2Coins = r.nextInt(5)
        val numOf5Coins = r.nextInt(4)
        val sum = 0
        for(i <- 0 until numOf2Coins){
          dut.io.coin2Raw.poke(true.B)
          dut.clock.step(20)
          dut.io.coin2Raw.poke(false.B)
          dut.clock.step(20)
        }
        for(i <- 0 until numOf5Coins){
          dut.io.coin5Raw.poke(true.B)
          dut.clock.step(20)
          dut.io.coin5Raw.poke(false.B)
          dut.clock.step(20)
        }
        if(numOf2Coins*2 + numOf5Coins*5 >= price){
          dut.io.buyRaw.poke(true.B)
          dut.clock.step(20)
          dut.io.releaseCan.expect(true.B)
        } else {
          dut.io.buyRaw.poke(false.B)
          dut.clock.step(20)
          dut.io.releaseCan.expect(false.B)
        }
      }
    }
  }
  /*
  "Vending machine" should "run out" in {
    test(new VendingMachine(20,2)) { dut =>
      dut.io.price.poke(0.U)
      dut.clock.step(20)
      for(i <- 0 until 10){
        dut.io.coin2Raw.poke(true.B)
        dut.io.buyRaw.poke(true.B)
        dut.clock.step(20)
        dut.io.coin2Raw.poke(false.B)
        dut.io.buyRaw.poke(false.B)
      }
      dut.io.buyRaw.poke(true.B)
      dut.io.coin2Raw.poke(true.B)
      dut.clock.step(20)
      dut.io.coin2Raw.poke(false.B)
      dut.io.releaseCan.expect(true.B)
      dut.clock.step(20)
      dut.io.buyRaw.poke(true.B)
      dut.clock.step(20)
      dut.io.releaseCan.expect(false.B)
    }
  }
  */
}