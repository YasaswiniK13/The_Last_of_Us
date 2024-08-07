//ECE 6370 ADVANCED DIGITAL DESIGN 
// Team UNAGI2.0
//Button Shaper module
//This modules converts a long low signal into a single clock cycle "pulse"

module ButtonShaper(B_in, B_out, clk, rst);
input B_in, clk, rst;
output B_out;
reg B_out;

parameter INIT = 0, PULSE = 1, WAIT = 2;

reg[1:0]State, StateNext;

always@(posedge clk)
begin

if(rst == 1'b0)
begin
State <= INIT;
end

else
begin
State<=StateNext;
end

end

always@(State, B_in)
begin

case(State)
INIT: begin
B_out = 1'b0;
if(B_in == 1'b0)
begin
StateNext = PULSE;
end

else begin
StateNext = INIT;
end
end

PULSE: begin
B_out = 1'b1;

StateNext = WAIT;

end

WAIT: begin
B_out = 1'b0;
if(B_in == 1'b1)
begin
StateNext = INIT;
end

else begin
StateNext = WAIT;
end
end

default:begin
B_out = 1'b0;
StateNext = INIT;
end



endcase



end

endmodule