
module tb_counter;
import counter_pkg::*;

    logic               clk_i;
    logic               rst_ni;
    logic               en_i;
    count_dir_e         dir_i;
    logic   [WIDTH-1:0] count_o;

    counter dut(
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .en_i(en_i),
        .dir_i(dir_i),
        .count_o(count_o)
    );

    initial clk_i = 0;
    always #5 clk_i = ~clk_i;

    // monitor
    initial begin
        $display(" time | rst en dir | count");
        $monitor("%4t |  %0b   %0b  %s  | 0x%0h (%0d)",
                 $time, rst_ni, en_i,
                 (dir_i==UP) ? "UP  " : "DOWN",
                 count_o, count_o);
    end

    initial begin
        // init
        rst_ni = 0;
        en_i   = 0;
        dir_i  = UP;

        #20;
        rst_ni = 1;

        $display("Counting up...");
        en_i  = 1;
        dir_i = UP;
        #100;

        $display("Counting down...");
        dir_i = DOWN;
        #100;

        $display("Counting up again...");
        dir_i = UP;
        #100;

        $display("Disable counting (hold)...");
        en_i = 0;
        #40;

        $display("Enable + count down again...");
        en_i  = 1;
        dir_i = DOWN;
        #60;

        $display("Applying reset...");
        rst_ni = 0;
        #15;
        rst_ni = 1;

        $display("Counting down after reset...");
        en_i  = 1;
        dir_i = DOWN;
        #100;

        $display("=== Simulation Done ===");
        $finish;
    end

endmodule
