module trafficlight (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input car,

	output [5:0]light // {countryroad(g,y,r), highway(g,y,r)}
);
	logic enable_h, enable_n, timeout, Timeout, start_g_n, start_g_h, start_y_n, start_y_h;
	logic _start_g, _start_y;
	assign _start_g = start_g_n | start_g_h;
	assign _start_y = start_y_n | start_y_h;

	highway_fsm		h_fsm (	.clk(clk), .car(car), .rst_n(rst_n), 
							.enable_h(enable_h), 
							.Timeout(Timeout), 
							.timeout(timeout), 
							.start_y(start_y_h),
							.start_g (start_g_h), 
							.enable_n(enable_n), 
							.light(light[2:0]));

	countryroad_fsm	n_fsm(	.clk(clk), .car(car), .rst_n(rst_n),
							.enable_n(enable_n),
							.Timeout(Timeout),
							.timeout(timeout),
							.start_y(start_y_n),
							.start_g (start_g_n),
							.enable_h(enable_h),
							.light(light[5:3]));


	timer timer(.clk(clk), .rst_n(rst_n), 
				.start_g(_start_g),
				.start_y(_start_y), 
				.Timeout(Timeout), 
				.timeout(timeout));
	
endmodule : trafficlight