module OnemsTimer(enable,clk,rst,OnemsTimeout);
input enable, clk, rst;
output OnemsTimeout;
reg [15:0]count_1ms;
reg OnemsTimeout;


always@(posedge clk) begin

  if(rst == 1'b0) 
    begin 
    OnemsTimeout <= 1'b0;
    count_1ms <= 0;
    
    end
  else 
  begin
     if(count_1ms == 50000)
	 begin
         count_1ms = 0;
         OnemsTimeout <= 1'b1; 
	 end
    else begin
         OnemsTimeout <= 1'b0;
         end 
    if(enable == 1'b1)
	begin
	count_1ms <= count_1ms+1;
       
	end
   
  end
 end
endmodule
	
