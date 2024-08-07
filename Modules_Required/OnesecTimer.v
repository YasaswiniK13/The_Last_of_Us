//ECE6370
//Team Unagi2.0
//a one second timer module which sends the timeout signal
module OnesecTimer(enable,clk,rst,OnesecTimeout);
input enable, clk, rst;
output OnesecTimeout;
wire HundredmsTimeout;

HundredmsTimer HundredmsTimer1(enable, clk, rst, HundredmsTimeout);

countto10 countto10_1(HundredmsTimeout,clk,rst,OnesecTimeout);


endmodule
	
	