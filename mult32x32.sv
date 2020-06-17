// 32X32 Iterative Multiplier template
module mult32x32 (
    input logic clk,            // Clock
    input logic reset,          // Reset
    input logic start,          // Start signal
    input logic [31:0] a,       // Input a
    input logic [31:0] b,       // Input b
    output logic busy,          // Multiplier busy indication
    output logic [63:0] product // Miltiplication product
);

// Put your code here
// ------------------
logic [1:0] a_sel;
logic b_sel;
logic [2:0] shift_sel;
logic upd_prod;
logic clr_prod;
mult32x32_fsm fsm(.clk(clk),.reset(reset),.start(start),
                .a_sel(a_sel),.b_sel(b_sel),.shift_sel(shift_sel),
                .upd_prod(upd_prod),.clr_prod(clr_prod),.busy(busy));
mult32x32_arith arith(
     clk,             // Clock
     reset,           // Reset
     a,        // Input a
     b,        // Input b
     a_sel,     // Select one byte from A
     b_sel,           // Select one 2-byte word from B
     shift_sel, // Select output from shifters
     upd_prod,        // Update the product register
     clr_prod,        // Clear the product register
     product  // Miltiplication product
);
// End of your code

endmodule
