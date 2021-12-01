module adapter_24_3x8(in, out_1, out_2, out_3);

	input [23:0] in;
	
	output [7:0] out_1;
	output [7:0] out_2;
	output [7:0] out_3;
	
	wire [7:0] out_1;
	wire [7:0] out_2;
	wire [7:0] out_3;
	
	assign out_1 = in[7:0];
	assign out_2 = in[15:8];
	assign out_3 = in[23:16];

endmodule
