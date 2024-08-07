//
//ECE 6370 
// Team Unagi2.0
//this module checks the password with respect to the id and sets the game to logged in state if the right password is entered
module Pswdcheck(PlayerPswd, Pswd_enter, ID_IDcheck, IDmatched, isGuest_ID , GC_Logout, Pswd_Internal_PlayerID, Logout_ID, Pswd_ROMaddr, Pswd_ROMdata, Loggedin,
 isGuest_Pswd, clk, rst);

input [3:0]PlayerPswd;
input clk, rst;
input GC_Logout, Pswd_enter;
input [23:0]Pswd_ROMdata;
input IDmatched, isGuest_ID;
input [2:0]ID_IDcheck;
output [2:0]Pswd_Internal_PlayerID;
output [4:0]Pswd_ROMaddr;
output Logout_ID, Loggedin, isGuest_Pswd;

reg [4:0]Pswd_ROMaddr;
reg [2:0]Pswd_Internal_PlayerID;
reg Loggedin;
reg [3:0]State;
reg [23:0]PlayerPswd_reg;
reg [23:0]PswdROMdata_reg;
reg isGuest_Pswd, Logout_ID;
reg [1:0]wrongpswd_count;
reg [2:0]waitcount;


parameter DIGIT1 = 0, DIGIT2 = 1, DIGIT3 = 2, DIGIT4 = 3, DIGIT5 = 4, DIGIT6 = 5, FETCH_ROM = 6, ROMCYCLE1 = 7, ROMCYCLE2 = 8, CATCH_ROM = 9, COMPARE = 10, WAIT = 11,
 PASSED = 12;


always@(posedge clk) begin

if(rst == 1'b0) begin
Pswd_ROMaddr <= 0;
Pswd_Internal_PlayerID <= ID_IDcheck;
Loggedin <= 1'b0;
State <= DIGIT1;
isGuest_Pswd <= isGuest_ID;
Logout_ID <= 1'b0;
wrongpswd_count <= 2'b00;
waitcount <= 3'b000;

end

else begin

case(State)

     DIGIT1: begin
	
	Loggedin <= 1'b0;
	Logout_ID <= 1'b0;
	Pswd_Internal_PlayerID <= ID_IDcheck;
	isGuest_Pswd <= isGuest_ID;
	if(Pswd_enter == 1'b1 && IDmatched == 1'b1) begin
	PlayerPswd_reg[23:20] <= PlayerPswd;
	waitcount <= 3'b000;
        State <= DIGIT2;
	end

	else begin
	State <= DIGIT1;
	end

	end

     DIGIT2: begin
	
	if(Pswd_enter == 1'b1) begin
	PlayerPswd_reg[19:16] <= PlayerPswd;
        State <= DIGIT3;
	end

	else begin
	State <= DIGIT2;
	end
	
	end

     DIGIT3: begin
	
	if(Pswd_enter == 1'b1) begin
	PlayerPswd_reg[15:12] <= PlayerPswd;
        State <= DIGIT4;
	end

	else begin
	State <= DIGIT3;
	end

	end

     DIGIT4: begin
	
	if(Pswd_enter == 1'b1) begin
	PlayerPswd_reg[11:8] <= PlayerPswd;
        State <= DIGIT5;
	end

	else begin
	State <= DIGIT4;
	end

	end

     DIGIT5: begin
	
	if(Pswd_enter == 1'b1) begin
	PlayerPswd_reg[7:4] <= PlayerPswd;
        State <= DIGIT6;
	end

	else begin
	State <= DIGIT5;
	end

	end

     DIGIT6: begin
	
	if(Pswd_enter == 1'b1) begin
	PlayerPswd_reg[3:0] <= PlayerPswd;
        State <= FETCH_ROM;
	end

	else begin
	State <= DIGIT6;
	end

	end

     FETCH_ROM: begin

	Pswd_ROMaddr <= {2'b00, Pswd_Internal_PlayerID};
	State <= ROMCYCLE1;
	end

     ROMCYCLE1: begin

	State <= ROMCYCLE2;
	end

     ROMCYCLE2: begin

	State <= CATCH_ROM;
	end
	
     CATCH_ROM: begin

	PswdROMdata_reg <= Pswd_ROMdata;
	State <= COMPARE;
	end

     COMPARE: begin
	
	if(PlayerPswd_reg == PswdROMdata_reg) begin
	State <= PASSED;
	end

	else begin
	wrongpswd_count <= wrongpswd_count+1;
	
	if(wrongpswd_count <= 2'b11) begin
	Logout_ID <= 1'b1;
	waitcount <= 0;
	State <= WAIT;
	end
	else begin
	State <= DIGIT1;
	end

	end
	end

     PASSED: begin

	Loggedin <= 1'b1;
	
	if(GC_Logout == 1'b1) begin
	Logout_ID <= 1'b1;
	waitcount <= 0;
	State <= WAIT;
	Loggedin <= 1'b0;
	end
	
	else begin
	State <= PASSED;
	end

	end

     WAIT: begin
	
	Logout_ID <= 1'b0;
	waitcount <= waitcount + 1;
	if(waitcount == 5) begin
	State <= DIGIT1;
	
	end

	else begin
	State <= WAIT;
	end

	end
	
	
	

     default: begin

	Loggedin <= 1'b0;
	Pswd_Internal_PlayerID <= ID_IDcheck;
	isGuest_Pswd <= isGuest_ID;
	State <= DIGIT1;
	end

     endcase

    end
  end

endmodule