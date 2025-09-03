/////////////////////////
// led2_counter.sv
// Author: Georgia Tai, ytai@g.hmc.edu
// Date: Sep 1, 2025
// 
// Counter to control a LED to blink at 2.4Hz.
/////////////////////////

module led2_counter(
	input  logic clk, // Input clk with 24 MHz frequency by HSOSC
	output logic led2
);

	logic led_state;
	logic [24:0] counter = 0;
	
	// Setting led blinking freq to 2.4Hz
	always_ff @(posedge clk) begin
	  	if (counter >= 'd5000000) begin
			led_state <= ~led_state; // toggle LED state
			counter   <= 0;
	  	end else begin
			counter <= counter + 1;
	  	end
	end

    assign led2 = led_state;

endmodule