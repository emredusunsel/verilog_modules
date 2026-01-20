
module mux_wrap_v1
import mux_pkg::*;
(
    input   logic   clk,
    input   logic   rst_n,

    input   logic   [WIDTH-1:0]                     mux_i [N],
    input   logic   [(N <= 1) ? 1 : $clog2(N)-1:0]  sel_i,
    output  logic   [WIDTH-1:0]                     mux_o
);

    // Registered inputs
    logic   [WIDTH-1:0]                         mux_r [N];
    logic   [((N <= 1) ? 1 : $clog2(N))-1:0]    sel_r;

    // Combinational mux result
    logic   [WIDTH-1:0] mux_c;

    // Your combinational mux DUT
    mux_parametric_v1 dut (
        .mux_i (mux_i_r),
        .sel_i (sel_r),
        .mux_o (mux_c)
    );

    // Input + output registers (reg-to-reg timing)
    int k;
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            sel_r <= '0;
            mux_o <= '0;
            for (k = 0; k < N; k++) mux_i_r[k] <= '0;
        end
        else begin
            sel_r <= sel_i;
            for (k = 0; k < N; k++) mux_i_r[k] <= mux_i[k];
            mux_o <= mux_c;
        end
    end

endmodule
