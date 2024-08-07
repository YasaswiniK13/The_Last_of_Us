//ECE6370 Advanced Digital Design
//Team: UNAGI2.0
// LEDblink
// This module helps to blink the LEDs
module LEDblink(clk, rst, outputbits, timer, timeout);


output [9:0]outputbits;
output timeout;
input timer, clk, rst;

reg [9:0]outputbits;
reg [3:0]count;
reg timeout;

always@(posedge clk) begin

if(rst == 1'b0) begin

outputbits <= 10'd0;
count <= 0;
timeout <= 1'b0;
end

else begin

if(timer == 1'b1) begin
	
	count <= count +1;
	if(count == 7) begin
	  timeout <= 1'b1;
	  count <= 0;
	  end
	  
	 else begin
  
		if(outputbits == 10'd0) begin
		outputbits <= 10'b1111111111;
		end

		else begin

		outputbits <= 10'd0;
		end
	end
end
else begin
 timeout <= 0;
end
end
end


endmodule
