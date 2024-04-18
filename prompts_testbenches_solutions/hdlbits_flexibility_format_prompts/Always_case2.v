// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

// synthesis verilog_input_version verilog_2001
module true_module (
    input [3:0] in,
    output reg [1:0] pos  );
    
    always @(*) begin
        case(in)
            4'b0000 : pos = 0;
            4'b0001 : pos = 0;
            4'b0010 : pos = 1;
            4'b0011 : pos = 0;
            4'b0100 : pos = 2;
            4'b0101 : pos = 0;
            4'b0110 : pos = 1;
            4'b0111 : pos = 0;
            4'b1000 : pos = 3;
            4'b1001 : pos = 0;
            4'b1010 : pos = 1;
            4'b1011 : pos = 0;
            4'b1100 : pos = 2;
            4'b1101 : pos = 0;
            4'b1110 : pos = 1;
            4'b1111 : pos = 0;
        endcase
    end

endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input [3:0] in,
    output reg [1:0] pos  );
