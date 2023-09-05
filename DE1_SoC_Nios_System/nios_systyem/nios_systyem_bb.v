
module nios_systyem (
	clk_clk,
	reset_reset_n,
	switches_in_port,
	switches_out_port,
	leds_export);	

	input		clk_clk;
	input		reset_reset_n;
	input	[7:0]	switches_in_port;
	output	[7:0]	switches_out_port;
	output	[7:0]	leds_export;
endmodule
