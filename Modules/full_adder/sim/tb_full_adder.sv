
module tb_full_adder();

    reg     in1_i;
    reg     in2_i;
    reg     c_i;
    logic    s_o;
    logic    c_o;

    full_adder dut(
        .in1_i(in1_i),
        .in2_i(in2_i),
        .c_i(c_i),
        .s_o(s_o),
        .c_o(c_o)
    );

    initial begin
        integer i;
        integer j;
        integer k;

        for (i = 0; i < 2 ; i = i + 1) begin
            for (j = 0; j < 2 ; j = j + 1 ) begin
                for (k = 0; k < 2; k = k + 1) begin
                    in1_i   = i;
                    in2_i   = j;
                    c_i     = k;
                    #20;
                end
            end
        end

        $finish;
    end

endmodule
