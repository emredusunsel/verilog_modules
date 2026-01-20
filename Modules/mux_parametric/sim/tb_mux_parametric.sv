
module tb_mux_parametric;
import mux_pkg::*;

    logic   [WIDTH-1:0]         mux_i [N];
    logic   [$clog2(N)-1:0]     sel_i;
    logic   [WIDTH-1:0]         mux_o;

    mux_parametric dut(
        .mux_i      (mux_i),
        .sel_i      (sel_i),
        .mux_o      (mux_o)
    );

    integer i;
    integer j;
    task automatic test();
        begin
            // Generate random inputs
            for (i = 0; i < N; i = i + 1) begin
                mux_i[i] = $urandom;
            end

            // Sweep through all possible selects
            for (j = 0; j < N; j = j + 1) begin
                sel_i = j;
                #10;
            end
        end
    endtask

    initial begin
        #10;
        test();
        #10;

        $finish;
    end

endmodule
