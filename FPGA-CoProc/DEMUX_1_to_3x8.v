module DEMUX_1_to_3x8
(
    input i_clk;
	input i_ready;
    input [7:0] i_data;
    input reset;

    reg o_done;
    reg [7:0] o_num_1;
	reg [7:0] o_num_2;
    reg [7:0] o_opcode;
);

    reg [1:0] counter = 0;	
	always @(posedge clk) begin
		o_done <= 0;
        
		if (i_ready) begin
			counter <= counter + 1;
		end

		case (counter)
			1: begin; o_num_1 <= i_data; end;
			2: begin; o_num_1 <= i_data; end;
			3: begin
				counter <= 0;

				o_opcode <= i_data;
				o_done <= 1;
			end
		endcase
	end
endmodule
