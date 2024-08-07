//ECE6370 Advanced Digital Design
//Team : UNAGI2.0
//MUX module
//This module selects one of the 2 one_bit inputs to be the
//output based on a select signal getting high

module Mymux_1bit(input1, input2, mux_output, select);
input input1, input2;
input select;
output mux_output;
reg mux_output;

always@(select) begin

if(select == 1'b1) begin

mux_output = input2;

end

else begin

mux_output = input1;

end

end

endmodule