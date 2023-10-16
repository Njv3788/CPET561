	component nios_system is
		port (
			clk_clk       : in  std_logic                    := 'X';             -- clk
			reset_reset_n : in  std_logic                    := 'X';             -- reset_n
			key_0_export  : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			led_0_export  : out std_logic_vector(7 downto 0)                     -- export
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk       => CONNECTED_TO_clk_clk,       --   clk.clk
			reset_reset_n => CONNECTED_TO_reset_reset_n, -- reset.reset_n
			key_0_export  => CONNECTED_TO_key_0_export,  -- key_0.export
			led_0_export  => CONNECTED_TO_led_0_export   -- led_0.export
		);

