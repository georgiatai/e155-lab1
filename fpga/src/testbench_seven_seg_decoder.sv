/////////////////////////
// testbench_seven_seg_decoder.sv
// Author: Georgia Tai, ytai@g.hmc.edu
// Date: Sep 1, 2025
//
// Testbench for the 7-segment display module.
/////////////////////////

`timescale 1ns/1ps

module testbench_seven_seg_decoder(); 
    logic        clk;
    logic [3:0]  s;
    logic [6:0]  seg, segexpected;
    logic [31:0] vectornum, errors; 
    logic [10:0] testvectors[10000:0];  // testvector = s[3:0]_segexpected[6:0]

    // Initialize DUT
    // inputs: s. outputs: segments
    seven_seg_decoder dut(.hex(s), .segments(seg)); 

    // Generate clock with a period of 10 time units
    always begin
        clk = 1; #5;  
        clk = 0; #5; 
    end

    // Read test vectors
    initial begin
        $readmemb("C:/Users/User/Desktop/e155_lab1/fpga/radiant_project/lab1_gt/source/impl_1/testbench_seven_seg_decoder.tv", testvectors);
        vectornum=0;  
        errors=0;
    end

    // Apply test vectors on rising edge of clk
    always @(posedge clk) begin
        #1; 
        {s, segexpected} = testvectors[vectornum]; 
    end

    // Check results on falling edge of clk
    always @(negedge clk) begin
        if (seg !== segexpected) begin 
            $display("Error: inputs = %b", s); 
            $display(" seg = %b (%b expected)", seg, segexpected); 
            errors = errors + 1; 
        end

        vectornum = vectornum + 1;

        // Stop if all test vectors have been applied
        if (testvectors[vectornum] === 11'bx) begin 
            $display("%d tests completed with %d errors", vectornum, errors); 
            $stop;
        end
    end

endmodule