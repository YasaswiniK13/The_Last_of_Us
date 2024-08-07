//ECE6370
//Team Unagi2.0
//this module compares players input with the sum of generated random numbers shifted by a key
module Verify(Key,Rng1,Rng2,Rng3,LR,compare);
input [3:0]Key,Rng1,Rng2,Rng3;
input [5:0]LR;
output compare;
reg [3:0]Temp1,Temp2,Temp3;
reg [5:0]Temp4;
reg compare;
always@(Key,Rng1,Rng2,Rng3,LR)
begin
Temp1=Rng1+Key;
Temp2=Rng2+Key;
Temp3=Rng3+Key;
Temp4 = Temp1+Temp2+Temp3;
if(Temp4==LR)
begin
compare=1'b0;
end
else
begin
compare=1'b1;
end
end
endmodule
