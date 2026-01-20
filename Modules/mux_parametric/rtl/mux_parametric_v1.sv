
module mux_parametric_v1
import mux_pkg::*;
(
    input   logic   [WIDTH-1:0]                     mux_i [N],
    input   logic   [(N <= 1) ? 1 : $clog2(N)-1:0]  sel_i,
    output  logic   [WIDTH-1:0]                     mux_o
);

    always_comb begin : mux
        if (sel_i < N)
            mux_o   = mux_i[sel_i];
        else
            mux_o  = '0;
    end

endmodule
