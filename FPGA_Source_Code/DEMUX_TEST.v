module DEMUX_TEST
(
   input i_clk,
	input i_ready,
	input i_mat_ready,
   input [7:0] i_data,
	input [7:0] mat_data_len,
   input reset,

	 
   output reg o_done,
	output reg o_mat_done,
   output reg [7:0] o_num_1,
	output reg [7:0] o_num_2,
   output reg [7:0] o_opcode
);

   reg [1:0] counter = 1;	
	reg [1:0] done = 0;
	reg [8:0] mat_counter = 0;
	
	reg mat_flag = 0;
	reg mat_finish_flag = 0;
	
	
	always @(posedge i_clk) begin
	
	
		if (reset == 1) begin 
			o_done <=   0;
			o_num_1 <=  0;
			o_num_2 <=  0;
			o_opcode <= 0;
			counter <=  1;
			done <=     0;
			mat_flag <= 0;
			mat_finish_flag <= 0;
		end
		
		
		
		
		if (i_mat_ready  == 1)begin 
			mat_counter <= mat_data_len; 
			mat_flag <= 1;
			mat_finish_flag <= 0;
		end
		
		if (mat_counter == 0) mat_flag <= 0;
		
		
	
	
		if (done == 2) done <= 0;
		if (done == 1) done <= 2;
        
		if (i_ready == 1) begin
			case (counter)
				1: begin
					if (mat_flag == 1 && mat_counter != 0) mat_counter <= mat_counter - 1;		
					if (mat_flag == 0 &&  mat_counter == 0) o_num_1 <= 0;						// use other special symbol (not "0")
					else o_num_1 <= i_data;
					counter <= 2;
				end
				2: begin
					if (mat_flag == 1 && mat_counter != 0) mat_counter <= mat_counter - 1;		
					if (mat_flag == 0 &&  mat_counter == 0) o_num_2 <= 0;						// use other special symbol (not "0")
					else o_num_2 <= i_data;
					counter <= 3;
				end
				3: begin
					if (mat_flag == 1 && mat_counter != 0) mat_counter <= mat_counter - 1;		
					if (mat_flag == 0 &&  mat_counter == 0) o_opcode <= 0;						// use other special symbol (not "0")
					else o_opcode <= i_data;
					counter <= 1;

					
					if (mat_flag == 0 && mat_finish_flag == 0) done <= 1;
					if (mat_flag == 1 && mat_finish_flag == 1) o_mat_done <= 1;
				end
			endcase
		end
		
		if (done != 0) o_done <= 1;
		else o_done <= 0;
	end
endmodule
