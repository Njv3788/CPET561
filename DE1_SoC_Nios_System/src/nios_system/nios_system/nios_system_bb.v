
module nios_system (
	clk_clk,
	hex_0_export,
	reset_reset_n,
	switches_export,
	keys_export);	

	input		clk_clk;
	output	[6:0]	hex_0_export;
	input		reset_reset_n;
	input	[7:0]	switches_export;
	input	[3:0]	keys_export;
endmodule
