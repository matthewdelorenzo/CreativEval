// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);

    parameter a = 0, b = 1, c = 2, d = 3, e = 4;
    reg [2:0] state, next_state;

    always @(*) begin
        case (state)
            a: next_state = x ? b : a;
            b: next_state = x ? e : b;
            c: next_state = x ? b : c;
            d: next_state = x ? c : b;
            e: next_state = x ? e : d;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= a;
        end
        else begin
            state <= next_state;
        end
    end

    assign z = (state == d || state == e);

endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
