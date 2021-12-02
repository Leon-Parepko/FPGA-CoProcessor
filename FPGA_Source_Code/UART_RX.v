///////////////////////////////////////////////////////////////////
// This file contains the UART Receiver. This receiver is able to
// receive 8 bits of serial data, one start bit, one stop bit,
// and no parity bit. When receive is complete o_rx_done will be
// driven high for one clock cycle.
///////////////////////////////////////////////////////////////////

module UART_RX #
(
  parameter CLOCK_FREQUENCY = 50_000_000,
  parameter BAUD_RATE       = 115200
)
(
  // INPUTS //
  input i_rx_serial,
  input i_clk,
  
  // OUTPUTS //
  output wire o_rx_done,
  output wire [7:0] o_rx_byte
);  

  localparam HALF_BAUD_CLK_REG_VALUE = (CLOCK_FREQUENCY / BAUD_RATE / 2 - 1);
  localparam HALF_BAUD_CLK_REG_SIZE  = $clog2(HALF_BAUD_CLK_REG_VALUE);

  // FILTERING SIGNAL //
  wire i_rx_filtered;
  MAJORITY_FILTER_3 rx_filter
  (
    .i_clk(i_clk),
    .i_rx(i_rx_serial),
    .o_rx(i_rx_filtered)
  );

  reg [9:0] r_data = 0;
  assign o_rx_byte[7:0] = r_data[8:1];
  assign o_rx_done = ~r_data[0] & rx_baud_clk;

  // * BAUD CLOCK GENERATOR * //
  reg rx_baud_clk = 1'b0;
  reg [HALF_BAUD_CLK_REG_SIZE - 1:0] r_clock_counter = 0;
  
  always @(posedge i_clk) begin
    if (i_rx_filtered & ~r_data[0]) begin
      r_clock_counter <= HALF_BAUD_CLK_REG_VALUE;
      rx_baud_clk <= 0;
    end else if(r_clock_counter == 0) begin
      r_clock_counter <= HALF_BAUD_CLK_REG_VALUE;
      rx_baud_clk <= ~rx_baud_clk;
    end else begin
      r_clock_counter <= r_clock_counter - 1'b1;
    end
  end

  // RECIEVING SIGNAL //
  always @(posedge rx_baud_clk) begin
    if (r_data[0]) begin
      r_data <= { i_rx_filtered, r_data[9:1] };
    end else if(~i_rx_filtered) begin
      r_data <= 10'h1FF;
    end
  end
endmodule