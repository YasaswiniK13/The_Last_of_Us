//ECE 6370 ADVANCED DIGITAL DESIGN 
// Team UNAGI2.0
// countto100
// The count to 100 module takes the 1msTimeout as input and counts the number of 1msTimeout pulses
module countto100(OnemsTimeout,clk,rst,HundredmsTimeout);
input OnemsTimeout, clk, rst;
output HundredmsTimeout;
reg [6:0]count_100ms;
reg HundredmsTimeout;



always@(posedge clk) begin

  if(rst == 1'b0) 
    begin 
    HundredmsTimeout <= 1'b0;
    count_100ms <= 0;
    end
  else 
  begin
      if(count_100ms == 100)
	 begin
         HundredmsTimeout <= 1'b1; 
         count_100ms = 0;
        
	 end
    else begin
         HundredmsTimeout <= 1'b0;
         end 
    if(OnemsTimeout == 1'b1)
	begin
	count_100ms <= count_100ms+1;
       
	end
 end
end
endmodule
	
