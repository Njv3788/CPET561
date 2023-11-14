
module nios_system (
	avalon_bridge_0_acknowledge,
	avalon_bridge_0_irq,
	avalon_bridge_0_address,
	avalon_bridge_0_bus_enable,
	avalon_bridge_0_byte_enable,
	avalon_bridge_0_rw,
	avalon_bridge_0_write_data,
	avalon_bridge_0_read_data,
	clk_clk,
	reset_reset_n,
	avalon_bridge_1_acknowledge,
	avalon_bridge_1_irq,
	avalon_bridge_1_address,
	avalon_bridge_1_bus_enable,
	avalon_bridge_1_byte_enable,
	avalon_bridge_1_rw,
	avalon_bridge_1_write_data,
	avalon_bridge_1_read_data);	

	input		avalon_bridge_0_acknowledge;
	input		avalon_bridge_0_irq;
	output	[10:0]	avalon_bridge_0_address;
	output		avalon_bridge_0_bus_enable;
	output	[1:0]	avalon_bridge_0_byte_enable;
	output		avalon_bridge_0_rw;
	output	[15:0]	avalon_bridge_0_write_data;
	input	[15:0]	avalon_bridge_0_read_data;
	input		clk_clk;
	input		reset_reset_n;
	input		avalon_bridge_1_acknowledge;
	input		avalon_bridge_1_irq;
	output	[10:0]	avalon_bridge_1_address;
	output		avalon_bridge_1_bus_enable;
	output	[1:0]	avalon_bridge_1_byte_enable;
	output		avalon_bridge_1_rw;
	output	[15:0]	avalon_bridge_1_write_data;
	input	[15:0]	avalon_bridge_1_read_data;
endmodule
