module Mymux_spcl(input1, mux_output, select);
input [3:0]input1;
input select;
output [3:0]mux_output;
reg [3:0]mux_output;

always@(select) begin

if(select == 1'b1) begin

mux_output = 4'b0000;

end

else begin

mux_output = input1;

end

end

endmodule