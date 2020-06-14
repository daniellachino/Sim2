// 32X32 Multiplier arithmetic unit template
module mult32x32_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------
logic [8:0] mx_1_out;
logic [16:0] mx_2_out;
logic [24:0] mult_out;
logic [64:0] shifter_out;
logic [64:0] adder_out;
always_ff @(posedge clk, posedge reset) begin
    if (upd_prod) begin
        product <= adder_out;
    end else begin
        product <=0;
    end
    if (clr_prod) product <= 0;
end

always_comb begin
    mx_1_out = a[8*a_sel:8*(a_sel+1)];
    mx_2_out = a[16*b_sel:16*(b_sel+1)];
    mult_out = mx_1_out * mx_2_out;
    if (shift_sel <=5) begin 
    shifter_out = mult_out<<( 8* (2**shift_sel));
    end else begin
        shifter_out = 0;
    end
    adder_out = shifter_out+product;
    
end

// End of your code

endmodule
