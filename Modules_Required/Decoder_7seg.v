//ECE6370
//Team Unagi2.0
//Decoder module
//This is a decoder module that converts 4 bit input to 7 bit //output so that the output can directly be fed into seven
//segment display


module Decoder_7seg(decoder_in, decoder_out);

input [3:0]decoder_in;
output [6:0]decoder_out;
reg [6:0]decoder_out;

always@(decoder_in)
begin

case(decoder_in)
4'b0000: begin decoder_out = 7'b0000001; end
4'b0001: begin decoder_out = 7'b1001111; end
4'b0010: begin decoder_out = 7'b0010010; end
4'b0011: begin decoder_out = 7'b0000110; end
4'b0100: begin decoder_out = 7'b1001100; end
4'b0101: begin decoder_out = 7'b0100100; end
4'b0110: begin decoder_out = 7'b0100000; end
4'b0111: begin decoder_out = 7'b0001111; end
4'b1000: begin decoder_out = 7'b0000000; end
4'b1001: begin decoder_out = 7'b0001100; end
4'b1010: begin decoder_out = 7'b0001000; end
4'b1011: begin decoder_out = 7'b1100000; end
4'b1100: begin decoder_out = 7'b0110001; end
4'b1101: begin decoder_out = 7'b1000010; end
4'b1110: begin decoder_out = 7'b0110000; end
4'b1111: begin decoder_out = 7'b0111000; end
default: begin decoder_out = 7'b1111111; end

endcase
end
endmodule
