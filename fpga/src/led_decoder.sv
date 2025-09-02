/*
led_decoder.sv
Author: Georgia Tai, ytai@g.hmc.edu
Date: Sep 1, 2025
LED decoder, two of which given by 4 switches and one blinking at 2.4Hz.
*/

module led_decoder(
	input  logic       clk,
	input  logic [3:0] switches,
	output logic [2:0] led
);

	logic led_state;
	logic [24:0] counter = 0;
	
	// Setting led blinking freq to 2.4Hz
	always_ff @(posedge clk) begin
	  if (counter >= 'd5000000) begin
		led_state <= ~led_state;
		counter   <= 0;
	  end else begin
		counter <= counter + 1;
	  end
	end

    assign led[0] = switches[1] ^ switches[0];
    assign led[1] = switches[3] & switches[2];
    assign led[2] = led_state;

endmodule