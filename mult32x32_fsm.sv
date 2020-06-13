// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
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
			next_state = b_w0_a_by2;
			a_sel=2'b10;
		end
		b_w0_a_by2: begin
			next_state = b_w0_a_by3;
			a_sel=2'b11;
			shift_sel=3'b_011;
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
			next_state = b_w1_a_by2;
			b_sel=1'b1;
			a_sel=2'b10;
			shift_sel=3'b100;
		end
		b_w1_a_by2: begin
			next_state = idle;
			busy = 1'b0;
			b_sel = 1'b1;
			a_sel = 2'b11;
			shift_sel = 3'b101;
		end
		endcase 
	end
// End of your code

endmodule
