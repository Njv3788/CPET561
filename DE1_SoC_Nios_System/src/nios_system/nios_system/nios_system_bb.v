
module nios_system (
	clk_clk,
	reset_reset_n,
	key_0_export,
	led_0_export);	

	input		clk_clk;
	input		reset_reset_n;
	input	[3:0]	key_0_export;
	output	[7:0]	led_0_export;
endmodule
