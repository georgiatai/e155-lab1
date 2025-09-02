/*
lab1_gt.sv
Author: Georgia Tai, ytai@g.hmc.edu
Date: Sep 1, 2025
Top level module for Lab 1 of E155 @HMC. Controls 3 LEDs and a 7-segment display with 4 switches.
*/

module lab1_gt(
	input  logic [3:0] s,
	output logic [2:0] led, 
	output logic [6:0] seg
);

	logic clk;
	
	// Internal high-speed oscillator (freq = 24 MHz)
	HSOSC #(.CLKHF_DIV(2'b01)) 
	      hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// Modules for LED and segment display decoders
	led_decoder ledDecoder (.clk(clk), .switches(s), .led(led));
	seven_seg_decoder segDecoder (.hex(s), .seg(seg));	

endmodule