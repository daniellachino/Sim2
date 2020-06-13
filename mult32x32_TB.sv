module mult32x32_TB;

	logic clk;
	logic reset;
	logic start;
	
	mult32x32_fsm uut(.clk(clk),.reset(reset),.start(start));
	
	always begin 
		#5 clk=~clk;
	end;
	
	initial begin
		clk=1'b0;
		reset=1'b1;
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
			start =1;
		#10
		start=0;
		repeat(11) begin
			@(posedge clk);
		end
	end
endmodule