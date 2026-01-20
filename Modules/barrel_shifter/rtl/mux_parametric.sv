
module mux_parametric #(
    parameter int WIDTH = 32,       // input width
    parameter int N = 4             // number of inputs
) (
    input   logic   [WIDTH-1:0]         mux_i [N],
    input   logic   [$clog2(N)-1:0]     sel_i,
    output  logic   [WIDTH-1:0]         mux_o
);
//--------------------------------------------------//
//  VERSION I
//--------------------------------------------------//
    always_comb begin : mux
        if (sel_i < N)
            mux_o   = mux_i[sel_i];
        else
            mux_o  = '0;
    end

//--------------------------------------------------//
//  VERSION II
//
//  assign mux_o = (sel_i < N) ? mux_i[sel_i] : '0;
//
//--------------------------------------------------//

endmodule
