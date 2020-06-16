module mult32x32_fast_fsm_TB;

	logic clk;
	logic reset;
	logic start;
	logic a_msb_is_0;
	logic b_msw_is_0;
	
	mult32x32_fast_fsm uut(.clk(clk),.reset(reset),.start(start),
	.a_msb_is_0(a_msb_is_0),.b_msw_is_0(b_msw_is_0));
	
	always begin 
		#5 clk=~clk;
	end;
	
	initial begin
		clk=1'b0;
		reset=1'b1;
		a_msb_is_0=1'b0;
		b_msw_is_0=1'b0;
		@(posedge clk);
		#10
		reset=1'b0;
		#10
		start =1;
		#10
		start=0;
		repeat(11) begin
			@(posedge clk);
		end
		a_msb_is_0=1'b1;
		b_msw_is_0=1'b0;
			start =1;
		#10
		start=0;
		repeat(11) begin
			@(posedge clk);
		end
		a_msb_is_0=1'b0;
		b_msw_is_0=1'b1;
			start =1;
		#10
		start=0;
		repeat(11) begin
			@(posedge clk);
		end
		a_msb_is_0=1'b1;
		b_msw_is_0=1'b1;
			start =1;
		#10
		start=0;
		repeat(11) begin
			@(posedge clk);
		end
	end
endmodule