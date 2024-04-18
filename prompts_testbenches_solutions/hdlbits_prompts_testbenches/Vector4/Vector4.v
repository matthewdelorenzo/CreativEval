// Build a circuit that sign-extends an 8-bit number to 32 bits. 
// This requires a concatenation of 24 copies of the sign bit 
// (i.e., replicate bit[7] 24 times) followed by the 8-bit number itself.

// Hint: One common place to see a replication operator is when sign-extending 
// a smaller number to a larger one, while preserving its signed value. 
// This is done by replicating the sign bit (the most significant bit) of 
// the smaller number to the left. For example, sign-extending 4'b0101 (5) 
// to 8 bits results in 8'b00000101 (5), while sign-extending 4'b1101 (-3) 
// to 8 bits results in 8'b11111101 (-3).

module top_module (
    input [7:0] in,
    output [31:0] out );