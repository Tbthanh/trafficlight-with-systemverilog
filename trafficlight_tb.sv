module trafficlight_tb ();
	reg t_clk, t_rst_n;
	reg stim_car;
	wire [5:0]out_light;
	reg [5:0]correct_light;

	//initial keyword: execute the block only once
	initial //initialize clock
	begin
		t_clk = 0;
		forever t_clk = #5 ~t_clk; //clock switches value every 5ns
	end

	trafficlight dut(.clk(t_clk), .rst_n(t_rst_n), .car(stim_car), .light(out_light));
	initial $monitor ("t = %t, car = %b, light = %b\n", $time, stim_car, out_light);
	always @(out_light or correct_light)
	begin
		if (out_light!=correct_light) 
			$display("t = %t FAILED, car = %b, light = %b, correct = %b\n", $time, stim_car, out_light, correct_light);
	end

	initial //direct input generation
	begin
		t_rst_n = 1;
		#10 t_rst_n = 0;

		#10 t_rst_n = 1;
		stim_car = 0; 
		correct_light = 6'b0;

		#5 stim_car = 0; correct_light = 6'b001100;
		#2_499_999_974 stim_car = 0; correct_light = 6'b001100;
		#5 stim_car = 0; correct_light = 6'b001100;
		#5 stim_car = 1;

	end

endmodule : trafficlight_tb