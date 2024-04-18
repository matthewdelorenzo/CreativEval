// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
    
    wire [7:0] q1, q2, q3;
    my_dff8 instance1(.clk(clk), .d(d), .q(q1));
    my_dff8 instance2(.clk(clk), .d(q1), .q(q2));
    my_dff8 instance3(.clk(clk), .d(q2), .q(q3));
    
    always @(*) begin
        case(sel)
            0 : q = d;
            1 : q = q1;
            2 : q = q2;
            3 : q = q3;
        endcase
    end

endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module ( 
    input clk, 
    input [7:0] d, 
    input [1:0] sel, 
    output [7:0] q 
);
