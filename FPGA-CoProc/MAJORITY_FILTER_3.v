///////////////////////////////////////////////////////////////////
// This file contains the Majority Element. This element is able to
// filter serial data and fix metastability errors.
///////////////////////////////////////////////////////////////////

module MAJORITY_FILTER_3
(
	input i_clk,
	input i_rx,

	output wire o_rx
);
	reg [2:0] rx_lock = 3'b111;

	assign o_rx = (rx_lock[0] & rx_lock[1]) | (rx_lock[0] & rx_lock[2]) | (rx_lock[1] & rx_lock[2]);
	
	always @(posedge i_clk) begin
		rx_lock <= { i_rx, rx_lock[2:1] };
	end
endmodule
