//ECE6370
//Team Unagi2.0
//this module tracks players personal best and global best scores
module ScoreTrack(score_req, PlayerID, isGuest, score, PersonalBest, RAMdata_reg, GlobalWinner, GlobalWinnerID, GlobalWinnerScore, valid, write_enable, RAMdata_out, 
RAMdata_in, RAMaddr, clk, rst);

input score_req, isGuest;
input clk, rst;
input [2:0]PlayerID;
input [6:0]score;
input [6:0]RAMdata_in;
output write_enable;
output [6:0]RAMdata_out;
output [4:0]RAMaddr;
output PersonalBest;
output GlobalWinner;
output [6:0]GlobalWinnerScore;
output [3:0]GlobalWinnerID;
output valid;
output [6:0]RAMdata_reg;

reg [6:0]RAMdata_reg;
reg [2:0]PlayerID_reg;
reg [6:0]score_reg;
reg [6:0]RAMdata_out;
reg [4:0]RAMaddr;
reg [6:0]PersonalBest;
reg [6:0]GlobalWinnerScore;
reg [3:0]GlobalWinnerID;
reg GlobalWinner;
reg valid;
reg RAM_initialized;
reg [3:0]State;
reg write_enable;

parameter RAM_INIT = 0, WAIT_FOR_SCORE = 1, FETCH_RAM = 2, RAMCYCLE1 = 3, RAMCYCLE2 = 4, CATCH_RAM = 5, COMPARE = 6, WRITE_RAM = 7, CHECK_GLOBAL_WINNER = 8;


always@(posedge clk) begin

if(rst == 1'b0) begin

RAM_initialized <= 1'b0;
State <= RAM_INIT;
valid <= 1'b0;
RAMaddr <= 0;
write_enable <= 1'b0;
PersonalBest <= 0;
GlobalWinnerScore <= 0;
GlobalWinner <= 0;
GlobalWinnerID <= 0;
RAMdata_reg <= 0;

end

else begin


     case(State)

	RAM_INIT: begin

	

	if(RAMaddr == 31) begin
	State <= WAIT_FOR_SCORE;
	RAM_initialized <= 1'b1;
	write_enable <= 1'b1;
	RAMdata_out <= 0;
	end

	else begin
	RAMaddr <= RAMaddr +1;
	RAMdata_out <= 0;
	write_enable <= 1'b1;
	State <= RAM_INIT;
	
	end

	end

	WAIT_FOR_SCORE: begin
	
	valid <= 1'b0;
	PersonalBest <= 1'b0;
	GlobalWinner <= 1'b0;
	write_enable <= 1'b0;

	if(score_req == 1'b1) begin
	 if(isGuest == 1'b1) begin
	score_reg <= score;
	State <= CHECK_GLOBAL_WINNER;
	end 
	else begin
	PlayerID_reg <= PlayerID;
	score_reg <= score;
	State <= FETCH_RAM;
	end
	
	end

	else begin
	State <= WAIT_FOR_SCORE;
	end

	end
	
	FETCH_RAM: begin

	RAMaddr <= {2'b00, PlayerID_reg};
	State <= RAMCYCLE1;
	end

	RAMCYCLE1: begin
	State <= RAMCYCLE2;
	end

	RAMCYCLE2: begin

	State <= CATCH_RAM;
	end

	CATCH_RAM: begin

	RAMdata_reg <= RAMdata_in;
	State <= COMPARE;
	end

	COMPARE: begin

	if(score_reg > RAMdata_reg) begin
	State <= WRITE_RAM;
	RAMdata_reg <= score_reg;
	write_enable <= 1'b1;
	end

	else begin
	State <= WAIT_FOR_SCORE;
	write_enable <= 1'b0;
	end

	end

	WRITE_RAM: begin

	RAMdata_out <= score_reg;
	State <= CHECK_GLOBAL_WINNER;
	end

	CHECK_GLOBAL_WINNER: begin
	
	valid <= 1'b1;
        PersonalBest <= 1'b1;
	write_enable <= 1'b0;
	if(score_reg > GlobalWinnerScore) begin
	GlobalWinnerScore <= score_reg;
	GlobalWinnerID <= {1'b0,PlayerID};
	GlobalWinner <= 1'b1;
	State <= WAIT_FOR_SCORE;
	end
	else begin
	State <= WAIT_FOR_SCORE;
	end
	end

	default: begin

	RAM_initialized <= 1'b0;
	State <= RAM_INIT;
	RAMaddr <= 0;
	write_enable <= 1'b0;
	GlobalWinnerScore <= 0;
	RAMdata_reg <= 0;
	end

      endcase
    end
   end


endmodule