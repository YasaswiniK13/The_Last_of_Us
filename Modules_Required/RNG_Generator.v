//ECE6370
//Team Unagi2.0
//this module generates three random numbers and key
module RNG_Generator(clk, rst, RNG_1, RNG_2, RNG_3, Key);
 
 input clk, rst;
 output [3:0]RNG_1;
 output [3:0]RNG_2;
 output [3:0]RNG_3;
 output [3:0]Key; 
 wire [15:0]Random_Number;
 
 Counter Counter1(clk, rst, Random_Number);
 assign RNG_1 ={Random_Number[0],Random_Number[1],Random_Number[3],Random_Number[2]};
 assign RNG_2 ={Random_Number[6],Random_Number[7],Random_Number[5],Random_Number[4]};
 assign RNG_3 ={Random_Number[12],Random_Number[13],Random_Number[15],Random_Number[14]};
 assign Key ={1'b0,Random_Number[9],Random_Number[11],Random_Number[10]};
 
 
endmodule
