module timer #( parameter count_g 	= 26'd99,	// 5s is 26'd249_999_999
				parameter count_y	= 26'd49)	// 1s is 26'd49_999_999
(	input clk,    	// Clock
	input rst_n,  	// Asynchronous reset active low

	input car,
	input start,		// 0 is green, 1 is yellow
	input logic start_y,
	input logic start_g,

	output logic Timeout,
	output logic timeout
);
	reg [26:0] count;
	
	always @(posedge clk or negedge rst_n) begin
	 	if(~rst_n) begin
	 		Timeout <= 0;	
	 		timeout <= 0;
	 		count <= count_g;
	 	end else begin
	 		if (count != 0) begin
	 			count <= count - 1;
	 		end else begin
	 			if (start_y) begin
	 				Timeout <= 1;
	 				count <= count_y;
	 			end else if (start_g) begin
	 				timeout <= 1;
	 				count <= count_g;
	 			end else begin
	 				count <= count_g;
	 			end
	 		end

	 	end
	end

endmodule : timer