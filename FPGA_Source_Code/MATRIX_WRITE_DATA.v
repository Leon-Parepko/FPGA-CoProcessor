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
	
	output wire o_done,	
	output wire [7:0] mat_data_len		//type - size_x X size_y    1-2X2, 2-3X3, 3-4X4, 4-5X5, 5-2X0, 6-3X0, 7-4X0, 8-5X0
);


wire o_done_1 = 0;
wire o_done_2 = 1;
integer data_len = 0;

assign o_done = 	o_done_1 && o_done_2;
assign mat_data_len = data_len;

	
	always @(posedge i_ready) begin
		
		
		if (size_y == 0) begin
			data_len = (size_x ** 2) *2;
		end
		
		else begin
			data_len = (size_x ** 2) + 1;
		end
		
		
	end
	
	
	
	
//	always @(posedge reset) begin
//			data_len = 0; 
//	end
	
	
			
			
endmodule
