
module demux_1_to_3_bus_8(in, clk, i_ready, out1, out2, out3, o_ready, reset);

	input [7:0] in;
	input clk;
	input i_ready;
	input reset;
	
	output [7:0] out1;
	output [7:0] out2;
	output [7:0] out3;
	output o_ready;
	
	reg [7:0] out1 = 0;
	reg [7:0] out2 = 0;
	reg [7:0] out3 = 0;
	reg o_ready = 0;
	integer counter = 1; 
	 
	
	always @(posedge clk) begin
	
		o_ready <= 1'b0;
	
	   if (i_ready == 1)
      begin
			counter = counter + 1;
      end
		
		
		if (reset == 1)
		begin
			counter = 1;
			out1 = 0;
			out2 = 0;
			out3 = 0;
		end
		
		
	
		case (counter)
			1: begin
				out1 = in;
			end
			
			2: begin
				out2 = in;
			end
				
			3: begin
				out3 = in;
				o_ready <= 1'b1;
				counter = 0;
			end
			
		endcase
		
	end
	
endmodule
