module comparator(op, clk, i_ready, op_code, o_ready, reset, );

	input [7:0] op;
	input i_ready;
	input clk;
	input reset;
	
	output [7:0] op_code;
	output o_ready;
	
	reg [7:0] op_code;
	reg o_ready;
	
	parameter plus = 8'h2B;
	
	always @(posedge clk) 
	begin
	
	
		o_ready <= 0;
		
		
		if (reset == 1)
		begin
			op_code = 0;
			o_ready <= 0;
		end
		
		
		
	
		if (i_ready == 1)
		begin
		
		case (op) 
			plus: begin
				op_code <= 8'b000000001;
				o_ready <= 1;
			end
			
		endcase;
		
		end
		
	end
endmodule
