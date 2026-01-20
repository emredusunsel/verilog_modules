
import counter_pkg::*;

module counter
(
    input                       clk_i,
    input                       rst_ni,
    input                       en_i,
    input   count_dir_e         dir_i,
    output  logic   [WIDTH-1:0] count_o
);

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni)
            count_o <= '0;
        else if (en_i) begin
            if (dir_i == UP)
                count_o <= count_o + 1;
            else
                count_o <= count_o - 1;
        end
    end

endmodule
