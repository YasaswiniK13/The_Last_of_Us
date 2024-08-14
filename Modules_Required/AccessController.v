module AccessController(PlayerID_PSWD, ID_PSWD_Enter, Logout, Loggedin, Player_InternalID, isGuest, clk, rst, IDmatched);

input [3:0]PlayerID_PSWD;
input ID_PSWD_Enter, clk, rst, Logout;
output [2:0]Player_InternalID;
output Loggedin, isGuest;
output IDmatched;


wire [2:0]Internal_PlayerID_IDtoPSWD;
wire Logout_PSWDtoID;
wire [4:0]ID_ROMaddr, PSWD_ROMaddr;
wire [15:0]ID_ROMdata;
wire [23:0]PSWD_ROMdata;
wire isGuest_IDtoPSWD;
wire IDmatched_toPSWD;


IDcheck IDcheck1(PlayerID_PSWD, ID_PSWD_Enter, IDmatched_toPSWD, Internal_PlayerID_IDtoPSWD, Logout_PSWDtoID, ID_ROMaddr, ID_ROMdata, isGuest_IDtoPSWD, clk, rst);
Pswdcheck Pswdcheck1(PlayerID_PSWD, ID_PSWD_Enter, Internal_PlayerID_IDtoPSWD, IDmatched_toPSWD, isGuest_IDtoPSWD , Logout, Player_InternalID, Logout_PSWDtoID, 
                     PSWD_ROMaddr, PSWD_ROMdata, Loggedin, isGuest, clk, rst);

ROM_ID ROM_ID_1(ID_ROMaddr,clk,ID_ROMdata);
ROM_PSWD ROM_PSWD_1(PSWD_ROMaddr,clk,PSWD_ROMdata);

assign IDmatched = IDmatched_toPSWD;


endmodule
