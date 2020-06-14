// 32X32 Multiplier test template
module mult32x32_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------
mult32x32 UUT(  clk,            // Clock
                reset,          // Reset
                start,          // Start signal
                a,       // Input a
                b,       // Input b
                busy,          // Multiplier busy indication
                 product // Miltiplication product
);

always begin
    #5 clk = ~clk;
end

initial begin
    clk = 0;
    reset = 1;
    start = 0;
    #20;
    reset = 0;
    a = 314968744;
    b = 208081125;
    #5;
    start = 1;
    #5;   

end
// End of your code

endmodule
