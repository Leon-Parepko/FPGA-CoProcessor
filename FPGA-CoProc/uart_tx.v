///////////////////////////////////////////////////////////////////
// This file contains the UART Receiver. This receiver is able to
// receive 8 bits of serial data, one start bit, one stop bit,
// and no parity bit. When receive is complete o_rx_done will be
// driven high for one clock cycle.
///////////////////////////////////////////////////////////////////

module uart_tx #(parameter clks_per_bit = 87) (i_rx_serial, i_clk, o_rx_done, o_rx_byte);

	parameter START_BIT = 1'b0;
	parameter STOP_BIT  = 1'b1;

	input i_rx_serial;
	input i_clk;
	
	// Outputs
	output o_rx_done;
	output [7:0] o_rx_byte;
	
	reg r_rx_done = 0;
	reg [7:0] r_rx_byte;
	
	reg [15:0] r_clock_counter = 0; // 16-bit clock counter - max clks_per_bit 65535 
	reg [2:0] r_bit_index = 0;
	
	// States
	localparam s_IDLE         = 2'b00;
	localparam s_RX_START_BIT = 2'b01;
	localparam s_RX_DATA_BITS = 2'b10;
	localparam s_RX_STOP_BIT  = 2'b11;
	
	reg [1:0] s_STATE = s_IDLE;
	
	// Double register
	reg r_rx_data = 1'b1;
	reg r_rx_data_temp = 1'b1;
	always @(posedge i_clk) begin
		r_rx_data_temp <= i_rx_serial;
		r_rx_data <= r_rx_data_temp;
	end
	
	// Main state-machine of UART
	always @(posedge i_clk) begin
		case (s_STATE)
			s_IDLE: begin
				r_rx_done <= 1'b0;
				
				r_bit_index <= 0;
				r_clock_counter <= 0;
				
				if (r_rx_data == START_BIT)
					s_STATE <= s_RX_START_BIT;
			end
			
			s_RX_START_BIT: begin
				if (r_clock_counter == (clks_per_bit - 1) / 2) begin
					if (r_rx_data == START_BIT) begin
						r_bit_index <= 0;
						r_clock_counter <= 0;

						s_STATE <= s_RX_DATA_BITS;
					end else s_STATE <= s_IDLE;
				end else begin
					r_clock_counter <= r_clock_counter + 1;
					s_STATE <= s_IDLE;
				end
			end
			
			s_RX_DATA_BITS: begin
				if (r_clock_counter < clks_per_bit - 1) begin
					r_clock_counter <= r_clock_counter + 1;
				end else begin
					r_clock_counter <= 0;
					r_rx_byte[r_bit_index] <= r_rx_data;

					if (r_bit_index <= 8) begin
						r_bit_index <= r_bit_index + 1;
					end else begin
						r_clock_counter <= 0;
						s_STATE <= s_RX_STOP_BIT;
					end
				end
			end
			
			s_RX_STOP_BIT: begin
				if (r_clock_counter == (clks_per_bit - 1) / 2) begin
					if (r_rx_byte == STOP_BIT) begin
						r_rx_done <= 1'b1;
						s_STATE <= s_IDLE;
					end else s_STATE <= s_IDLE;
				end else begin
					r_clock_counter <= r_clock_counter + 1;
					s_STATE <= s_RX_STOP_BIT;
				end
			end
			
			default:
				s_STATE <= s_IDLE;
		endcase
	end
	
	assign o_rx_done = r_rx_done;
	assign o_rx_byte = r_rx_byte;
endmodule
