//ECE6370 
//Author:Team UNAGI-2.0, 
//Mymux_10bit
//This module selects one of the 2 ten bit inputs to be the 
//output based on a select signal getting high
 

module Mymux_10bit(input1, input2, mux_output, select);
input [9:0]input1, input2;
input select;
output [9:0]mux_output;
reg [9:0]mux_output;

always@(select) begin

if(select == 1'b1) begin

mux_output = input2;

end

else begin

mux_output = input1;

end

end

endmodule