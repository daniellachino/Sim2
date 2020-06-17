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
logic [7:0] mx_1_out;
logic [15:0] mx_2_out;
logic [23:0] mult_out;
logic [63:0] shifter_out;
logic [63:0] adder_out;
always_ff @(posedge clk, posedge reset) begin
    if (upd_prod) begin
        product <= adder_out;
    end if (clr_prod || reset) begin
        product <=0;
    end
end

always_comb begin
    case(a_sel) 
    0:  mx_1_out = a[7:0];
    1:  mx_1_out = a[15:8];
    2:  mx_1_out = a[23:16];
    3:  mx_1_out = a[31:24];
    endcase
    case (b_sel)
    0:  mx_2_out = b[15:0];
    1:  mx_2_out = b[31:16];
    endcase
    mult_out = mx_1_out * mx_2_out;
    case(shift_sel)
    0: shifter_out = mult_out;
    1: shifter_out = mult_out << 8;
    2: shifter_out = mult_out << 16;
    3: shifter_out = mult_out << 24;
    4: shifter_out = mult_out << 32;
    5: shifter_out = mult_out << 40;
    default: shifter_out = 0;
    endcase
    adder_out = shifter_out+product;
    
end

// End of your code

endmodule
