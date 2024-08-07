module HalfsecTimer(enable,clk,rst,OnesecTimeout);
input enable, clk, rst;
output OnesecTimeout;
wire HundredmsTimeout;

HundredmsTimer HundredmsTimer1(enable, clk, rst, HundredmsTimeout);

countto10 countto10_1(HundredmsTimeout,clk,rst,OnesecTimeout);


endmodule
	
	