module demux_1_to_3_bus_8(in, sel, clk, out1, out2, out3);

	input [7:0] in;
	input [1:0] sel;
	input clk;
	
	output [7:0] out1;
	output [7:0] out2;
	output [7:0] out3;
	
	reg [7:0] out1;
	reg [7:0] out2;
	reg [7:0] out3;
	
	always @(posedge clk) begin
		case (sel)
			2'b00: begin
				out1 = in;
			end
			
			2'b01: begin
				out2 = in;
			end
				
			2'b10: begin
				out3 = in;
			end
		endcase
	end
endmodule
