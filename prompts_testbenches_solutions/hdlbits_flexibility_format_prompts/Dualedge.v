// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module (
    input clk,
    input d,
    output q
);
    
    reg [1:0] status;
    
    always @(posedge clk) begin
        status[0] = d;
    end
    
    always @(negedge clk) begin
        status[1] = d;
    end
    
    assign q = clk ? status[0] : status[1];
    
endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input clk,
    input d,
    output q
);
