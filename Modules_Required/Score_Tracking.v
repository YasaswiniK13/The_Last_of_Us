//ECE6370
//Team Unagi2.0
//top level module which has score track and RAM
module Score_Tracking(score_req, PlayerID, isGuest, score, PersonalBest, RAMdata_reg, GlobalWinner, GlobalWinnerID, GlobalWinnerScore, valid, clk, rst );
 
 input score_req, isGuest;
 input clk, rst;
 input [2:0]PlayerID;
 input [6:0]score;
 wire [6:0]RAMdata_in;
 wire write_enable;
 wire [6:0]RAMdata_out;
 wire [4:0]RAMaddr;
 output PersonalBest;
 output GlobalWinner;
 output [6:0]GlobalWinnerScore;
 output [3:0]GlobalWinnerID;
 output valid;
 output [6:0]RAMdata_reg;

 ScoreTrack ScoreTrack1(score_req, PlayerID, isGuest, score, PersonalBest, RAMdata_reg, GlobalWinner, GlobalWinnerID, 
            GlobalWinnerScore, valid, write_enable, RAMdata_out, RAMdata_in, RAMaddr, clk, rst);

 RAM_ScoreTrack RAM_scoretrack1(RAMaddr,clk,RAMdata_out,write_enable,RAMdata_in);

endmodule
