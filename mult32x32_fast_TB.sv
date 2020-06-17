// 32X32 Multiplier test template
module mult32x32_fast_TB;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product

// Put your code here
// ------------------
mult32x32_fast UUT(  clk,            // Clock
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
logic [63:0] sub;
int currtime;
int twonot_sum = 0,twonot_count = 0, a_sum =0, b_sum = 0, a_count = 0,b_count = 0,two_count =0, two_sum = 0;
int rpt = 1000;
assign sub = a*b-product;
initial begin
	clk = 1;
    repeat(rpt) begin
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
		currtime =$time;
		@(posedge clk);
		start =0;
		@(negedge busy);
		if (product != a*b) begin
			error = 1;
		end
		if ((a[31:24] == 0) && (b[31:16] == 0)) begin
			two_count +=1;
			two_sum += ($time -  currtime);
		end else if ((a[31:24] != 0) && (b[31:16] != 0)) begin
			twonot_count +=1;
			twonot_sum += ($time -  currtime);
		end else if (a[31:24] == 0)begin
			a_count += 1;
			a_sum += ($time - currtime);
		end else if (b[31:16] == 0)begin
			b_count += 1;
			b_sum += ($time - currtime);
		end
		
		@(posedge clk);
	end
	repeat(rpt) begin
		reset = 1;
		start = 0;
		repeat($urandom_range(4,1)) begin
			@(posedge clk);
		end
		reset = 0;
		a = $urandom_range(0'h00FFFFFF,0);
		b = $urandom_range(0'hFFFFFFFF,0);
		@(posedge clk);
		start = 1;
		currtime =$time;
		@(posedge clk);
		start =0;
		@(negedge busy);
		if (product != a*b) begin
			error = 1;
		end
		if ((a[31:24] == 0) && (b[31:16] == 0)) begin
			two_count +=1;
			two_sum += ($time -  currtime);
		end else if ((a[31:24] != 0) && (b[31:16] != 0)) begin
			twonot_count +=1;
			twonot_sum += ($time -  currtime);
		end else if (a[31:24] == 0)begin
			a_count += 1;
			a_sum += ($time - currtime);
		end else if (b[31:16] == 0)begin
			b_count += 1;
			b_sum += ($time - currtime);
		end
		
		@(posedge clk);
	end
	repeat(rpt) begin
		reset = 1;
		start = 0;
		repeat($urandom_range(4,1)) begin
			@(posedge clk);
		end
		reset = 0;
		a = $urandom_range(0'hFFFFFFFF,0);
		b = $urandom_range(0'hFFFF,0);
		@(posedge clk);
		start = 1;
		currtime =$time;
		@(posedge clk);
		start =0;
		@(negedge busy);
		if (product != a*b) begin
			error = 1;
		end
		if ((a[31:24] == 0) && (b[31:16] == 0)) begin
			two_count +=1;
			two_sum += ($time -  currtime);
		end else if ((a[31:24] != 0) && (b[31:16] != 0)) begin
			twonot_count +=1;
			twonot_sum += ($time -  currtime);
		end else if (a[31:24] == 0)begin
			a_count += 1;
			a_sum += ($time - currtime);
		end else if (b[31:16] == 0)begin
			b_count += 1;
			b_sum += ($time - currtime);
		end
		
		@(posedge clk);
	end
	repeat(rpt) begin
		reset = 1;
		start = 0;
		repeat($urandom_range(4,1)) begin
			@(posedge clk);
		end
		reset = 0;
		a = $urandom_range(0'hFFFFFF,0);
		b = $urandom_range(0'hFFFF,0);
		@(posedge clk);
		start = 1;
		currtime =$time;
		@(posedge clk);
		start =0;
		@(negedge busy);
		if (product != a*b) begin
			error = 1;
		end
		if ((a[31:24] == 0) && (b[31:16] == 0)) begin
			two_count +=1;
			two_sum += ($time -  currtime);
		end else if ((a[31:24] != 0) && (b[31:16] != 0)) begin
			twonot_count +=1;
			twonot_sum += ($time -  currtime);
		end else if (a[31:24] == 0)begin
			a_count += 1;
			a_sum += ($time - currtime);
		end else if (b[31:16] == 0)begin
			b_count += 1;
			b_sum += ($time - currtime);
		end
		
		@(posedge clk);
	end
$display("average 2 yes %d,average 2_not %d, average a %d, average b %d",two_sum/two_count ,twonot_sum/twonot_count, a_sum/a_count, b_sum/b_count);
	
end


endmodule
