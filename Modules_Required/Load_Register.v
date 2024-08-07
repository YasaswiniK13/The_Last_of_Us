// ECE-6370 Advanced Digital Design
// Team: UNAGI2.0
// Load_Register
// This module helps to load the values 
module Load_Register(D_in, D_out, clk, rst, load);
    input [3:0]D_in;
    output [3:0]D_out;
    input clk, rst, load;
    reg [3:0]D_out;

    always@(posedge clk)
        begin
            if(rst==1'b0) 
               begin
                  D_out<=4'b1000;
               end
            else
               begin
                   if(load==1'b1)
                      begin
                         D_out<=D_in;
                      end
               end
        end
endmodule 
