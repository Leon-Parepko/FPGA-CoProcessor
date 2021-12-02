module demux_1_to_3_bus_8(in, clk, i_ready, reset, num_1, num_2, op_code, o_ready);

	input [7:0] in;
	input clk;
	input i_ready;
	input reset;
	
	output [7:0] num_1;
	output [7:0] num_2;
	output [7:0] op_code;
	
	output o_ready;
	
	reg [7:0] n_1;
	reg [7:0] n_2;
	
	reg [7:0] num_1;
	reg [7:0] num_2;
	reg [7:0] op_code;
	reg o_ready;

	integer counter = 0;
	
	always @(posedge clk) begin
		o_ready = 0;
		
		if (i_ready == 1) begin
			counter = counter + 1;
		end
	
		case (counter)
			1: begin
				n_1 <= in;
			end
			
			2: begin
				n_2 = in;
			end
			
			3: begin
				num_1 <= n_1;
				num_2 <= n_2;
				op_code <= in;
				
				o_ready = 1;
				counter = 0;
			end
		endcase
	end
endmodule
