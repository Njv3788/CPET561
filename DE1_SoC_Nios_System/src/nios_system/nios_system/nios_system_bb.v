
module nios_system (
	clk_clk,
	leds_export,
	reset_reset_n,
	switches_export,
	hex_0_export,
	keys_export);	

	input		clk_clk;
	output	[7:0]	leds_export;
	input		reset_reset_n;
	input	[7:0]	switches_export;
	output	[6:0]	hex_0_export;
	input	[3:0]	keys_export;
endmodule
