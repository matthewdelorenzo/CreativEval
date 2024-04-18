// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //

    // FSM from fsm_ps2
    parameter b1 = 1, b2 = 2, b3 = 3, dn = 4;
    reg [2:0] state, next_state;
    reg [23:0] data;

    always @(*) begin
        case ({state, in[3]})
            {b1, 1'b0}: next_state = b1;
            {b1, 1'b1}: next_state = b2;
            {b2, 1'b0}: next_state = b3;
            {b2, 1'b1}: next_state = b3;
            {b3, 1'b0}: next_state = dn;
            {b3, 1'b1}: next_state = dn;
            {dn, 1'b0}: next_state = b1;
            {dn, 1'b1}: next_state = b2;
        endcase
    end

    always @(posedge clk) begin
        if (reset) begin
            state <= b1;
        end
        else begin
            state <= next_state;
        end
    end

    assign done = (state == dn);

    // New: Datapath to store incoming bytes.
    always @(posedge clk) begin
        if (reset) begin
            data <= 24'd0;
        end
        else begin
            data[23:16] <= data[15:8];
            data[15:8] <= data[7:0];
            data[7:0]  <= in;
        end
    end

    assign out_bytes = (done) ? data : 24'd0;

endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done);
