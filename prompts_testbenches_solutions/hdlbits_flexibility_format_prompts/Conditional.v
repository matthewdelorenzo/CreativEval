// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module (
    input [7:0] a, b, c, d,
    output [7:0] min);//

    // assign intermediate_result1 = compare? true: false;
    wire [7:0] min_mid, min_mid1, min_mid2;
    assign min_mid = (a < b) ? a : b;
    assign min_mid1 = (c < min_mid) ? c : min_mid;
    assign min_mid2 = (d < min_mid1) ? d : min_mid1;
    assign min = min_mid2;

endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input [7:0] a, b, c, d,
    output [7:0] min);
