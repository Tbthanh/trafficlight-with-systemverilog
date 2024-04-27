module timer #( parameter count_g 	= 26'd249_999_999,	// 5s 
				parameter count_y	= 26'd49_999_999)	// 1s
(	input clk,    	// Clock
	input rst_n,  	// Asynchronous reset active low

	input enable_n, 
	input enable_h,
	input start,		// 0 is green, 1 is yellow

	output Timeout,
	output timeout
);
	reg [26:0] count;

	// reg load;
	// assign load = (start & (enable_h | enable_n));


	always @(posedge clk or negedge rst_n) begin
	 	if(~rst_n) begin
	 		count <= count_g;
	 		Timeout <= 0;
	 		timeout <= 0;
	 	end else begin
	 		 
	 	end
	 end

endmodule : timer