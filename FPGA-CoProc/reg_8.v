// 8-bit register
module reg_8(reset, clk, data, out);

	input reset;
	input clk;
	input [7:0] data;

	output [7:0] out;
	reg [7:0] out;

	always @(posedge clk) begin
		if (reset)
			out = 0;
		else
			out = data;
	end
endmodule
