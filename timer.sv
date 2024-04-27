module timer #( parameter count_g 	= 26'd249_999_999,	// 5s 
				parameter count_y	= 26'd49_999_999)	// 1s
(	input clk,    	// Clock
	input rst_n,  	// Asynchronous reset active low

	input car,
	input start,		// 0 is green, 1 is yellow

	output reg Timeout,
	output reg timeout
);
	reg [26:0] count;
	reg count_to;	// to decicde which count_x
	
	always @(posedge clk or negedge rst_n) begin
	 	if(~rst_n) begin
	 		Timeout <= 0;	
	 		timeout <= 0;
	 		count_to <= 1;
	 		count <= count_g;
	 	end else begin
	 		if (count != 0) begin
	 			count <= count - 1;
	 		end else begin
	 			if (count_to) begin
	 				Timeout <= 1;
	 				if (start) begin
	 					count <= count_y;
	 					count_to = count_to + 1;
	 				end else begin
	 					count <= count_g;
	 				end
	 			end else begin
	 				timeout <= 1;
	 				count <= count_g;
	 				count_to = count_to + 1;
	 			end
	 		end

	 	end
	end

endmodule : timer