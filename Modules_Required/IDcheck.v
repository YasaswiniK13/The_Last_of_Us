//ECE6370 Advanced Digital Design
//Team: UNAGI2.0
// IDcheck
// This module will authenticate the ID.
module IDcheck(PlayerID, ID_enter, IDmatched, Internal_PlayerID, Logout, ID_ROMaddr, ID_ROMdata, isGuest, clk, rst);

input [3:0]PlayerID;
input clk, rst;
input Logout, ID_enter;
input [15:0]ID_ROMdata;
output IDmatched, isGuest;
output [2:0]Internal_PlayerID;
output [4:0]ID_ROMaddr;

reg [4:0]ID_ROMaddr;
reg [2:0]Internal_PlayerID;
reg IDmatched;
reg [3:0]State;
reg [15:0]PlayerID_reg;
reg [15:0]IDROMdata_reg;
reg isGuest;


parameter DIGIT1 = 0, DIGIT2 = 1, DIGIT3 = 2, DIGIT4 = 3, FETCH_ROM = 4, ROMCYCLE1 = 5, ROMCYCLE2 = 6, CATCH_ROM = 7, COMPARE = 8, CHECK_STATUS = 9, CHECK_GUEST = 10;


always@(posedge clk) begin

if(rst == 1'b0) begin
ID_ROMaddr <= 0;
Internal_PlayerID <= 0;
IDmatched <= 1'b0;
State <= DIGIT1;
isGuest <= 1'b0;

end

else begin

case(State)

	DIGIT1: begin
	
	IDmatched <= 1'b0;
	isGuest <= 1'b0;
	if(ID_enter == 1'b1) begin
	PlayerID_reg[15:12] <= PlayerID;
        State <= DIGIT2;
	end

	else begin
	State <= DIGIT1;
	end

	end

	DIGIT2: begin
	
	if(ID_enter == 1'b1) begin
	PlayerID_reg[11:8] <= PlayerID;
        State <= DIGIT3;
	end

	else begin
	State <= DIGIT2;
	end

	end

	DIGIT3: begin
	
	if(ID_enter == 1'b1) begin
	PlayerID_reg[7:4] <= PlayerID;
        State <= DIGIT4;
	end

	else begin
	State <= DIGIT3;
	end

	end

	DIGIT4: begin
	
	if(ID_enter == 1'b1) begin
	PlayerID_reg[3:0] <= PlayerID;
        State <= FETCH_ROM;
	end

	else begin
	State <= DIGIT4;
	end

	end

	FETCH_ROM: begin

	ID_ROMaddr <= {2'b00, Internal_PlayerID};
	State <= ROMCYCLE1;
	end

	ROMCYCLE1: begin

	State <= ROMCYCLE2;
	end

	ROMCYCLE2: begin

	State <= CATCH_ROM;
	end
	
	CATCH_ROM: begin

	IDROMdata_reg <= ID_ROMdata;
	State <= COMPARE;
	end

	COMPARE: begin
	
	if(PlayerID_reg == IDROMdata_reg) begin
	State <= CHECK_GUEST;
	end

	else begin
	State <= CHECK_STATUS;
	end

	end

	CHECK_STATUS: begin

	if(IDROMdata_reg == 16'hFFFF) begin
	State <= DIGIT1;
	end

	else begin
	
	Internal_PlayerID <= Internal_PlayerID + 1;
	State <= FETCH_ROM;
	end

	end


	CHECK_GUEST:begin
	
	
	if(IDROMdata_reg == 16'h8888) begin
	isGuest <= 1'b1;
	IDmatched <= 1'b1;
	end

	else begin
	isGuest <= 1'b0;
	IDmatched <= 1'b1;
	end
	
	if(Logout == 1'b1) begin
	State <= DIGIT1;
	Internal_PlayerID <= 0;
	IDmatched <= 1'b0;
	end

	end

	default: begin

	IDmatched <= 1'b0;
	Internal_PlayerID <= 0;
	isGuest <= 1'b0;
	State <= DIGIT1;
	end
	
	endcase

    end
  end


endmodule