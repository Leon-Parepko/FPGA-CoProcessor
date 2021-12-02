module COMPORATOR

#(parameter plus = 	8'b00101011,
parameter minus = 	8'b00000000,
parameter multiply = 8'b00000000,
parameter divide = 	8'b00000000
)

(op, clk, i_ready, reset, op_code, o_ready);
	
	input [7:0] op;
	input i_ready;
	input clk;
	input reset;
	
	output [7:0] op_code;
	output o_ready;
	
	reg [7:0] op_code;
	reg o_ready;
	
	always @(posedge clk) begin
		o_ready = 0;
		
		if (reset == 1) begin
			op_code = 0;
			o_ready = 0;
		end
		
		if (i_ready == 1) begin
			case (op)
			
				plus: begin
					op_code = 8'b000000001;
					o_ready = 1'b1;
				end
				
				minus: begin
					op_code = 8'b000000010;
					o_ready = 1'b1;
				end
				
				multiply: begin
					op_code = 8'b000000011;
					o_ready = 1'b1;
				end
				
				divide: begin
					op_code = 8'b000000100;
					o_ready = 1'b1;
				end
				
			endcase;
		end
	end
endmodule
