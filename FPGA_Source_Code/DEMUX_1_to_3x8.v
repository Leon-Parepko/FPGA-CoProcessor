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

   reg [1:0] counter = 1;	
	reg [1:0] done = 0;

	
	
	always @(posedge i_clk) begin
	
	
		if (reset == 1) begin 
			o_done <=   0;
			o_num_1 <=  0;
			o_num_2 <=  0;
			o_opcode <= 0;
			counter <=  1;
			done <=     0;
		end
	
		
		if (done == 2) done <= 0;
		if (done == 1) done <= 2;
        
		if (i_ready == 1) begin
			case (counter)
				1: begin
					o_num_1 <= i_data;
					counter <= 2;
				end
				2: begin
					o_num_2 <= i_data;
					counter <= 3;
				end
				3: begin
					counter <= 1;

					o_opcode <= i_data;
					done <= 1;
				end
			endcase
		end
		
		if (done != 0) o_done <= 1;
		else o_done <= 0;
	end
endmodule
