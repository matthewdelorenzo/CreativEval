// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
    wire [2:0] tmp;
    assign tmp = {x3,x2,x1};
    always @(*) begin
        case(tmp)
            2,3,5,7: begin
                f = 1;
            end
            0,1,4,6: begin
                f = 0;
            end
        endcase
    end

endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module ( 
    input x3,
    input x2,
    input x1,  // three inputs
    output f   // one output
);
