//ECE6370 Advanced Digital Design
//Team: UNAGI2.0
// GameController
// This is the Main Moudle for GameController fetches data from RAM.
module GameController(timer_reconfig,ones_digit, tens_digit, timer_enable,time_out,logged_in,player_id, isGuest, game_start_button,player_load_in,MP_button,
                      PR_select,load_rng,sum_correct,player_load_out,score_display, GlobalScore_display, score_req, valid, PersonalBest_in, GlobalWinner_in,
                      clk,rst,score, Logout, LED, half_timer_enable, half_timeout);
input clk,rst,time_out,logged_in;
  input [2:0]player_id;

  input game_start_button,MP_button,player_load_in;
  input sum_correct, valid, PersonalBest_in, GlobalWinner_in, isGuest;
 input half_timeout;
 
  output half_timer_enable;
  output timer_enable,timer_reconfig;
  output player_load_out;
  output score_display, score_req, GlobalScore_display;
  output PR_select;
  output load_rng, Logout;
  output [6:0]score;
  output [3:0] ones_digit,tens_digit;
  output [9:0] LED;

 wire [13:0]RAMdata_in;

 wire write_enable;
 wire [4:0]RAMaddr;
 wire [13:0]RAMdata_out;

game_controller gamecontroller(timer_reconfig,ones_digit, tens_digit, timer_enable,time_out,logged_in,player_id, isGuest, game_start_button,player_load_in, 
                               MP_button,PR_select,load_rng,sum_correct,player_load_out,score_display, GlobalScore_display, score_req, valid, PersonalBest_in,
                               GlobalWinner_in, clk,rst,score, Logout, LED, RAMdata_in, write_enable, RAMaddr, RAMdata_out, half_timer_enable, half_timeout);
  
 RAM_Logout Logout_RAM(RAMaddr,clk,RAMdata_out,write_enable,RAMdata_in);


endmodule  
