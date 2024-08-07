//ECE 6370 ADVANCED DIGITAL DESIGN 
// Team UNAGI2.0
// Countto5
// This moudule count pluses of 100ms here if count is equal to 5 then it will timeout.
module countto5(HundredmsTimeout,clk,rst,OnesecTimeout);
input HundredmsTimeout, clk, rst;
output OnesecTimeout;
reg [3:0]count_1s;
reg OnesecTimeout;


always@(posedge clk) begin

  if(rst == 1'b0) 
    begin 
    OnesecTimeout <= 1'b0;
    count_1s <= 0;
    end
  else 
  begin

     if(count_1s == 5)
	   begin
           OnesecTimeout <= 1'b1;
	   count_1s  = 0;          
	   
	   end
         else begin
           OnesecTimeout <= 1'b0;
         end
    if(HundredmsTimeout == 1'b1)
	begin
	count_1s <= count_1s+1;
	
	end
    
  end
 end
endmodule
	
	