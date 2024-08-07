module TwodigitTimer(Timer_reconfig, Timer_enable, Timeout, Ones7seg, Tens7seg, clk, rst, reconfig_value_ones, reconfig_value_tens);
input Timer_reconfig, Timer_enable;
input [3:0]reconfig_value_ones, reconfig_value_tens;
input clk, rst;
output [3:0]Ones7seg, Tens7seg;
output Timeout;
wire BorrowT_O, NoBorrowT_O, OnesecTimeout;
wire Borrowup;

OnesecTimer OnesecTimer1(Timer_enable,clk,rst,OnesecTimeout);
digitTimer digitTimer1(BorrowT_O, OnesecTimeout, NoBorrowT_O, Timeout, Timer_reconfig, Ones7seg, clk, rst, reconfig_value_ones);
digitTimer digitTimer2(Borrowup, BorrowT_O, 1'b1, NoBorrowT_O, Timer_reconfig, Tens7seg, clk, rst, reconfig_value_tens);


endmodule