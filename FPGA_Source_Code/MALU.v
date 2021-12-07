
module MALU

#(parameter bitness = 8,
parameter add = 	8'b00000000,
parameter sub = 	8'b00000000,
parameter dot = 	8'b00000000,
parameter cross = 8'b00000000,
parameter muli = 8'b00000000,
parameter det = 	8'b00000000,
parameter trans = 8'b00000000
)
(
	input i_clk,
	input i_ready,
	input [bitness - 1:0] size_1,
	input [bitness - 1:0] size_2,
	input [bitness - 1:0] i_mat_1,
	input [bitness - 1:0] i_mat_2,
	input [7:0] op_code,
	input reset,

	output reg o_ready,
	output reg [bitness - 1:0] result_Hi,
	output reg [bitness - 1:0] result_Lo
	
);


//reg [800:0] matrix				//input matrix (max 5X5 * 32 bit)



	
	always @(posedge i_clk) begin
	
		o_ready = 0;
		
		if (i_ready == 1) begin
			
			result_Hi = 0;
			result_Lo = 0;
			
		
			case (op_code)
				add: begin
				//	some math
					o_ready = 1;
				end
				
				sub: begin
				//	some math
					o_ready = 1;
				end
				
				dot: begin
				//	some math
					o_ready = 1;
				end
				
				cross: begin
				//	some math
					o_ready = 1;
				end
				
				muli: begin
				//	some math
					o_ready = 1;
				end
				
				det: begin
				//	some math
					o_ready = 1;
				end
				
				trans: begin
				//	some math
					o_ready = 1;
				end
			endcase;
			
		end
		
		
	end
endmodule
