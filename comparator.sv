/*
 * @info: --> Auto create header by korofileheader <--
 * @Author: Northern NOOB
 * @Mail: northsnoob@gmail.com
 * @Date: 2025-01-27 15:47
 * @LastEditors: Northern NOOB
 * @LastEditTime: 2025-01-27 15:55
 * @Version: default
 */
module comparator(
	input [9:0] a,b,
	output reg [9:0] bigger,smaller,
	output reg swap
);
always@*begin
	if (a>b)begin
		bigger=a;
		smaller=b;
		swap=1'b0;
	end
	else begin
		bigger=b;
		smaller=a;
		swap=1'b1;
	end
end
endmodule