///////////////////////////////////////////////////////////////////
// This file contains the UART Receiver. This receiver is able to
// receive 24 bits of serial data, one start bit, one stop bit,
// and no parity bit. When receive is complete o_rx_done will be
// driven high for one clock cycle.
///////////////////////////////////////////////////////////////////

module uart_tx #(parameter DATA_WIDTH = 24) (i_rx_serial, i_clk, o_rx_done, o_rx_data);

	input i_rx_serial;
	input i_clk;
	
	//reg r_rx_data_r = 1'b1;
	//reg r_rx_data   = 1'b1;
	
	output o_rx_done;
	output [DATA_WIDTH-1:0] o_rx_data;
	
	// States
	reg [1:0] s_STATE;
	
	localparam s_IDLE         = 2'b00;
	localparam s_RX_START_BIT = 2'b01;
	localparam s_RX_DATA_BITS = 2'b10;
	localparam s_RX_STOP_BIT  = 2'b11;
	
	// Main state-machine of UART
	always @(posedge i_clk) begin
		case (s_STATE)
			s_IDLE: begin
			
			end
		endcase
	end
endmodule
