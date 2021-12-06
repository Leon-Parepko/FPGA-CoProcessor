///////////////////////////////////////////////////
// This module is used to generate write_matrix
// signal for DEMUX due to size of matrix
//////////////////////////////////////////////////


module MATRIX_WRITE_DATA
(
	
//	input i_clk,      zachem clk kogda est cock))))
	input i_ready,
	input [7:0] size_x,
	input [7:0] size_y,
	input reset,
	
	output reg o_done,	
	output reg [7:0] write_mat_type		//type - size_x X size_y    1-2X2, 2-3X3, 3-4X4, 4-5X5, 5-2X0, 6-3X0, 7-4X0, 8-5X0
);	

	
	always @(posedge i_ready) begin
		
		
		if (size_y == 0) begin
			write_mat_type = size_x + 3;		// it would not be 8 bits (change)
		end
		
		else begin
			write_mat_type = size_x - 1;
		end
		
		o_done = 1;
			
			
	end
	
	
	
	
	
//	always @(negedge i_ready) begin
//	o_done = 0;
//	end
	
	
	
	
//	always @(posedge reset) begin
//	
//			o_done = 		0;
//			write_mat_type = 0; 
//			
//			end
			
			
endmodule
