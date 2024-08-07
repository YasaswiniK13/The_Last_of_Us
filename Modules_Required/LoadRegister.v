//ECE6370
//Author: Atul Sai Donakanti, 6528
//Load Register module
//This is basically a register and stores values whenever there is a load 
//'pulse' input. 


module LoadRegister(D_in, D_out, clk, rst, load);
input [3:0]D_in;
input clk, rst, load;
output [3:0]D_out;
reg [3:0] D_out;

always@(posedge clk) begin

 if(rst == 1'b0)
 begin
 D_out <= 4'b0000;
 end

 else
 begin
 if(load == 1'b1)
 begin
 D_out <= D_in;
end

end

end


endmodule
