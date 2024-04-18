// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module ( input clk, input d, output q );
    wire q1, q2;
    my_dff instance1(.clk(clk), .d(d), .q(q1));
    my_dff instance2(.clk(clk), .d(q1), .q(q2));
    my_dff instance3(.clk(clk), .d(q2), .q(q));
endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module ( input clk, input d, output q );
