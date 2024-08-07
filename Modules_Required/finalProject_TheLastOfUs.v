//ECE6370 Advanced Digital Design
//Team: UNAGI2.0
//finalProject_TheLastOfus
// Main Module of Final Project.
module finalProject_TheLastOfUs(ID_PSWD_switches, PlayerInput_switches, PlayerLoad_button, MultiPurpose_button, ID_PswdEnter_GS_button, decoder0_out, 
                                decoder1_out, decoder2_out, decoder3_out, decoder4_out, decoder5_out, clk, rst, LEDs);
input [3:0]ID_PSWD_switches, PlayerInput_switches;
input PlayerLoad_button, MultiPurpose_button, ID_PswdEnter_GS_button;
input clk, rst;
output [6:0]decoder0_out, decoder1_out, decoder2_out, decoder3_out, decoder4_out, decoder5_out;
output [9:0]LEDs;

wire [8:0]LEDArray_output;
wire ZeroLED;

wire [9:0]LEDArray2;
wire HalfsecTimeout;
wire [9:0]LEDArray1;
wire IDmatched;
wire [9:0]LEDArray;
wire Logout, Loggedin, isGuest;
wire [2:0] Player_InternalID;
wire [3:0] Key, RNG1, RNG2, RNG3;
wire PswdEnter_GS, MP_button, Player_load_in, PR_select,load_rng, sum_correct_verif,sum_correct,player_load_out;
wire score_display, GlobalScore_display, score_req_in, score_req_out, valid, PersonalBest, GlobalWinner;
wire [6:0]score;
wire timer_reconfig, timer_enable,time_out;
wire [3:0]reconfig_ones_digit, reconfig_tens_digit;
wire [6:0] PersonalBestScore, GlobalWinnerScore;
wire [3:0] GlobalWinnerID;
wire [5:0]Playerinput_binary;
wire [3:0]LRones_out, LRtens_out;
wire [3:0]score_ones, score_tens, Pscore_ones, Pscore_tens, Gscore_ones, Gscore_tens;
wire [3:0]PR_MUXones, PR_MUXtens, scoreMUX_ones, scoreMUX_tens, timer_ones, timer_tens;
wire [3:0]GscoreMUX_1, GscoreMUX_2, GscoreMUX_3, GscoreMUX_4, GscoreMUX_5, GscoreMUX_6, Ones7seg, Tens7seg;

wire half_timer_enable, half_timeout;


AccessController AccessController1(ID_PSWD_switches, PswdEnter_GS, Logout, Loggedin, Player_InternalID, isGuest, clk, rst, IDmatched);

GameController GameController1(timer_reconfig,reconfig_ones_digit, reconfig_tens_digit, timer_enable,time_out,Loggedin,Player_InternalID, isGuest, 
                               PswdEnter_GS,Player_load_in,MP_button,PR_select,load_rng,sum_correct,player_load_out,score_display, GlobalScore_display, 
                               score_req_in, valid, PersonalBest, GlobalWinner, clk,rst,score, Logout, LEDArray, half_timer_enable, half_timeout);

Score_Tracking ScoreTracking1(score_req_out, Player_InternalID, isGuest, score, PersonalBest, PersonalBestScore, GlobalWinner, GlobalWinnerID, GlobalWinnerScore, 
                              valid, clk, rst);

TwodigitTimer TwodigitTimer1(timer_reconfig, timer_enable, time_out, Ones7seg, Tens7seg, clk, rst, reconfig_ones_digit, reconfig_tens_digit);


binary_BCD Binary_BCD_PB(PersonalBestScore, Pscore_ones, Pscore_tens, clk, rst);
binary_BCD Binary_BCD_GW(GlobalWinnerScore, Gscore_ones, Gscore_tens, clk, rst);
binary_BCD Binary_BCD_score(score, score_ones, score_tens, clk, rst);

BCD_Binary BCDtoBinary(LRones_out, LRtens_out, Playerinput_binary);

LoadRegister LoadReg_Pones(PlayerInput_switches, LRones_out, clk, rst, player_load_out);
LoadRegister LoadReg_Ptens(ID_PSWD_switches, LRtens_out, clk, rst, player_load_out);

RNG_Project RNG_Gen(clk, rst, load_rng, RNG1, RNG2, RNG3, Key);
 
Verify verification(Key,RNG1,RNG2,RNG3,Playerinput_binary,sum_correct_verif);

LEDblink LEDblink1(clk, rst, LEDArray2, HalfsecTimeout, half_timeout);

HalfsecTimer HalfSecTimer1(half_timer_enable,clk,rst,HalfsecTimeout);

Mymux Mymux_PR1(RNG2, LRtens_out, PR_MUXtens, PR_select);
Mymux Mymux_PR2(RNG3, LRones_out, PR_MUXones, PR_select);
Mymux Mymux_score1(RNG1, score_ones, scoreMUX_ones, score_display);
Mymux Mymux_score2(Key, score_tens, scoreMUX_tens, score_display);
Mymux Mymux_score_req1(PR_MUXones, Pscore_ones, GscoreMUX_1, GlobalScore_display);
Mymux Mymux_score_req2(PR_MUXtens, Pscore_tens, GscoreMUX_2, GlobalScore_display);
Mymux Mymux_score_req3(scoreMUX_ones, GlobalWinnerID, GscoreMUX_3, GlobalScore_display);
Mymux_spcl Mymux_spcl1(scoreMUX_tens, GscoreMUX_4, GlobalScore_display);
Mymux Mymux_score_req5(Ones7seg, Gscore_ones, GscoreMUX_5, GlobalScore_display);
Mymux Mymux_score_req6(Tens7seg, Gscore_tens, GscoreMUX_6, GlobalScore_display);
Mymux_1bit Mymux_IDmatched(IDmatched, LEDArray[0], ZeroLED, Loggedin);
Mymux_10bit Mymux_10bit1(LEDArray1, LEDArray2, LEDs, GlobalScore_display);

ButtonShaper BS_PswdEnter(ID_PswdEnter_GS_button, PswdEnter_GS, clk, rst);
ButtonShaper BS_MPbutton(MultiPurpose_button, MP_button, clk, rst);
ButtonShaper BS_Playerload(PlayerLoad_button, Player_load_in, clk, rst);
ButtonShaper BS_verif(sum_correct_verif, sum_correct, clk, rst);
ButtonShaper BS_scoretrack(score_req_in, score_req_out, clk, rst);


Decoder_7seg decoder1(GscoreMUX_1, decoder0_out);
Decoder_7seg decoder2(GscoreMUX_2, decoder1_out);
Decoder_7seg decoder3(GscoreMUX_3, decoder2_out);
Decoder_7seg decoder4(GscoreMUX_4, decoder3_out);
Decoder_7seg decoder5(GscoreMUX_5, decoder4_out);
Decoder_7seg decoder6(GscoreMUX_6, decoder5_out);


assign LEDArray_output = LEDArray[9:1];
assign LEDArray1 = {LEDArray_output, ZeroLED}; 

endmodule