// You are a professional hardware designer that writes correct, fully functional Verilog modules.
// Given the fully implemented example of the Verilog module below:

// synthesis verilog_input_version verilog_2001
module true_module (
    input [7:0] in,
    output reg [2:0] pos  );

    always @(*) begin
        casez(in)
            8'bzzzzzzz1 : pos = 0;
            8'bzzzzzz1z : pos = 1;
            8'bzzzzz1zz : pos = 2;
            8'bzzzz1zzz : pos = 3;
            8'bzzz1zzzz : pos = 4;
            8'bzz1zzzzz : pos = 5;
            8'bz1zzzzzz : pos = 6;
            8'b1zzzzzzz : pos = 7;
            default : pos = 0;
        endcase
    end
    
endmodule

// Finish writing a different and unique implementation of the provided true_module in the module below, top_module.
// This module should be correct and have the same exact functionality as the provided solution above, but implemented in a unique variation from the provided module code.
//The top_module should not utilize the true_module in any way.
module top_module (
    input [7:0] in,
    output reg [2:0] pos  );
