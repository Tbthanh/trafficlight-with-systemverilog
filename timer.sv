module timer #( parameter count_g 	= 26'd249_999_999,	// 5s 
				parameter count_y	= 26'd49_999_999)	// 1s
(	input clk,    	// Clock
	input rst_n,  	// Asynchronous reset active low

	input enable_n, 
	input enable_h,
	input start,		// 0 is green, 1 is yellow

	output reg Timeout,
	output reg timeout
);
	reg [26:0] count;
	reg count_to;	// to decicde which count_x
	
	always_comb begin : proc_counto
		if (~rst_n) begin
			count_to = 1;
		end else if (start) begin
			count_to = count_to + 1;
		end
	end

	always @(start | Timeout) begin : proc_assign_count_value
		if(count_to) begin
			 count <= count_g;
		end else begin
			 count <= count_y;
		end
	end

	always @(posedge clk or negedge rst_n) begin
	 	if(~rst_n) begin
	 		Timeout <= 0;
	 		timeout <= 0;
	 	end else begin
	 		if (count != 0) begin
	 			count <= count - 1;
	 		end else begin
	 			if (count_to) begin
	 				Timeout = 1;
	 			end else begin
	 				timeout = 1;
	 			end
	 		end

	 	end
	end

endmodule : timer