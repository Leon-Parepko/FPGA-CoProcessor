
//bitness = your_bitness - 1

module ALU
#(parameter bitness = 8,
parameter add = 8'b00000001,
parameter sub = 8'b00000010,
parameter mul = 8'b00000011,
parameter div = 8'b00000100
)
(
	input i_clk,
	input i_ready,
	input [bitness - 1:0] i_num_1,
	input [bitness - 1:0] i_num_2,
	input [7:0] op_code,
	input reset,

	output reg o_ready,
	output reg [bitness - 1:0] result_Hi,
	output reg [bitness - 1:0] result_Lo
	
);



	
	always @(posedge i_clk) begin
		o_ready = 0;
		
		if (i_ready == 1) begin
			
			result_Hi = 0;
			result_Lo = 0;
			
		
			case (op_code)
				add: 
				begin
					result_Hi = i_num_1 + i_num_2;
					o_ready = 1;
				end
				
				sub: 
				begin
					result_Hi = i_num_1 - i_num_2;
					o_ready = 1;
				end
				
				mul: 
				begin
					result_Hi = i_num_1 * i_num_2;
					o_ready = 1;
				end
				
				div: 
				begin
					result_Hi = i_num_1 / i_num_2;
					result_Lo = i_num_1 % i_num_2;
					o_ready = 1;
				end
				
				
			endcase;
		end
	end
endmodule
