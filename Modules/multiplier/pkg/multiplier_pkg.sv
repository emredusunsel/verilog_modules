
package multiplier_pkg;
    parameter int WIDTH = 8;
    typedef enum logic [1:0] {  IDLE,
                                RUN,
                                DONE
    } state_t;
endpackage
