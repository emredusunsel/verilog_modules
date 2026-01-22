
import clock_divider_pkg::*;

module clock_divider (
    input   logic       clk_i,
    input   logic       rst_ni,
    input   logic       enable_i,
    output  logic       clk_div_o
);

    localparam int CNTMAX   = DIV/2;
    logic   [$clog2(CNTMAX)-1:0]   counter;

    always_ff @(posedge clk_i or negedge rst_ni) begin : divider
        if (!rst_ni) begin
            counter     <= '0;
            clk_div_o   <= 0;
        end else if (enable_i) begin
            if (counter == CNTMAX-1) begin
                counter     <= '0;
                clk_div_o   <= ~clk_div_o;
            end else begin
                counter     <= counter + 1;
            end
        end
    end

endmodule
