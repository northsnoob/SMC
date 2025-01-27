/*
 * @info: --> Auto create header by korofileheader <--
 * @Author: Northern NOOB
 * @Mail: northsnoob@gmail.com
 * @Date: 2025-01-26 19:54
 * @LastEditors: Northern NOOB
 * @LastEditTime: 2025-01-27 16:14
 * @Version: default
 */
`timescale 10ns/1ns
module tb_SMC;
reg [2:0] W [0:5];
reg [2:0] V_GS [0:5];
reg [2:0] V_DS [0:5];
reg [1:0] mode;
wire [9:0] out_n;
SMC_SupperMOSFETCaluator uut(
    .W,
	.V_GS,
	.V_DS,
	.mode,
	.out_n
);
integer i,i2;
reg [2:0] j,k,l;
initial begin
    #40;
    mode = 2'b00;
    V_GS[0] = 3'b011; V_GS[1] = 3'b011; V_GS[2] = 3'b010; V_GS[3] = 3'b011; V_GS[4] = 3'b011;  V_GS[5] = 3'b011;
    V_DS[0] = 3'b100; V_DS[1] = 3'b100; V_DS[2] = 3'b100; V_DS[3] = 3'b100; V_DS[4] = 3'b100;  V_DS[5] = 3'b100;
    W[0] = 3'b010; W[1] = 3'b010; W[2] = 3'b010; W[3] = 3'b010; W[4] = 3'b010; W[5] = 3'b010;
    #100;
    V_GS[0] = 3'b011; V_GS[1] = 3'b110; V_GS[2] = 3'b110; V_GS[3] = 3'b011; V_GS[4] = 3'b011;  V_GS[5] = 3'b111;
    V_DS[0] = 3'b111; V_DS[1] = 3'b110; V_DS[2] = 3'b111; V_DS[3] = 3'b101; V_DS[4] = 3'b101;  V_DS[5] = 3'b111;
    W[0] = 3'b010; W[1] = 3'b110; W[2] = 3'b001; W[3] = 3'b010; W[4] = 3'b001; W[5] = 3'b111;
    mode = 2'b11;
    // force uut.sort_wire[0] = 10'd25;
    // force uut.sort_wire[1] = 10'd33;
    // force uut.sort_wire[2] = 10'd27;
    // force uut.sort_wire[3] = 10'd5;
    // force uut.sort_wire[4] = 10'd6;
    // force uut.sort_wire[5] = 10'd0;
    #100;
    mode = 2'b00;
    // force uut.sort_wire[0] = 10'd25;
    // force uut.sort_wire[1] = 10'd33;
    // force uut.sort_wire[2] = 10'd27;
    // force uut.sort_wire[3] = 10'd5;
    // force uut.sort_wire[4] = 10'd6;
    // force uut.sort_wire[5] = 10'd0;
    j=0;k=0;l=0;
    for(i2=0;i2<=4;i2+=1)begin
        for(i=0;i<6;i+=1)begin
            V_GS[i]=j;
            V_DS[i]=k;
            W[i]=l;
            j+=1;
            k+=1;
            l+=2;
        end
        #100;
        mode+=1;
    end

    $finish;
end
endmodule