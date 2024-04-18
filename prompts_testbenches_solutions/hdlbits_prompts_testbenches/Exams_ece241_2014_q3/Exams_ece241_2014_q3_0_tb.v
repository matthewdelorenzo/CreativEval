`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg c;
    reg d;

    wire [3:0] mux_in;


    integer mismatch_count;

    top_module UUT (.c(c), .d(d), .mux_in(mux_in));

    initial begin
        mismatch_count = 0;

        // Tick 0: Inputs = 1'b0, 1'b0, Generated = mux_in, Reference = 4'b0100
        c = 1'b0; d = 1'b0; // Set input values
        #period;
        if (!(mux_in === 4'b0100)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, mux_in, 4'b0100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 1'b0, Generated = mux_in, Reference = 4'b0100
        c = 1'b0; d = 1'b0; // Set input values
        #period;
        if (!(mux_in === 4'b0100)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, mux_in, 4'b0100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 1 passed!");
        end

        // Tick 2: Inputs = 1'b0, 1'b0, Generated = mux_in, Reference = 4'b0100
        c = 1'b0; d = 1'b0; // Set input values
        #period;
        if (!(mux_in === 4'b0100)) begin
            $display("Mismatch at index 2: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b0, mux_in, 4'b0100);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 2 passed!");
        end

        // Tick 3: Inputs = 1'b0, 1'b1, Generated = mux_in, Reference = 4'b0001
        c = 1'b0; d = 1'b1; // Set input values
        #period;
        if (!(mux_in === 4'b0001)) begin
            $display("Mismatch at index 3: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1, mux_in, 4'b0001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 3 passed!");
        end

        // Tick 4: Inputs = 1'b0, 1'b1, Generated = mux_in, Reference = 4'b0001
        c = 1'b0; d = 1'b1; // Set input values
        #period;
        if (!(mux_in === 4'b0001)) begin
            $display("Mismatch at index 4: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b0, 1'b1, mux_in, 4'b0001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 4 passed!");
        end

        // Tick 5: Inputs = 1'b1, 1'b0, Generated = mux_in, Reference = 4'b0101
        c = 1'b1; d = 1'b0; // Set input values
        #period;
        if (!(mux_in === 4'b0101)) begin
            $display("Mismatch at index 5: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, mux_in, 4'b0101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 5 passed!");
        end

        // Tick 6: Inputs = 1'b1, 1'b0, Generated = mux_in, Reference = 4'b0101
        c = 1'b1; d = 1'b0; // Set input values
        #period;
        if (!(mux_in === 4'b0101)) begin
            $display("Mismatch at index 6: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b0, mux_in, 4'b0101);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 6 passed!");
        end

        // Tick 7: Inputs = 1'b1, 1'b1, Generated = mux_in, Reference = 4'b1001
        c = 1'b1; d = 1'b1; // Set input values
        #period;
        if (!(mux_in === 4'b1001)) begin
            $display("Mismatch at index 7: Inputs = [%b, %b], Generated = [%b], Reference = [%b]", 1'b1, 1'b1, mux_in, 4'b1001);
            mismatch_count = mismatch_count + 1;
        end

        else begin
            $display("Test 7 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 8);
        $finish;
    end

endmodule