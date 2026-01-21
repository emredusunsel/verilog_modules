
import multiplier_pkg::*;

module tb_multiplier;

    logic                   clk_i, rst_ni;
    logic   [WIDTH-1:0]     A_i, B_i;
    logic                   start_i;
    logic   [2*WIDTH-1:0]   result_o;
    logic                   busy_o, done_o;

    multiplier dut (
        .clk_i      (clk_i),
        .rst_ni     (rst_ni),
        .A_i        (A_i),
        .B_i        (B_i),
        .start_i    (start_i),
        .result_o   (result_o),
        .busy_o     (busy_o),
        .done_o     (done_o)
    );

    initial clk_i = 0;
    always #5 clk_i = ~clk_i;

    logic   [2*WIDTH-1:0]   expected_result;

    task automatic mult();
        begin
            A_i = $urandom;
            B_i = $urandom;
            expected_result = A_i * B_i;
            @(posedge clk_i);
            start_i = 1;
            @(posedge clk_i);
            start_i = 0;
            wait(done_o);
            if (result_o == expected_result) begin
                $display("TRUE");
            end else begin
                $display("FALSE");
            end
            @(posedge clk_i);
        end
    endtask

    initial begin
        rst_ni = 0;
        start_i = 0;
        #10;
        rst_ni = 1;
        #50;
        repeat(20) begin
            mult();
        end
        #200;
        $finish;
    end

endmodule
