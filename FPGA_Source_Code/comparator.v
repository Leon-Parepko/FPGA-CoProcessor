module COMPORATOR

#(parameter plus = 	8'b00101011,
parameter minus = 	8'b00101101,
parameter multiply = 8'b00101010,
parameter divide = 	8'b00101111,

parameter mat_plus = 	8'b00000000,
parameter mat_minus = 	8'b00000000,
parameter mat_cross = 	8'b00000000,
parameter mat_dot = 		8'b00000000,
parameter mat_det = 		8'b00000000,
parameter mat_trans = 	8'b00000000
)	
(
	
	input i_clk,
	input i_ready,
	input [7:0] op,
	input reset,
	
	
	output reg o_ready,
	output reg o_ready_mat,
	output reg [7:0] op_code
);	
	
	always @(posedge i_clk) begin
		o_ready = 0;
		o_ready_mat = 0;
		
		if (reset == 1) begin
			op_code = 0;
			o_ready = 0;
			o_ready_mat = 0;
		end
		
		if (i_ready == 1) begin
			case (op)
			
				plus: begin
					op_code = 8'b000000001;
					o_ready = 1;
				end
				
				minus: begin
					op_code = 8'b000000010;
					o_ready = 1;
				end
				
				multiply: begin
					op_code = 8'b000000011;
					o_ready = 1;
				end
				
				divide: begin
					op_code = 8'b000000100;
					o_ready = 1;
				end
				
				
				
				
				mat_plus: begin
					op_code = 8'b000000000;
					o_ready_mat = 1;
				end
				
				mat_minus: begin
					op_code = 8'b000000000;
					o_ready_mat = 1;
				end
				
				mat_cross: begin
					op_code = 8'b000000000;
					o_ready_mat = 1;
				end
				
				mat_dot: begin
					op_code = 8'b000000000;
					o_ready_mat = 1;
				end
				
				mat_det: begin
					op_code = 8'b000000000;
					o_ready_mat = 1;
				end
				
				mat_trans: begin
					op_code = 8'b000000000;
					o_ready_mat = 1;
				end
	
				
			endcase;
		end
	end
endmodule
