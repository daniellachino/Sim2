// 32X32 Multiplier test template
module mult32x32_TB;

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

logic error = 0;
logic reset_error =0;
always_ff @( posedge clk) begin
	reset_error <=0;
	if (reset && (product != 0)) begin
		reset_error <= 1;
	end

end

initial begin
	clk = 1;
    repeat(10000) begin
		reset = 1;
		start = 0;
		repeat($urandom_range(4,1)) begin
			@(posedge clk);
		end
		reset = 0;
		a = $urandom_range(0'hFFFFFFFF,0);
		b = $urandom_range(0'hFFFFFFFF,0);
		@(posedge clk);
		start = 1;
		@(posedge clk);
		start =0;
		@(negedge busy);
		if (product != a*b) begin
			error = 1;
		end

	end
end


endmodule
