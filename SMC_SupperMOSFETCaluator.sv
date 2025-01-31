/*
 * @info: --> Auto create header by korofileheader <--
 * @Author: Northern NOOB
 * @Mail: northsnoob@gmail.com
 * @Date: 2025-01-26 14:46
 * @LastEditors: Northern NOOB
 * @LastEditTime: 2025-01-27 16:17
 * @Version: default
 */
// `include "sort_larger.sv"
module SMC_SupperMOSFETCaluator(
	input [2:0] W [0:5],
	input [2:0] V_GS [0:5],
	input [2:0] V_DS [0:5],
	input [1:0] mode,
	output [9:0] out_n
);

wire [9:0] ID_gm_out [0:5];

genvar n; // genvar 是生成用的變數
generate
	for (n = 0; n < 6; n = n + 1) begin : gen_calc_ID_gm
		calc_ID_gm my_calc_ID_gm(
			.V_GS(V_GS[n]),
			.V_DS(V_DS[n]),
			.W(W[n]),
			.mode(mode[0]),
			.out(ID_gm_out[n])
		);
	end
endgenerate
reg [9:0] sort_wire [0:5];
integer i;
always@(*)
	for(i=0;i<=5;i+=1)
		sort_wire[i]=ID_gm_out[i];
// assign sort_wire = ID_gm_out;

wire [9:0] sort_out [0:5];

sort_larger my_sort0(
	.number_in(sort_wire),
	.number_out(sort_out)
);
wire [9:0] total;
wire [9:0] num1,num2,num3;
assign num1 = (mode[1])? sort_out[0]:sort_out[3];
assign num2 = (mode[1])? sort_out[1]:sort_out[4];
assign num3 = (mode[1])? sort_out[2]:sort_out[5];
assign total = (mode[0])? num1*3+num2*4+num3*5:num1+num2+num3;

assign out_n = total;
endmodule

module sort_larger(
	input [9:0] number_in [0:5],
	output wire [9:0] number_out [0:5]
);
wire [9:0] sort_tmp0 [0:5];
//----------------------------- first level -----------------------------//
comparator my_comparator0(
		.a(number_in[0]),
		.b(number_in[1]),
		.bigger(sort_tmp0[0]),
		.smaller(sort_tmp0[1])
		);
comparator my_comparator1(
		.a(number_in[2]),
		.b(number_in[3]),
		.bigger(sort_tmp0[2]),
		.smaller(sort_tmp0[3])
		);
comparator my_comparator2(
		.a(number_in[4]),
		.b(number_in[5]),
		.bigger(sort_tmp0[4]),
		.smaller(sort_tmp0[5])
		);
wire [9:0] sort_tmp1 [0:3];
wire [9:0] sort_tmp1_1 [0:3];

wire swap_f0;
wire swap_f1;
wire swap_f2;
wire swap_f3;
//----------------------------- second level -----------------------------//
comparator my_comparator3(
		.a(sort_tmp0[0]),
		.b(sort_tmp0[2]),
		.bigger(sort_tmp1[0]),
		.smaller(sort_tmp1_1[0]),
		.swap(swap_f0)
		);
        
assign sort_tmp1_1[1] = (swap_f0)? sort_tmp0[3]:sort_tmp0[1];
comparator my_comparator4(
		.a(sort_tmp1_1[0]),
		.b(sort_tmp1_1[1]),
		.bigger(sort_tmp1[1]),
		.smaller(sort_tmp1_1[2])
		);

assign sort_tmp1_1[3] = (swap_f0)?  sort_tmp0[1]:sort_tmp0[3];
comparator my_comparator5(
		.a(sort_tmp1_1[2]),
		.b(sort_tmp1_1[3]),
		.bigger(sort_tmp1[2]),
		.smaller(sort_tmp1[3])
		);

//----------------------------- third level -----------------------------//
wire [9:0] sort_tmp2_2 [0:7];
comparator my_comparator6(
		.a(sort_tmp1[0]),
		.b(sort_tmp0[4]),
		.bigger(number_out[0]),
		.smaller(sort_tmp2_2[0]),
		.swap(swap_f1)
		);

assign sort_tmp2_2[1] = (swap_f1)? sort_tmp0[5]:sort_tmp1[1];
comparator my_comparator7(
		.a(sort_tmp2_2[0]),
		.b(sort_tmp2_2[1]),
		.bigger(number_out[1]),
		.smaller(sort_tmp2_2[2]),
		.swap(swap_f2)
		);

assign sort_tmp2_2[3] = (swap_f1)? sort_tmp1[1]:
						(~swap_f2)? sort_tmp0[5]:sort_tmp1[2];
comparator my_comparator8(
		.a(sort_tmp2_2[2]),
		.b(sort_tmp2_2[3]),
		.bigger(number_out[2]),
		.smaller(sort_tmp2_2[4]),
		.swap(swap_f3)
		);

assign sort_tmp2_2[5] = (swap_f1)? sort_tmp1[2]:
						(~swap_f2)? sort_tmp1[2]:
						(~swap_f3)? sort_tmp0[5]:sort_tmp1[3];
comparator my_comparator9(
		.a(sort_tmp2_2[4]),
		.b(sort_tmp2_2[5]),
		.bigger(number_out[3]),
		.smaller(sort_tmp2_2[6])
		);

// assign sort_tmp2_2[7] = (swap_f1)? sort_tmp1[3]:
// 						(!swap_f2)? sort_tmp1[3]:sort_tmp0[5];
assign sort_tmp2_2[7] = (swap_f1)? sort_tmp1[3]:
						(~swap_f2)? sort_tmp1[3]:
						(~swap_f3)? sort_tmp1[3]:sort_tmp0[5];
comparator my_comparator10(
		.a(sort_tmp2_2[6]),
		.b(sort_tmp2_2[7]),
		.bigger(number_out[4]),
		.smaller(number_out[5])
		);

endmodule




