FIRRTL version 1.1.0
circuit VendingMachine :
  module VendingMachine :
    input clock : Clock
    input reset : UInt<1>
    input io_price : UInt<5>
    input io_coin2 : UInt<1>
    input io_coin5 : UInt<1>
    input io_buy : UInt<1>
    output io_releaseCan : UInt<1>
    output io_alarm : UInt<1>
    output io_seg : UInt<7>
    output io_an : UInt<4>

    node sevSeg = UInt<7>("h7f") @[VendingMachine.scala 16:27 19:10]
    node _io_seg_T = not(sevSeg) @[VendingMachine.scala 25:13]
    io_releaseCan <= io_coin5 @[VendingMachine.scala 22:17]
    io_alarm <= io_coin2 @[VendingMachine.scala 21:12]
    io_seg <= _io_seg_T @[VendingMachine.scala 25:10]
    io_an <= UInt<4>("he") @[VendingMachine.scala 26:9]
