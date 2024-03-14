file:///C:/Users/David/Desktop/OneDrive%20-%20Danmarks%20Tekniske%20Universitet/Skole%20ting/2%20sem/DIGI%202/Digi2-vending/src/main/scala/DisplayMultiplexer.scala
### java.lang.IndexOutOfBoundsException: 0

occurred in the presentation compiler.

presentation compiler configuration:
Scala version: 3.3.1
Classpath:
<HOME>\AppData\Local\Coursier\cache\v1\https\repo1.maven.org\maven2\org\scala-lang\scala3-library_3\3.3.1\scala3-library_3-3.3.1.jar [exists ], <HOME>\AppData\Local\Coursier\cache\v1\https\repo1.maven.org\maven2\org\scala-lang\scala-library\2.13.10\scala-library-2.13.10.jar [exists ]
Options:



action parameters:
offset: 568
uri: file:///C:/Users/David/Desktop/OneDrive%20-%20Danmarks%20Tekniske%20Universitet/Skole%20ting/2%20sem/DIGI%202/Digi2-vending/src/main/scala/DisplayMultiplexer.scala
text:
```scala
import chisel3._
import chisel3.util._

class DisplayMultiplexer(maxCount: Int) extends Module {
  val io = IO(new Bundle {
    val customIn = Input(Vec(4, UInt(7.W)))
    val sum = Input(UInt(7.W))
    val price = Input(UInt(5.W))
    val seg = Output(UInt(7.W))
    val an = Output(UInt(4.W))
  })

  val sevSeg = WireDefault("b1111111".U(7.W))
  val selectReg = RegInit(0.U(2.W))

  val table = Module(new BcdTable())
  table.io.address := 0.U

  val decoder = Module(new SevenSegDec())
  decoder.io.custom := 0.U
  for(i in 0 until 4){customIn(@@)}
  decoder.io.in := 0.U
  sevSeg := decoder.io.out

  val tickCounterReg = RegInit (0.U(17.W))
  val tick = tickCounterReg === (maxCount-1).U
  tickCounterReg := tickCounterReg + 1.U
  
  when (tick) {
    tickCounterReg := 0.U
    selectReg := selectReg + 1.U
  }

  switch(selectReg) {
    is(0.U) {
      table.io.address := io.price
      decoder.io.in := table.io.data(3,0)
    }
    is(1.U) {
      table.io.address := io.price
      decoder.io.in := table.io.data(7,4)
    }
    is(2.U) {
      table.io.address := io.sum
      decoder.io.in := table.io.data(3,0)
    }
    is(3.U) {
      table.io.address := io.sum
      decoder.io.in := table.io.data(7,4)
    }
  }

  // Handles custom input
  when (io.customIn =/= 0.U) {
    decoder.io.custom := 1.U
    decoder.io.customIn := io.customIn
  }
  // *** your code ends here

  io.seg := sevSeg
  io.an := ~(1.U << selectReg)
}

// BcdTable from Chisel book (10.4)
class BcdTable extends Module {
  val io = IO(new Bundle {
    val address = Input(UInt(8.W))
    val data = Output(UInt(8.W))
  })

  val table = Wire(Vec (100 , UInt (8.W)))

  // Convert binary to BCD
  for (i <- 0 until 100) {
    table(i) := (((i/10) <<4) + i%10).U
  }

  io.data := table(io.address)
}
```



#### Error stacktrace:

```
scala.collection.LinearSeqOps.apply(LinearSeq.scala:131)
	scala.collection.LinearSeqOps.apply$(LinearSeq.scala:128)
	scala.collection.immutable.List.apply(List.scala:79)
	dotty.tools.dotc.util.Signatures$.countParams(Signatures.scala:501)
	dotty.tools.dotc.util.Signatures$.applyCallInfo(Signatures.scala:186)
	dotty.tools.dotc.util.Signatures$.computeSignatureHelp(Signatures.scala:94)
	dotty.tools.dotc.util.Signatures$.signatureHelp(Signatures.scala:63)
	scala.meta.internal.pc.MetalsSignatures$.signatures(MetalsSignatures.scala:17)
	scala.meta.internal.pc.SignatureHelpProvider$.signatureHelp(SignatureHelpProvider.scala:51)
	scala.meta.internal.pc.ScalaPresentationCompiler.signatureHelp$$anonfun$1(ScalaPresentationCompiler.scala:398)
```
#### Short summary: 

java.lang.IndexOutOfBoundsException: 0