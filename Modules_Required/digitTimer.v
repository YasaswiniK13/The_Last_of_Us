//ECE6370 Advanced Digital Design
//Team: UNAGI2.0
// digitTimer
// This module count down timer for counting the values from 9 to 0.
module digitTimer(Borrowup, Borrowdown, NoBorrow_up, NoBorrow_down, reconfig, count, clk, rst, reconfig_value);
input Borrowdown, NoBorrow_up, reconfig;
input [3:0]reconfig_value;
output Borrowup, NoBorrow_down;
output [3:0]count;
input clk, rst;
reg [3:0]count;
reg NoBorrow_down, Borrowup;

always@(posedge clk) begin



if(rst == 1'b0)
begin
NoBorrow_down <= 1'b0;
Borrowup <= 1'b0;
count <= 4'b1001;
end

else begin
Borrowup <= 1'b0;



if(reconfig == 1'b1)
begin
NoBorrow_down <= 1'b0;
Borrowup <= 1'b0;
count <= reconfig_value;
end

else begin

if (Borrowdown == 1'b1) begin

if(count == 1 && NoBorrow_up == 1'b1) begin

NoBorrow_down <= 1'b1;
count <= count-1;
end

else if(count ==0 && NoBorrow_up == 1'b0) begin
Borrowup <= 1'b1;
count <= 4'b1001;
end
else if(count ==0 && NoBorrow_up == 1'b1) begin
count <= count;
end
else begin
count <= count-1;
NoBorrow_down <= 1'b0;
end



end


end
end
end





endmodule