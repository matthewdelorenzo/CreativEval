`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg in;
    reg [9:0] state;

    wire [9:0] next_state;
    wire out1;
    wire out2;


    integer mismatch_count;

    top_module UUT (.in(in), .state(state), .next_state(next_state), .out1(out1), .out2(out2));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'bx, 10'b0000000000, Generated = next_state, out1, out2, Reference = 10'b0000000000, 1'b0, 1'b0
        in = 1'bx; state = 10'b0000000000; // Set input values
        #period;
        if (!(next_state === 10'b0000000000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'bx, 10'b0000000000, next_state, out1, out2, 10'b0000000000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 10'b0000000001, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b0, 1'b0
        in = 1'b0; state = 10'b0000000001; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0000000001, next_state, out1, out2, 10'b0000000001, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b0, 10'b0000000010, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b0, 1'b0
        in = 1'b0; state = 10'b0000000010; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0000000010, next_state, out1, out2, 10'b0000000001, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b0, 10'b0000000100, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b0, 1'b0
        in = 1'b0; state = 10'b0000000100; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0000000100, next_state, out1, out2, 10'b0000000001, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b0, 10'b0000001000, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b0, 1'b0
        in = 1'b0; state = 10'b0000001000; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0000001000, next_state, out1, out2, 10'b0000000001, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b0, 10'b0000010000, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b0, 1'b0
        in = 1'b0; state = 10'b0000010000; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0000010000, next_state, out1, out2, 10'b0000000001, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b0, 10'b0000100000, Generated = next_state, out1, out2, Reference = 10'b0100000000, 1'b0, 1'b0
        in = 1'b0; state = 10'b0000100000; // Set input values
        #period;
        if (!(next_state === 10'b0100000000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0000100000, next_state, out1, out2, 10'b0100000000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b0, 10'b0001000000, Generated = next_state, out1, out2, Reference = 10'b1000000000, 1'b0, 1'b0
        in = 1'b0; state = 10'b0001000000; // Set input values
        #period;
        if (!(next_state === 10'b1000000000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0001000000, next_state, out1, out2, 10'b1000000000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        // Tick 8: Inputs = 1'b0, 10'b0010000000, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b0, 1'b1
        in = 1'b0; state = 10'b0010000000; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b0 && out2 === 1'b1)) begin
            $display("Mismatch at index 8: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0010000000, next_state, out1, out2, 10'b0000000001, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 8 passed!");
        end

        // Tick 9: Inputs = 1'b0, 10'b0100000000, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b1, 1'b0
        in = 1'b0; state = 10'b0100000000; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b1 && out2 === 1'b0)) begin
            $display("Mismatch at index 9: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b0100000000, next_state, out1, out2, 10'b0000000001, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 9 passed!");
        end

        // Tick 10: Inputs = 1'b0, 10'b1000000000, Generated = next_state, out1, out2, Reference = 10'b0000000001, 1'b1, 1'b1
        in = 1'b0; state = 10'b1000000000; // Set input values
        #period;
        if (!(next_state === 10'b0000000001 && out1 === 1'b1 && out2 === 1'b1)) begin
            $display("Mismatch at index 10: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b0, 10'b1000000000, next_state, out1, out2, 10'b0000000001, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 10 passed!");
        end

        // Tick 11: Inputs = 1'b1, 10'b0000000001, Generated = next_state, out1, out2, Reference = 10'b0000000010, 1'b0, 1'b0
        in = 1'b1; state = 10'b0000000001; // Set input values
        #period;
        if (!(next_state === 10'b0000000010 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 11: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0000000001, next_state, out1, out2, 10'b0000000010, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 11 passed!");
        end

        // Tick 12: Inputs = 1'b1, 10'b0000000010, Generated = next_state, out1, out2, Reference = 10'b0000000100, 1'b0, 1'b0
        in = 1'b1; state = 10'b0000000010; // Set input values
        #period;
        if (!(next_state === 10'b0000000100 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 12: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0000000010, next_state, out1, out2, 10'b0000000100, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 12 passed!");
        end

        // Tick 13: Inputs = 1'b1, 10'b0000000100, Generated = next_state, out1, out2, Reference = 10'b0000001000, 1'b0, 1'b0
        in = 1'b1; state = 10'b0000000100; // Set input values
        #period;
        if (!(next_state === 10'b0000001000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 13: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0000000100, next_state, out1, out2, 10'b0000001000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 13 passed!");
        end

        // Tick 14: Inputs = 1'b1, 10'b0000001000, Generated = next_state, out1, out2, Reference = 10'b0000010000, 1'b0, 1'b0
        in = 1'b1; state = 10'b0000001000; // Set input values
        #period;
        if (!(next_state === 10'b0000010000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 14: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0000001000, next_state, out1, out2, 10'b0000010000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 14 passed!");
        end

        // Tick 15: Inputs = 1'b1, 10'b0000010000, Generated = next_state, out1, out2, Reference = 10'b0000100000, 1'b0, 1'b0
        in = 1'b1; state = 10'b0000010000; // Set input values
        #period;
        if (!(next_state === 10'b0000100000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 15: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0000010000, next_state, out1, out2, 10'b0000100000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 15 passed!");
        end

        // Tick 16: Inputs = 1'b1, 10'b0000100000, Generated = next_state, out1, out2, Reference = 10'b0001000000, 1'b0, 1'b0
        in = 1'b1; state = 10'b0000100000; // Set input values
        #period;
        if (!(next_state === 10'b0001000000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 16: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0000100000, next_state, out1, out2, 10'b0001000000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 16 passed!");
        end

        // Tick 17: Inputs = 1'b1, 10'b0001000000, Generated = next_state, out1, out2, Reference = 10'b0010000000, 1'b0, 1'b0
        in = 1'b1; state = 10'b0001000000; // Set input values
        #period;
        if (!(next_state === 10'b0010000000 && out1 === 1'b0 && out2 === 1'b0)) begin
            $display("Mismatch at index 17: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0001000000, next_state, out1, out2, 10'b0010000000, 1'b0, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 17 passed!");
        end

        // Tick 18: Inputs = 1'b1, 10'b0010000000, Generated = next_state, out1, out2, Reference = 10'b0010000000, 1'b0, 1'b1
        in = 1'b1; state = 10'b0010000000; // Set input values
        #period;
        if (!(next_state === 10'b0010000000 && out1 === 1'b0 && out2 === 1'b1)) begin
            $display("Mismatch at index 18: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0010000000, next_state, out1, out2, 10'b0010000000, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 18 passed!");
        end

        // Tick 19: Inputs = 1'b1, 10'b0100000000, Generated = next_state, out1, out2, Reference = 10'b0000000010, 1'b1, 1'b0
        in = 1'b1; state = 10'b0100000000; // Set input values
        #period;
        if (!(next_state === 10'b0000000010 && out1 === 1'b1 && out2 === 1'b0)) begin
            $display("Mismatch at index 19: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b0100000000, next_state, out1, out2, 10'b0000000010, 1'b1, 1'b0);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 19 passed!");
        end

        // Tick 20: Inputs = 1'b1, 10'b1000000000, Generated = next_state, out1, out2, Reference = 10'b0000000010, 1'b1, 1'b1
        in = 1'b1; state = 10'b1000000000; // Set input values
        #period;
        if (!(next_state === 10'b0000000010 && out1 === 1'b1 && out2 === 1'b1)) begin
            $display("Mismatch at index 20: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b1000000000, next_state, out1, out2, 10'b0000000010, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 20 passed!");
        end

        // Tick 21: Inputs = 1'b1, 10'b1000000000, Generated = next_state, out1, out2, Reference = 10'b0000000010, 1'b1, 1'b1
        in = 1'b1; state = 10'b1000000000; // Set input values
        #period;
        if (!(next_state === 10'b0000000010 && out1 === 1'b1 && out2 === 1'b1)) begin
            $display("Mismatch at index 21: Inputs = [%b, %b], Generated = [%b, %b, %b], Reference = [%b, %b, %b]", 1'b1, 10'b1000000000, next_state, out1, out2, 10'b0000000010, 1'b1, 1'b1);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 21 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 22);
        $finish;
    end

endmodule