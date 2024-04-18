// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );

    wire abc1, def1, ab2, cd2;
    assign abc1 = p1c & p1b & p1a;
    assign def1 = p1f & p1e & p1d;
    assign p1y = abc1 | def1;
    
    assign ab2 = p2a & p2b;
    assign cd2 = p2c & p2d;
    assign p2y = ab2 | cd2;
    
endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module ( 
    input p1a, p1b, p1c, p1d, p1e, p1f,
    output p1y,
    input p2a, p2b, p2c, p2d,
    output p2y );
