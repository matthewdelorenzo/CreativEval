// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
    
    parameter c0=3'd0, c1=3'd1, c2=3'd2, c3=3'd3, c4=3'd4;
    reg [2:0]   state, next_state;
    
    always@(*) begin
        case(state)
            c0:     next_state = reset ? c1 : c0;
            c1:     next_state = c2;
            c2:     next_state = c3;
            c3:     next_state = c4;
            c4:     next_state = c0;
        endcase
    end
    
    always@(posedge clk) begin
       state <= next_state; 
    end
    
    assign shift_ena = (state==c1 || state==c2 || state==c3 || state==c4);
    
endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena);
