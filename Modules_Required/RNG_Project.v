//ECE6370
//Team Unagi2.0
//this is the top level module of random number generation, this includes the random number generator module along with the load registers
module RNG_Project(clk, rst, load, RNG_1_OUT, RNG_2_OUT, RNG_3_OUT, Key_OUT);
 
 input clk, rst;
 wire [3:0]RNG_1;
 wire [3:0]RNG_2;
 wire [3:0]RNG_3;
 wire [3:0]Key; 
 input load;
 output [3:0]RNG_1_OUT;
 output [3:0]RNG_2_OUT;
 output [3:0]RNG_3_OUT;
 output [3:0]Key_OUT;
 
 RNG_Generator RNG_Generator1(clk, rst, RNG_1, RNG_2, RNG_3, Key);
 Load_Register Load_Register1(RNG_1, RNG_1_OUT, clk, rst, load);
 Load_Register Load_Register2(RNG_2, RNG_2_OUT, clk, rst, load);
 Load_Register Load_Register3(RNG_3, RNG_3_OUT, clk, rst, load);
 Load_Register Load_Register4(Key, Key_OUT, clk, rst, load);
  
endmodule

