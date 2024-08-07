//ECE6370 Advanced Digital Design
//Team: UNAGI2.0
//game_controller
// This module helps to control the game inputs and outputs 
module game_controller(timer_reconfig,ones_digit, tens_digit, timer_enable,time_out,logged_in,player_id, isGuest, game_start_button,player_load_in,MP_button,
                       PR_select,load_rng,sum_correct,player_load_out,score_display, GlobalScore_display, score_req, valid, PersonalBest_in, GlobalWinner_in, 
                       clk,rst,score, Logout, LED, RAMdata_in, write_enable, RAMaddr, RAMdata_out, half_timer_enable, half_timeout);
  input clk,rst,time_out,logged_in;
  input [2:0]player_id;

  input game_start_button,MP_button,player_load_in;
  input sum_correct, valid, PersonalBest_in, GlobalWinner_in, isGuest;
  input [13:0]RAMdata_in;

  input half_timeout;
  output half_timer_enable;
  
  
  output write_enable;
  output [4:0]RAMaddr;
  output [13:0]RAMdata_out;
  output timer_enable,timer_reconfig;
  output player_load_out;
  output score_display, score_req, GlobalScore_display;
  output PR_select;
  output load_rng, Logout;
  output [6:0]score;
  output [3:0] ones_digit,tens_digit;
  output [9:0] LED;
  reg load_rng, Logout;
  reg PR_select;
  reg score_display, score_req, GlobalScore_display;
  reg player_load_out;
  reg timer_enable,timer_reconfig;
  reg [3:0] ones_digit,tens_digit;
  reg [2:0] level;
  reg [6:0] score;

 reg write_enable;
 reg [4:0]RAMaddr;
 reg [13:0]RAMdata_out;
 

  reg [3:0]Logout_reg;
  reg [3:0]LED_reg;
  reg [9:0] LED;
  reg [4:0] state;
  reg [2:0]waitcount;
  reg [3:0]scorewait_count;
  reg half_timer_enable;
  reg RAM_initialized;
  reg GameoverFlag;

 parameter RAM_INIT = 1, Level_set=2,reconfig=3,WAIT_FOR_GAMESTART=4,gameplay=5,nextquest=6,win=7,gameover=8, WAIT= 9, RAMCYCLE1= 10, RAMCYCLE2 =11, 
                       LOGOUT_RESTORE=12, LED_RESET=13, score_wait=14, LEDblink=15;

 always@(posedge clk)
     begin
       if(rst == 1'b0)
          begin 
            load_rng <= 1'b0;  
            timer_enable <= 1'b0;
            timer_reconfig <= 1'b0;
	    state <= RAM_INIT;
            score <= 51;
	    level <= 3'b001;
	    GlobalScore_display <= 1'b0;
	    score_display <= 1'b0;
	    score_req <= 1'b1;
	    waitcount <= 3'b000;
	    Logout <= 1'b0;
	    Logout_reg <= 4'b0000;
	    RAM_initialized <= 1'b0;
	    RAMaddr <= 0;
		 LED <= 10'b0000000000;
		 scorewait_count <= 0;
		 half_timer_enable <= 1'b0;
		 GameoverFlag <= 1'b0;
          end

     else begin

       case(state)
	
	RAM_INIT: begin

		if(RAMaddr == 31) begin
		state <= Level_set;
		RAM_initialized <= 1'b1;
		write_enable <= 1'b1;
		RAMdata_out <= 0;
		end

		else begin
		RAMaddr <= RAMaddr +1;
		RAMdata_out <= 0;
		write_enable <= 1'b1;
		state <= RAM_INIT;
   		end

	   end	    


	Level_set: begin
		 
		 write_enable <= 1'b0;
		 waitcount <= 3'b000;
		 LED <= 10'b0000000000;
                 if(logged_in == 1'b1)begin
                  
		 if(Logout_reg[player_id] == 1'b1) begin
			RAMaddr <= {2'b00, player_id};
			state <= RAMCYCLE1;
			Logout_reg[player_id] <= 1'b0;
		  end

		 else begin
                   case(level)
                   3'b001: begin
                              ones_digit <= 4'd0;
                              tens_digit <= 4'd4;
			                     LED_reg <= 4;
                              LED <= 10'b0000001111;
                              state <= reconfig;
				                  score <= 51;
                            end
                   3'b010: begin
                              ones_digit <= 4'd0;
                              tens_digit <= 4'd3;
                              LED <= 10'b0000111111;
			                     LED_reg <= 6;
                              state <= reconfig;
			                     score <= score + 10;
                            end
                   3'b011: begin
                              ones_digit <= 4'd5;
                              tens_digit <= 4'd1;
                              LED <= 10'b0011111111;
			                     LED_reg <= 8;
                              state <= reconfig;
			                     score <= score + 20;
                            end
                     default : begin 
                                ones_digit <= 4'd0;
                                 tens_digit <= 4'd4;
                                  LED <= 10'b0000001111;
				                      LED_reg <= 4;
                                  level <= 3'b001;
                                  score <= 51;
				                     state <= Level_set;
                               end
                          endcase
                     end
		   end 
                  end
           
	RAMCYCLE1: begin
         
		state <= RAMCYCLE2;
		end
  
	RAMCYCLE2: begin
         
		state <= LOGOUT_RESTORE;
		end
  

	LOGOUT_RESTORE: begin

		level <= RAMdata_in[13:11];
		LED_reg <= RAMdata_in[10:7];
		score <= RAMdata_in[6:0];
		state <= LED_RESET;	
	     end
		
	LED_RESET: begin
		
		 case(level)
                   3'b001: begin
                              ones_digit <= 4'd0;
                              tens_digit <= 4'd4;
                            end
                   3'b010: begin
                              ones_digit <= 4'd0;
                              tens_digit <= 4'd3;
                            end
                   3'b011: begin
                              ones_digit <= 4'd5;
                              tens_digit <= 4'd1;
                            end
                   default : begin 
                                ones_digit <= 4'd0;
                                 tens_digit <= 4'd4;
                                  LED <= 10'b0000001111;
				  LED_reg <= 4;
                                  level <= 3'b001;
                                  state <= reconfig;
                               end
                    endcase

                   case(LED_reg)
                          4'd0 :begin  LED <= 10'b0000000000;end       
                          4'd1 :begin  LED <= 10'b0000000001; end
                          4'd2 :begin LED <= 10'b0000000011; end
                          4'd3 :begin LED <= 10'b0000000111; end
                          4'd4 :begin LED <= 10'b0000001111; end
                          4'd5 :begin  LED <= 10'b0000011111; end
                          4'd6 :begin LED <= 10'b0000111111; end
                          4'd7 :begin LED <= 10'b0001111111; end
                          4'd8 :begin  LED <= 10'b0011111111; end
                          4'd9 :begin LED <= 10'b0111111111; end
                          4'd10 :begin LED <= 10'b1111111111; end
			  default: begin state <= Level_set; end
                     endcase

		     state <= reconfig;
		    end 

	reconfig: begin

                         timer_reconfig <= 1'b1;
                         player_load_out <= 1'b0;
			 load_rng <= 1'b0;
                         state <= WAIT_FOR_GAMESTART;
			 PR_select <= 1'b0;
			 GlobalScore_display <= 1'b0;
			 score_display  <= 1'b0;
			
			  Logout <= 1'b0;
			  GameoverFlag <= 1'b0;
                       end

	WAIT_FOR_GAMESTART: begin

                       timer_reconfig <=1'b0;
		       
			
		       if(player_load_in == 1'b1) begin
					if(isGuest == 1'b1) begin
					state <= WAIT;
		       		Logout <= 1'b1;
						waitcount <= 0;
						end
						
					else begin
					
				case(player_id)
					3'b000: begin Logout_reg[0] <= 1'b1; state <= WAIT;end
					3'b001: begin Logout_reg[1] <= 1'b1; state <= WAIT;end
					3'b010: begin Logout_reg[2] <= 1'b1; state <= WAIT;end
					3'b011: begin Logout_reg[3] <= 1'b1; state <= WAIT;end
					default: begin Logout_reg <= 4'b0000; state <= WAIT; end
				endcase
				
				state <= WAIT;
		       		Logout <= 1'b1;
				write_enable <= 1'b1;
				RAMdata_out <= {level, LED_reg, score};
				RAMaddr <= {2'b00, player_id}; 
		        	waitcount <= 0;
					GlobalScore_display <= 1'b0;
		        
				  end  
		        end



			else if(MP_button == 1'b1)
                            begin 
				if(GlobalScore_display == 1'b0) begin
                                GlobalScore_display <= 1'b1;
				score_req <= 1'b0;
				state <= score_wait;
				scorewait_count <= 0;
                                end
				else begin
                                GlobalScore_display <= 1'b0;
			        score_req <= 1'b1;
                                end
			end
                         

                        
                        else if(game_start_button == 1'b1)
                              begin
                               timer_enable <= 1'b1;
                               load_rng <= 1'b1;
                               state <= gameplay;
										 GlobalScore_display <= 1'b0;
                              end

                        else begin
				state <= WAIT_FOR_GAMESTART;
			end
			end

	gameplay: begin

			  load_rng <= 1'b0;
                          player_load_out <= player_load_in;

                          if(MP_button == 1'b1)
                            begin 
				if(PR_select == 1'b0) begin
                                PR_select <= 1'b1;
				end
			    else begin
                            PR_select <= 1'b0;
                            end
                            end

                          if(sum_correct == 1'b1)
			                    begin
                               LED_reg <= LED_reg - 1;
                               score <= score + 1;
				                   state <= nextquest;
                               end

                          else if(time_out == 1'b1)
                            begin
                                LED_reg <= LED_reg + 1;
                                state <= nextquest;
                                score <= score - 1;
                             end

                           else begin
                                 state <= gameplay;
                            end
                      end

	nextquest: begin 
                       timer_enable <= 1'b0; 
                        case(LED_reg)
                          4'd0 :begin  LED <= 10'b0000000000;
                                   state <= win;
                                end
                                
                          4'd1 :begin  LED <= 10'b0000000001;
                                   state <= reconfig;
                                end
                          4'd2 :begin LED <= 10'b0000000011;
                                   state <= reconfig;
                                end
                          4'd3 :begin LED <= 10'b0000000111;
				                       state <= reconfig;
                                end
                          4'd4 :begin LED <= 10'b0000001111;
                                   state <= reconfig;
                                end
                          4'd5 :begin  LED <= 10'b0000011111;
                                   state <= reconfig;
                                end
                          4'd6 :begin LED <= 10'b0000111111;
                                   state <= reconfig;
                                end
                          4'd7 :begin LED <= 10'b0001111111;
                                   state <= reconfig;
                                end
                          4'd8 :begin  LED <= 10'b0011111111;
                                   state <= reconfig;
                                end
                          4'd9 :begin LED <= 10'b0111111111;
                                   state <= reconfig;
                                end
                          4'd10 :begin LED <= 10'b1111111111;
                                   state <= gameover;  
                                end
			  default: begin
				   state <= Level_set;
				 end
                           endcase
                      end
	
	win : begin
                 level <= level + 1;
                   if(level == 3'b100) begin
                      state <= gameover;
		   end
                   else begin
                     
                      state <= Level_set;
			
		   end
                 end
	
	gameover: begin

                  score_display  <= 1'b1;
						
				if(player_load_in == 1'b1) begin
					if(isGuest == 1'b1) begin
					state <= WAIT;
		       		Logout <= 1'b1;
						waitcount <= 0;
						end
						
					else begin
					
				case(player_id)
					3'b000: begin Logout_reg[0] <= 1'b1; state <= WAIT;end
					3'b001: begin Logout_reg[1] <= 1'b1; state <= WAIT;end
					3'b010: begin Logout_reg[2] <= 1'b1; state <= WAIT;end
					3'b011: begin Logout_reg[3] <= 1'b1; state <= WAIT;end
					default: begin Logout_reg <= 4'b0000; state <= WAIT; end
				endcase
				
				state <= WAIT;
		       		Logout <= 1'b1;
				write_enable <= 1'b1;
				RAMdata_out <= {level, LED_reg, score};
				RAMaddr <= {2'b00, player_id}; 
		        	waitcount <= 0;
					GlobalScore_display <= 1'b0;
		        
				  end  
		        end

		 
			else if(MP_button == 1'b1)
                            begin 
				if(GlobalScore_display == 1'b0) begin
                                GlobalScore_display <= 1'b1;
				score_req <= 1'b0;
				state <= score_wait;
				scorewait_count <= 0;
				GameoverFlag <= 1'b1;
                               end
				 else begin
                            GlobalScore_display <= 1'b0;
			    score_req <= 1'b1;
				 GameoverFlag <= 1'b0;
                            end
			end

         else if(game_start_button == 1'b1) begin
			level <= 0;
 			state <= Level_set;
			GameoverFlag <= 1'b0;
			GlobalScore_display <= 1'b0;
			end
                    else begin
                       state <= gameover;
                    end

		   end

	WAIT: begin
		
		Logout <= 1'b0;
		write_enable <= 1'b0;
	        waitcount <= waitcount + 1;
		if(waitcount == 7) begin
		state <= Level_set;
		Logout <= 1'b0;
		end

		else begin
		state <= WAIT;
		end

	        end
			  
   score_wait: begin
	
		scorewait_count <= scorewait_count +1;
		if(scorewait_count == 9) begin
			if(valid == 1'b1) begin
				if( PersonalBest_in == 1'b1 || GlobalWinner_in == 1'b1) begin
					state <= LEDblink;
					half_timer_enable <= 1'b1;
					end
				else begin
					if(GameoverFlag == 1'b1) begin
					state <= gameover;
					end
					else begin
					state <= WAIT_FOR_GAMESTART;
					scorewait_count <= 0;
					end
					
				end
			end
		   else begin
			scorewait_count <= 0;
			if(GameoverFlag == 1'b1) begin
					state <= gameover;
					end
					else begin
					state <= WAIT_FOR_GAMESTART;
					scorewait_count <= 0;
					end
			
			
			end
		end
		
		else begin
		state <= score_wait;
		end
		
		end
		
		
		
		
	LEDblink: begin
		
		if(half_timeout == 1'b1) begin
		half_timer_enable <= 1'b0;
		if(GameoverFlag == 1'b1) begin
					state <= gameover;
					end
					else begin
					state <= WAIT_FOR_GAMESTART;
					scorewait_count <= 0;
					end
		
		end

		else begin
		state <= LEDblink;
		end
		
		end
		
		
		

	 default: begin

	   	 load_rng <= 1'b0;  
            	 timer_enable <= 1'b0;
            	 timer_reconfig <= 1'b0;
	   	 state <= RAM_INIT;
           	 score <= 51;
	   	 waitcount <= 3'b000;
	  	 end

            endcase
         end
      end
endmodule
