module comparator(D, clk, in_ready, op_code, valid);

	input [7:0] D;
	input in_ready;
	input clk;
	
	output [7:0] op_code;
	output valid;
	
	reg [7:0] op_code;
	reg valid;
	
	parameter plus = 8'h2B;
	
	always @(posedge clk & in_ready) begin
		case (D) 
			plus: begin
				op_code = 8'b000000001;
				valid = 1;
			end
			
			default: begin
				valid = 0;
			end
		endcase;
	end
endmodule
