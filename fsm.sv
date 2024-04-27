module highway_fsm (
	input clk,    // Clock
	input clk_en, // Clock Enable
	input rst_n,  // Asynchronous reset active low
	
);

	always_comb 	// = always @(*)
	begin : proc_fsm
		NextState = CurrentState ;
		start_h = 0; 	// default value to avoid latch
		enable_n = 0;
		case (CurrentState)
			green_h: if (Timeout)  begin
				if (car)
				begin
					NextState = yellow_h; 
					start_h = 1;
				end
				
			end 
			yellow_h: if (timeout) begin
				NextState = red_h;
				enable_n = 1;
				load <= 1; // green
			end
			red_h: if (enable_h) begin
				NextState = green_h; 
				start_h = 1;
			end 
		endcase

		
	end
endmodule : highway_fsm

module countryroad_fsm (
	input clk,    // Clock
	input clk_en, // Clock Enable
	input rst_n,  // Asynchronous reset active low
	
);

endmodule : countryroad_fsm