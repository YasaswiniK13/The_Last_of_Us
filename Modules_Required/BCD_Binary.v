//ECE 6370 ADVANCED DIGITAL DESIGN 
// Team UNAGI2.0
// BCD_Binary
// This module converts two digit BCD into it?s corresponding binary number.
module BCD_Binary(ones, tens, binary);

 input [3:0]ones;
 input [3:0]tens;
 output [5:0]binary;
 reg [5:0]binary;
 reg [5:0]tens_reg;
 reg [5:0]ones_reg;
 
 always @(ones, tens) 
  begin
  case(tens)
       4'd1:begin
            tens_reg=6'd10;
            end
       4'd2:begin
            tens_reg=6'd20;
            end
       4'd3:begin
            tens_reg=6'd30;
            end
       4'd4:begin
            tens_reg=6'd40;
            end
       4'd5:begin
            tens_reg=6'd50;
            end
    default:begin
            tens_reg=6'd0;
            end 
    endcase
    ones_reg={2'b00,ones};
    binary=ones_reg+tens_reg;
    end
endmodule
