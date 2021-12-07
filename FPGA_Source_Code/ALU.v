
module ALU #
(
	parameter BITNESS = 8,
	
	parameter ADD = 8'b00000001,
	parameter SUB = 8'b00000010,
	parameter MUL = 8'b00000011,
	parameter DIV = 8'b00000100
)
(
	input i_clk,
	input i_ready,
	input [BITNESS-1:0] i_num_1,
	input [BITNESS-1:0] i_num_2,
	input [7:0] op_code,
	input reset,

	output reg o_ready,
	
	output wire [BITNESS-1:0] result_Hi,
	output wire [BITNESS-1:0] result_Lo
);

	reg [BITNESS*2-1:0] Hi_reg = 0;
	reg [BITNESS*2-1:0] Lo_reg = 0;

	assign result_Hi = Hi_reg[BITNESS - 1:0];
	assign result_Lo = Lo_reg[BITNESS - 1:0];
	
	always @(posedge i_clk) begin
		o_ready <= 0;
		
		if (i_ready == 1) begin
			Hi_reg <= 0;
			Lo_reg <= 0;
			
			case (op_code)
				ADD: begin
					Hi_reg <= i_num_1 + i_num_2;
					o_ready <= 1;
				end
				
				SUB: begin
					Hi_reg <= i_num_1 - i_num_2;
					o_ready <= 1;
				end
				
				MUL: begin
					Hi_reg <= i_num_1 * i_num_2;
					o_ready <= 1;
				end
				
				DIV: begin
					Hi_reg <= i_num_1 / i_num_2;
					Lo_reg <= i_num_1 % i_num_2;
					o_ready <= 1;
				end
			endcase;
		end
	end
endmodule
