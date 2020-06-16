// 32X32 Multiplier FSM
module mult32x32_fast_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    input logic a_msb_is_0,       // Indicates MSB of operand A is 0
    input logic b_msw_is_0,       // Indicates MSW of operand B is 0
    output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);

// Put your code here
// ------------------
	typedef enum { idle, clear, b_w0_a_by0, b_w0_a_by1, b_w0_a_by2, b_w0_a_by3, 
	b_w1_a_by0, b_w1_a_by1, b_w1_a_by2} sm_type;
	sm_type current_state;
	sm_type next_state;
	
	always_ff @(posedge clk, posedge reset) begin
		if(reset == 1'b1) begin
			current_state <=idle;
		end
		else begin
			current_state<=next_state;
		end
	end
	
	always_comb begin
		next_state=current_state;
		busy= 1'b1;
		a_sel=2'b00;
		b_sel=1'b0;
		shift_sel=3'b010;
		upd_prod=1'b1;
		clr_prod=1'b0;
		case(current_state)
		idle: begin
			busy=1'b0;
			if(start==1'b1)begin
				next_state= clear;
				clr_prod=1'b1;
			end
			else begin
				upd_prod=1'b0;
			end
		end
		clear: begin 
			next_state = b_w0_a_by0;
			shift_sel=3'b000;
		end
		b_w0_a_by0: begin
			next_state = b_w0_a_by1;
			a_sel=2'b01;
			shift_sel=3'b001;
		end
		b_w0_a_by1: begin
			a_sel=2'b10;
			if(b_msw_is_0==1'b0&&a_msb_is_0) begin
				next_state = b_w0_a_by3;
			end
			else if(b_msw_is_0&&a_msb_is_0)begin
				next_state = idle;
			end
			else begin
				next_state = b_w0_a_by2;
			end
		end
		b_w0_a_by2: begin
			a_sel=2'b11;
				shift_sel=3'b011;
			if(b_msw_is_0) begin
				next_state=idle;
			end
			else begin
				next_state = b_w0_a_by3;
			end
		end
		b_w0_a_by3:begin
			next_state = b_w1_a_by0;
			b_sel=1'b1;
		end
		b_w1_a_by0: begin
			next_state = b_w1_a_by1;
			b_sel=1'b1;
			a_sel=2'b01;
			shift_sel=3'b011;
		end
		b_w1_a_by1: begin
			b_sel=1'b1;
			a_sel=2'b10;
			shift_sel=3'b100;
			if(a_msb_is_0) begin
				next_state = idle;
			end
			else begin
				next_state=b_w1_a_by2;
			end
		end
		b_w1_a_by2: begin
			next_state = idle;
			b_sel = 1'b1;
			a_sel = 2'b11;
			shift_sel = 3'b101;
		end
		endcase 
	end

// End of your code

endmodule
