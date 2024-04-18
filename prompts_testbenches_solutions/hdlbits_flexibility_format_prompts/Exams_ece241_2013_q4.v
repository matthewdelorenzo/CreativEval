// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 

    parameter A2 = 0, B1 = 1, B2 = 2, C1 = 3, C2 = 4, D1 = 5;
    reg [2:0] state, next;

    always @(posedge clk) begin
        if (reset) begin
            state <= A2;
        end
        else begin
            state <= next;
        end
    end

    always @(*) begin
        case (state)
            A2: next = s[1] ? B1 : A2;
            B1: next = s[2] ? C1 : (s[1] ? B1 : A2);
            B2: next = s[2] ? C1 : (s[1] ? B2 : A2);
            C1: next = s[3] ? D1 : (s[2] ? C1 : B2);
            C2: next = s[3] ? D1 : (s[2] ? C2 : B2);
            D1: next = s[3] ? D1 : C2;
            default: next = 3'bxxx;
        endcase
    end

    always @(*) begin
        case (state)
            A2: {fr3, fr2, fr1, dfr} = 4'b1111;
            B1: {fr3, fr2, fr1, dfr} = 4'b0110;
            B2: {fr3, fr2, fr1, dfr} = 4'b0111;
            C1: {fr3, fr2, fr1, dfr} = 4'b0010;
            C2: {fr3, fr2, fr1, dfr} = 4'b0011;
            D1: {fr3, fr2, fr1, dfr} = 4'b0000;
            default: {fr3, fr2, fr1, dfr} = 4'bxxxx;
        endcase
    end

endmodule


// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
);
