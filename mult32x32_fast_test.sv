// 32X32 Multiplier test template
module mult32x32_fast_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------
	mult32x32_fast uut(.clk(clk),            // Clock
					.reset(reset),          // Reset
					.start(start),          // Start signal
					.a(a),       // Input a
					.b(b),       // Input b
					.busy(busy),          // Multiplier busy indication
					.product(product) // Miltiplication product
	);

	always begin
		#5 clk = ~clk;
	end

	initial begin
		clk = 1'b1;
		reset = 1'b1;
		start = 1'b0;
		repeat(4)begin
			@(posedge clk);
		end
		reset=1'b0;
		a = 314968744;
		b = 208081125;
		repeat(1) begin
			@(posedge clk);
		end
		start=1'b1;
		repeat(1) begin
			@(posedge clk);
		end
		start=1'b0;
		repeat(8) begin
			@(posedge clk);
		end
		repeat(1) begin
			@(posedge clk);
		end
		a={{16{1'b0}},a[15:0]};
		b={{16{1'b0}},b[15:0]};
		repeat(1) begin
			@(posedge clk);
		end
		start=1'b1;
		repeat(1) begin
			@(posedge clk);
		end
		start=1'b0;
		repeat(5) begin
			@(posedge clk);
		end
	end
// End of your code

endmodule
