module bus_8_adapter(in1, in2, in3, in4, in5, in6, in7, in8, clk, out);

	input in1, in2, in3, in4, in5, in6, in7, in8, clk;
	output [7:0] out;
	reg [7:0] out;
	
	always @(posedge clk) begin
		out[0] = in1;
		out[1] = in2;
		out[2] = in3;
		out[3] = in4;
		out[4] = in5;
		out[5] = in6;
		out[6] = in7;
		out[7] = in8;
	end
endmodule
