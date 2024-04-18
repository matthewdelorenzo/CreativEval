// Build a four-bit shift register that also acts as a down counter. Data is shifted in most-significant-bit first when shift_ena is 1. The number currently in the shift register is decremented when count_ena is 1. Since the full system doesn't ever use shift_ena and count_ena together, it does not matter what your circuit does if both control inputs are 1 (This mainly means that it doesn't matter which case gets higher priority).

module top_module (
    input clk,
    input shift_ena,
    input count_ena,
    input data,
    output [3:0] q);
