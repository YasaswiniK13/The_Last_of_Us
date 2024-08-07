//ECE 6370 ADVANCED DIGITAL DESIGN 
// Team UNAGI2.0
// binary_BCD
// This module converts a binary number to a BCD number.
module binary_BCD(binary, ones, tens, clk, rst);

 input clk,rst;
 input [6:0] binary;
 output [3:0] ones;
 output [3:0] tens;
 reg [3:0] ones;
 reg [3:0] tens;
 reg [1:0] state;
 reg [6:0]count;
 reg [6:0] ones_reg;
 parameter check=1, two_digit=2, BCD=3; 

  always@(posedge clk)begin
  if(rst==1'b0)begin
      ones<=0;
      tens<=0;
      state<=check;
      count<=7'd10;
      ones_reg<=0;
   end
  else begin
     case(state)
        check:begin
           if(binary<7'd10)  begin
              ones <= binary[3:0];
               tens <= 0;
               state <= check;
            end
           else begin
              state <= two_digit;
           end
        end

         two_digit:begin
             if((binary-count)>9)begin
                 count=count+7'd10;
                 state<=two_digit;
             end
             else begin
                  ones_reg <= binary-count;
                  state <= BCD;
              end
          end

          BCD:begin
		state <= check;
                ones<=ones_reg[3:0];
                case(count)
                   7'd10:begin
                       tens<=4'd1;
                      end
                   7'd20:begin
                       tens<=4'd2;
                      end
                   7'd30:begin
                       tens<=4'd3;
                      end
                   7'd40:begin
                       tens<=4'd4;
                      end
                   7'd50:begin
                       tens<=4'd5;
                      end
                   7'd60:begin
                       tens<=4'd6;
                      end
                   7'd70:begin
                       tens<=4'd7;
                      end
                   7'd80:begin
                       tens<=4'd8;
                      end
                   7'd90:begin
                       tens<=4'd9;
                      end
		   default: begin
			tens<=0;
			state <= BCD;
			end
                 endcase
             end
         endcase
       end
    end
endmodule





 

