
module nios_system (
	clk_clk,
	key_0_export,
	led_0_export,
	reset_reset_n);	

	input		clk_clk;
	input	[3:0]	key_0_export;
	output	[7:0]	led_0_export;
	input		reset_reset_n;
endmodule
