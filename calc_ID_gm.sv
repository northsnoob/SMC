/*
 * @info: --> Auto create header by korofileheader <--
 * @Author: Northern NOOB
 * @Mail: northsnoob@gmail.com
 * @Date: 2025-01-27 15:48
 * @LastEditors: Northern NOOB
 * @LastEditTime: 2025-01-27 16:00
 * @Version: default
 */
module calc_ID_gm(
	input [2:0] V_GS,V_DS,W,
	input mode,
	output [9:0] out

);
reg [1:0] m;
always@*begin
	if ((V_GS - 1) > V_DS)
		m[1] = 1'b0;
	else
		m[1] = 1'b1;
	m[0] = mode;
end
wire [2:0] V_GS_m_1;
wire [2:0] V_GS_OR_DS_0;
wire [2:0] V_GS_OR_DS_1;
assign V_GS_m_1 = V_GS-1;
assign V_GS_OR_DS_0 = (m==2'b00)?V_DS:V_GS_m_1;
assign V_GS_OR_DS_1 = (m[0]==1'b0)?3'b001:
					  (m[1]==1'b1)? V_GS_m_1:V_DS;

wire [5:0] V_GS_OR_DS_2;
assign V_GS_OR_DS_2 = V_GS_OR_DS_0 * V_GS_OR_DS_1;
wire [6:0] V_GS_OR_DS_3;
assign V_GS_OR_DS_3 = (m==2'b01)? {V_GS_OR_DS_2[5:0],1'b0}:V_GS_OR_DS_2;
wire [6:0] V_GS_OR_DS;
assign V_GS_OR_DS = (m==2'b01)? V_GS_OR_DS_3-(V_DS*V_DS):V_GS_OR_DS_3;
wire [9:0] out_without_div;
assign out_without_div = W*V_GS_OR_DS;
wire [10:0] out_without_div_double;
assign out_without_div_double = (m[0]==1'b0)?{out_without_div[9:0],1'b0}:{1'b0,out_without_div};
assign out = out_without_div_double/3;
endmodule
