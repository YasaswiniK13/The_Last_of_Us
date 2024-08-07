module HundredmsTimer(enable,clk,rst,HundredmsTimeout);
input enable, clk, rst;
output HundredmsTimeout;
wire OnemsTimeout;

OnemsTimer OnemsTimer1(enable,clk,rst,OnemsTimeout);

countto100 countto100_1(OnemsTimeout,clk,rst,HundredmsTimeout);


endmodule


