//ECE6370 Advanced Digital Design
//Team : UNAGI2.0
//Mymux_7bit
//This module selects one of the 2 seven bit inputs to be the 
//output based on a select signal getting high
 

module Mymux_7bit(input1, input2, mux_output, select);
input [6:0]input1, input2;
input select;
output [6:0]mux_output;
reg [6:0]mux_output;

always@(select) begin

if(select == 1'b1) begin

mux_output = input2;

end

else begin

mux_output = input1;

end

end

endmodule