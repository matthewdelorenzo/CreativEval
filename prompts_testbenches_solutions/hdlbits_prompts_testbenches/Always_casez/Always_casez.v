// Build a priority encoder for 8-bit inputs. Given an 8-bit vector, 
// the output should report the first (least significant) bit in the vector that is 1. 
// Report zero if the input vector has no bits that are high. 
// For example, the input 8'b10010000 should output 3'd4, because bit[4] is first bit that is high.

// synthesis verilog_input_version verilog_2001
module top_module (
    input [7:0] in,
    output reg [2:0] pos );