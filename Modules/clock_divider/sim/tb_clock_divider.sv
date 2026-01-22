
import clock_divider_pkg::*;

module tb_clock_divider;

    logic   clk_i, rst_ni, enable_i, clk_div_o;

    clock_divider dut (
        .clk_i      (clk_i),
        .rst_ni     (rst_ni),
        .enable_i   (enable_i),
        .clk_div_o  (clk_div_o)
    );

    initial clk_i = 0;
    always #5 clk_i = ~clk_i;

    initial begin
        if (DIV < 2 || (DIV % 2 != 0)) begin
            $error("DIV must be even and >= 2");
            $finish;
        end
        rst_ni      = 0;
        enable_i    = 0;
        #10;
        rst_ni      = 1;
        #50;
        enable_i    = 1;
        #1000;
        $finish;
    end

endmodule
