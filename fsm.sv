module highway_fsm (
	input clk,    // Clock
	// input clk_en, // Clock Enable
	input rst_n,  // Asynchronous reset active low
	input car,
	input enable_h,
	input Timeout,
	input timeout,

	output start_h,
	output enable_n,
	output [2:0] light,		// g y r
);
	// synopsys enum state_info
	parameter [2:0] green_h = 3'b100,
					yellow_h = 3'b010,
					red_h = 3'b001;

	reg [2:0] 	CurrentState;
	reg [2:0]	NextState;

	assign light = CurrentState; 

	always_comb 	// = always @(*) but smarter
	begin : proc_fsm
		NextState = CurrentState;
		start_h = 0; 	// default value to avoid latch
		enable_n = 0;
		case (CurrentState)
			green_h: begin
				if (Timeout & car)  begin
					NextState = yellow_h; 
					start_h = 1;
				end
			end 
			yellow_h: begin
				if (timeout) begin
					NextState = red_h;
					enable_n = 1;
				end
			end
			red_h: begin
				if (enable_h) begin
					NextState = green_h; 
					start_h = 1;
				end
			end 
		endcase
	end // proc_fsm

	always_ff @(posedge clk or negedge rst_n) begin : proc_ff_state
		if(~rst_n) 
		begin
			CurrentState <= green_h;
		end 
		else
		begin
			CurrentState <= NextState ;
		end
	end
endmodule : highway_fsm

module countryroad_fsm (
	input clk,    // Clock
	// input clk_en, // Clock Enable
	input rst_n,  // Asynchronous reset active low
	input car,
	input enable_n,
	input Timeout,
	input timeout,

	output start_n,
	output enable_h,
	output [2:0] light,		// g y r
	
);
	// synopsys enum state_info
	parameter [2:0] green_h = 3'b100,
					yellow_h = 3'b010,
					red_h = 3'b001;

	reg [2:0] 	CurrentState;
	reg [2:0]	NextState;

	assign light = CurrentState; 

	always_comb 	// = always @(*) but smarter
	begin : proc_fsm
		NextState = CurrentState;
		start_n = 0; 	// default value to avoid latch
		enable_h = 0;
		case (CurrentState)
			green_h: begin
				if (Timeout)  begin
					NextState = yellow_h; 
					start_n = 1;
				end
			end 
			yellow_h: begin
				if (timeout) begin
					NextState = red_h;
					enable_h = 1;
				end
			end
			red_h: begin
				if (enable_n) begin
					NextState = green_h; 
					start_n = 1;
				end
			end 
		endcase
	end // proc_fsm

	always_ff @(posedge clk or negedge rst_n) begin : proc_ff_state
		if(~rst_n) 
		begin
			CurrentState <= red_h;
		end 
		else
		begin
			CurrentState <= NextState ;
		end
	end

endmodule : countryroad_fsm