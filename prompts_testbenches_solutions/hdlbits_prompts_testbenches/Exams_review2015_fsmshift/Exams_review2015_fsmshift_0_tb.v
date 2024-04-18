`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg clk;
    reg reset;

    wire shift_ena;


    integer mismatch_count;

    top_module UUT (.clk(clk), .reset(reset), .shift_ena(shift_ena));

    initial // clk generation
    begin
        clk = 0;
        forever begin
            #(period/2);
            clk = ~clk;
        end
    end

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 1: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 2: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 3: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 4: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 5: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 6: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 7: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 8: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 9: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 10: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 11: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 12: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 13: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 14: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 15: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 16: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'bx
        reset = 1'b0; // Set input values
        #period;
        // Tick 17: Inputs = 1'b0, 1'b1, Generated = shift_ena, Reference = 1'bx
        reset = 1'b1; // Set input values
        #period;
        // Tick 18: Inputs = 1'b1, 1'b1, Generated = shift_ena, Reference = 1'b1
        reset = 1'b1; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 18: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b1, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'b1
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 19: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'b1
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 20: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'b1
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 21: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 21 passed!");
        end

        // Tick 22: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'b1
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 22: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 22 passed!");
        end

        // Tick 23: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'b1
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 23: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 23 passed!");
        end

        // Tick 24: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'b1
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 24: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 24 passed!");
        end

        // Tick 25: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'b1
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b1)) begin
            $display("Mismatch at index 25: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, shift_ena, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 25 passed!");
        end

        // Tick 26: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'b0
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b0)) begin
            $display("Mismatch at index 26: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, shift_ena, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 26 passed!");
        end

        // Tick 27: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'b0
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b0)) begin
            $display("Mismatch at index 27: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, shift_ena, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 27 passed!");
        end

        // Tick 28: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'b0
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b0)) begin
            $display("Mismatch at index 28: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, shift_ena, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 28 passed!");
        end

        // Tick 29: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'b0
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b0)) begin
            $display("Mismatch at index 29: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, shift_ena, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 29 passed!");
        end

        // Tick 30: Inputs = 1'b1, 1'b0, Generated = shift_ena, Reference = 1'b0
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b0)) begin
            $display("Mismatch at index 30: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, shift_ena, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 30 passed!");
        end

        // Tick 31: Inputs = 1'b0, 1'b0, Generated = shift_ena, Reference = 1'b0
        reset = 1'b0; // Set input values
        #period;
        if (!(shift_ena === 1'b0)) begin
            $display("Mismatch at index 31: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, shift_ena, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 31 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 32);
        $finish;
    end

endmodule