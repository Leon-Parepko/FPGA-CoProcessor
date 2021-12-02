///////////////////////////////////////////////////////////////////
// This file contains the UART Transmitter. This transmitter is
// able to transmit 8 bits of serial data, one start bit, one
// stop bit, and no parity bit. When receive is complete
// o_tx_done will be driven high for one clock cycle.
///////////////////////////////////////////////////////////////////

module UART_TX #
(
	parameter CLOCK_FREQUENCY = 50_000_000,
	parameter BAUD_RATE       = 115200
)
(
	input i_clk,
	input [7:0] i_tx_byte,
	input i_tx_begin,

	output wire o_tx_serial
);

	localparam HALF_BAUD_CLK_REG_VALUE = (CLOCK_FREQUENCY / BAUD_RATE / 2 - 1);
	localparam HALF_BAUD_CLK_REG_SIZE  = $clog2(HALF_BAUD_CLK_REG_VALUE);

    reg [HALF_BAUD_CLK_REG_SIZE - 1:0] r_clock_counter = 0;
    reg tx_baud_clk = 1'b0;

    reg [9:0] r_data = 10'h001;
    reg [3:0] txCounter = 4'h0; 

    assign r_tx_ready = !txCounter[3:1];
    assign r_tx_idle = r_tx_ready & (~txCounter[0]);
    assign o_tx_serial = r_data[0];

    always @(posedge i_clk) begin
        if (r_tx_idle & ~i_tx_begin) begin
            r_clock_counter <= 0;
            tx_baud_clk <= 1'b0;
        end else if (r_clock_counter == 0) begin
            r_clock_counter <= HALF_BAUD_CLK_REG_VALUE;
            tx_baud_clk <= ~tx_baud_clk;
        end else begin
            r_clock_counter <= r_clock_counter - 1'b1;
        end
    end

    always @(posedge tx_baud_clk) begin
        if (~r_tx_ready) begin
            r_data <= { 1'b0, r_data[9:1] };
            txCounter <= txCounter - 1'b1;
        end else if(i_tx_begin) begin
            r_data <= { 1'b1, i_tx_byte[7:0], 1'b0 };
            txCounter <= 4'hA;
        end else begin
            txCounter <= 4'h0;
        end
    end
endmodule
