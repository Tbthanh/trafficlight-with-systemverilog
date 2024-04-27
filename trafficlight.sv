module trafficlight (
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input car,

	output [5:0]light // {countryroad(g,y,r), highway(g,y,r)}
);
	wire enable_h, enable_n, timeout, Timeout, start_n, start_h;

	highway_fsm		h_fsm (	.clk(clk), .car(car), .rst_n(rst_n), 
							.enable_h(enable_h), 
							.Timeout(Timeout), 
							.timeout(timeout), 
							.start_h(start_h), 
							.enable_n(enable_n), 
							.light(light[2:0]));

	countryroad_fsm	n_fsm(	.clk(clk), .car(car), .rst_n(rst_n),
							.enable_n(enable_n),
							.Timeout(Timeout),
							.timeout(timeout),
							.start_n(start_n),
							.enable_h(enable_h),
							.light(light[5:3]));

	reg start;
	assign start = start_h | start_n;

	timer timer(.clk(clk), .rst_n(rst_n), 
				.start(start), 
				.Timeout(Timeout), 
				.timeout(timeout));
	
endmodule : trafficlight