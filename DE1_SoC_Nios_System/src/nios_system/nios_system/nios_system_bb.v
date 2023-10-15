
module nios_system (
	clk_clk,
	hex_0_export,
	hex_1_export,
	hex_2_export,
	hex_3_export,
	hex_4_export,
	hex_5_export,
	key_0_export,
	reset_reset_n,
	servo_controller_pwm,
	switch_0_export);	

	input		clk_clk;
	output	[6:0]	hex_0_export;
	output	[6:0]	hex_1_export;
	output	[6:0]	hex_2_export;
	output	[6:0]	hex_3_export;
	output	[6:0]	hex_4_export;
	output	[6:0]	hex_5_export;
	input	[3:0]	key_0_export;
	input		reset_reset_n;
	output		servo_controller_pwm;
	input	[7:0]	switch_0_export;
endmodule
