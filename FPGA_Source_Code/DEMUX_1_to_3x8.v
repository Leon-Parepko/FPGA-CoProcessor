module DEMUX_1_to_3x8
(
   input i_clk,
	input i_ready,
   input [7:0] i_data,
   input reset,

	 
   output reg o_done,
   output reg [7:0] o_num_1,
	output reg [7:0] o_num_2,
   output reg [7:0] o_opcode
);

   reg [1:0] counter = 2'b01;	
	reg [1:0] done = 0;
	
	
	always @(posedge i_clk) begin
		if (done == 2'b10) done <= 0;
		if (done == 2'b01) done <= 2'b10;
        
		if (i_ready == 1) begin
			case (counter)
				2'b01: begin
					o_num_1 <= i_data;
					counter <= 2'b10;
				end
				2'b10: begin
					o_num_2 <= i_data;
					counter <= 2'b11;
				end
				2'b11: begin
					counter <= 2'b01;

					o_opcode <= i_data;
					done <= 2'b01;
				end
			endcase
		end
		
		if (done != 0) o_done <= 1;
		else o_done <= 0;
	end
endmodule
