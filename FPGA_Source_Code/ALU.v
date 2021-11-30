
module ALU(op_code, num_1, num_2, clk, i_ready, reset, result, o_ready);

	input [7:0] op_code;
	input [7:0] num_1;
	input [7:0] num_2;
	input clk;
	input i_ready;
	input reset;
	
	output [7:0] result;
	output o_ready;
	
	
	reg [7:0] result = 0;
	reg o_ready = 0;
	 
	
	always @(posedge clk) begin
	
	
		o_ready <= 1'b0;
		
		
		
		if (reset == 1)
		begin
			result = 0;
			o_ready <= 0;
		end
		
		
		
		
	
	   if (i_ready == 1)
      begin
			
		case (op_code)
			8'b00000001: begin
				result = num_1 + num_2;
				o_ready <= 1'b1;
			end
			
			8'b00000010: begin
				result = num_1 - num_2;
				o_ready <= 1'b1;
			end	
		endcase
			
      end
		
		
	end
	
endmodule
