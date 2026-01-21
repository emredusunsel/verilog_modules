
import multiplier_pkg::*;

module multiplier (
    input   logic                   clk_i,
    input   logic                   rst_ni,
    input   logic   [WIDTH-1:0]     A_i,
    input   logic   [WIDTH-1:0]     B_i,
    input   logic                   start_i,
    output  logic   [2*WIDTH-1:0]   result_o,
    output  logic                   busy_o,
    output  logic                   done_o
);

    logic   [2*WIDTH-1:0]           multiplicand_reg;
    logic   [WIDTH-1:0]             multiplier_reg;
    logic   [2*WIDTH-1:0]           acc_reg;
    logic   [$clog2(WIDTH+1)-1:0]   count_reg;
    state_t state;

    always_ff @(posedge clk_i or negedge rst_ni) begin : fsm
        if (!rst_ni) begin
            count_reg           <= '0;
            done_o              <= 0;
            result_o            <= '0;
            state               <= IDLE;
        end else begin
            done_o  <= 0;
            case (state)
                IDLE: begin
                    acc_reg             <= '0;
                    if (start_i) begin
                        count_reg                   <= '0;
                        multiplicand_reg            <= {{WIDTH{1'b0}}, A_i};
                        multiplier_reg              <= B_i;
                        state                       <= RUN;
                    end
                end

                RUN: begin
                    if (count_reg < WIDTH) begin
                        if (multiplier_reg[0] == 1) begin
                            acc_reg <= acc_reg + multiplicand_reg;
                        end
                        multiplicand_reg    <= multiplicand_reg << 1;
                        multiplier_reg      <= multiplier_reg >> 1;
                        count_reg   <= count_reg + 1;
                    end else begin
                        state       <= DONE;
                    end
                end

                DONE: begin
                    done_o      <= 1;
                    result_o    <= acc_reg;
                    state       <= IDLE;
                end

                default: ;
            endcase
        end
    end

    assign busy_o = (state == RUN);

endmodule
