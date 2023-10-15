	component nios_system is
		port (
			clk_clk              : in  std_logic                    := 'X';             -- clk
			hex_0_export         : out std_logic_vector(6 downto 0);                    -- export
			hex_1_export         : out std_logic_vector(6 downto 0);                    -- export
			hex_2_export         : out std_logic_vector(6 downto 0);                    -- export
			hex_3_export         : out std_logic_vector(6 downto 0);                    -- export
			hex_4_export         : out std_logic_vector(6 downto 0);                    -- export
			hex_5_export         : out std_logic_vector(6 downto 0);                    -- export
			key_0_export         : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			reset_reset_n        : in  std_logic                    := 'X';             -- reset_n
			servo_controller_pwm : out std_logic;                                       -- pwm
			switch_0_export      : in  std_logic_vector(7 downto 0) := (others => 'X')  -- export
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			clk_clk              => CONNECTED_TO_clk_clk,              --              clk.clk
			hex_0_export         => CONNECTED_TO_hex_0_export,         --            hex_0.export
			hex_1_export         => CONNECTED_TO_hex_1_export,         --            hex_1.export
			hex_2_export         => CONNECTED_TO_hex_2_export,         --            hex_2.export
			hex_3_export         => CONNECTED_TO_hex_3_export,         --            hex_3.export
			hex_4_export         => CONNECTED_TO_hex_4_export,         --            hex_4.export
			hex_5_export         => CONNECTED_TO_hex_5_export,         --            hex_5.export
			key_0_export         => CONNECTED_TO_key_0_export,         --            key_0.export
			reset_reset_n        => CONNECTED_TO_reset_reset_n,        --            reset.reset_n
			servo_controller_pwm => CONNECTED_TO_servo_controller_pwm, -- servo_controller.pwm
			switch_0_export      => CONNECTED_TO_switch_0_export       --         switch_0.export
		);

