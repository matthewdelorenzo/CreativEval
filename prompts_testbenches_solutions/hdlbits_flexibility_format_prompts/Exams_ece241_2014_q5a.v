// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

module true_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter S0 = 0, S1 = 1, S2 = 2;
    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(*) begin
        case(state)
            S0 : begin
                next_state = x ? S1 : S0;
                z = 1'b0;
            end
            
            S1 : begin
                next_state = x ? S2 : S1;
                z = 1'b1;
            end
            
            S2 : begin
                next_state = x ? S2 : S1;
                z = 1'b0;
            end
            default : begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset)  
            state <= S0;
        else
            state <= next_state;
    end
    

endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input clk,
    input areset,
    input x,
    output z
);
