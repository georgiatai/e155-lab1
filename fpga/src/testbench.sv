/////////////////////////
// testbench.sv
// Author: Georgia Tai, ytai@g.hmc.edu
// Date: Sep 1, 2025
//
// Testbench for the top level design (lab1_gt) of this lab.
/////////////////////////

`timescale 1ns/1ps

module testbench(); 
    logic        clk;
    logic [3:0]  s;
    logic [2:0]  led;
    logic [1:0]  ledexpected;
    logic [6:0]  seg, segexpected;
    logic [31:0] vectornum, errors; 
    logic [12:0] testvectors[10000:0];  // testvector = s[3:0]_ledexpected[1:0]_segexpected[6:0]
                                        // led[2] is ignored since it is controlled by internal oscillator
  
    // Initialize DUT
    // inputs: s. outputs: led, seg
    lab1_gt dut(.s(s), .led(led), .seg(seg)); 

    // Generate clock with a period of 10 time units
    always begin
        clk = 1; #5;  
        clk = 0; #5; 
    end

    // Read test vectors
    initial begin
        $readmemb("C:/Users/User/Desktop/e155_lab1/fpga/radiant_project/lab1_gt/source/impl_1/testbench.sv", testvectors);
        vectornum=0;  
        errors=0;
    end
  
    // Apply test vectors on rising edge of clk
    always @(posedge clk) begin
        #1; 
        {s, ledexpected, segexpected} = testvectors[vectornum]; 
    end
  
    // Check results on falling edge of clk
    always @(negedge clk) begin
        if (led[0] !== ledexpected[0] || led[1] !== ledexpected[1] || seg !== segexpected) begin 
            $display("Error: inputs = %b", s); 
            $display(" LED[1] = %b (%b expected)", led[1], ledexpected[1]); 
            $display(" LED[0] = %b (%b expected)", led[0], ledexpected[0]);
            $display(" seg = %b (%b expected)", seg, segexpected); 
            errors = errors + 1; 
        end
        
        vectornum = vectornum + 1;
        
        // Stop if all test vectors have been applied
        if (testvectors[vectornum] === 13'bx) begin 
            $display("%d tests completed with %d errors", vectornum, errors); 
            $stop;
        end
    end

endmodule
	  
	