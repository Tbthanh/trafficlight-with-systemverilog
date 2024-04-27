module timer #( parameter count_g 	= , 
				parameter count_y	= )
	(
	input clk,    	// Clock
	input enable_n, 
	input enable_h,
	input rst_n,  	// Asynchronous reset active low
	input start,		// 0 is green, 1 is yellow


	output Timeout,
	// output timeout
);
	reg [:] count;

	load = (start && (enable_h || enable_n));

	always_ff @(posedge clk or negedge rst_n) begin : proc_counter
	 	if(~rst_n) begin
	 		 count <= count_green;
	 		 Timeout <= 0;
	 		 // timeout <= 0;
	 	end else begin
	 		 if (load)
	 		 begin
	 		 	count <= count_to;	// how count_to
	 		 end
	 		 else if (~Timeout)
	 		 begin
	 		 	count <= count - 1;
	 		 	Timeout <= ( (count - 1) == 0 );
	 		 end
	 	end
	 end @() 

endmodule : timer