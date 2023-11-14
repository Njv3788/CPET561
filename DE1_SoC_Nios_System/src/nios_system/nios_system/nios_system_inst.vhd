	component nios_system is
		port (
			avalon_bridge_0_acknowledge : in  std_logic                     := 'X';             -- acknowledge
			avalon_bridge_0_irq         : in  std_logic                     := 'X';             -- irq
			avalon_bridge_0_address     : out std_logic_vector(10 downto 0);                    -- address
			avalon_bridge_0_bus_enable  : out std_logic;                                        -- bus_enable
			avalon_bridge_0_byte_enable : out std_logic_vector(1 downto 0);                     -- byte_enable
			avalon_bridge_0_rw          : out std_logic;                                        -- rw
			avalon_bridge_0_write_data  : out std_logic_vector(15 downto 0);                    -- write_data
			avalon_bridge_0_read_data   : in  std_logic_vector(15 downto 0) := (others => 'X'); -- read_data
			clk_clk                     : in  std_logic                     := 'X';             -- clk
			reset_reset_n               : in  std_logic                     := 'X';             -- reset_n
			avalon_bridge_1_acknowledge : in  std_logic                     := 'X';             -- acknowledge
			avalon_bridge_1_irq         : in  std_logic                     := 'X';             -- irq
			avalon_bridge_1_address     : out std_logic_vector(10 downto 0);                    -- address
			avalon_bridge_1_bus_enable  : out std_logic;                                        -- bus_enable
			avalon_bridge_1_byte_enable : out std_logic_vector(1 downto 0);                     -- byte_enable
			avalon_bridge_1_rw          : out std_logic;                                        -- rw
			avalon_bridge_1_write_data  : out std_logic_vector(15 downto 0);                    -- write_data
			avalon_bridge_1_read_data   : in  std_logic_vector(15 downto 0) := (others => 'X')  -- read_data
		);
	end component nios_system;

	u0 : component nios_system
		port map (
			avalon_bridge_0_acknowledge => CONNECTED_TO_avalon_bridge_0_acknowledge, -- avalon_bridge_0.acknowledge
			avalon_bridge_0_irq         => CONNECTED_TO_avalon_bridge_0_irq,         --                .irq
			avalon_bridge_0_address     => CONNECTED_TO_avalon_bridge_0_address,     --                .address
			avalon_bridge_0_bus_enable  => CONNECTED_TO_avalon_bridge_0_bus_enable,  --                .bus_enable
			avalon_bridge_0_byte_enable => CONNECTED_TO_avalon_bridge_0_byte_enable, --                .byte_enable
			avalon_bridge_0_rw          => CONNECTED_TO_avalon_bridge_0_rw,          --                .rw
			avalon_bridge_0_write_data  => CONNECTED_TO_avalon_bridge_0_write_data,  --                .write_data
			avalon_bridge_0_read_data   => CONNECTED_TO_avalon_bridge_0_read_data,   --                .read_data
			clk_clk                     => CONNECTED_TO_clk_clk,                     --             clk.clk
			reset_reset_n               => CONNECTED_TO_reset_reset_n,               --           reset.reset_n
			avalon_bridge_1_acknowledge => CONNECTED_TO_avalon_bridge_1_acknowledge, -- avalon_bridge_1.acknowledge
			avalon_bridge_1_irq         => CONNECTED_TO_avalon_bridge_1_irq,         --                .irq
			avalon_bridge_1_address     => CONNECTED_TO_avalon_bridge_1_address,     --                .address
			avalon_bridge_1_bus_enable  => CONNECTED_TO_avalon_bridge_1_bus_enable,  --                .bus_enable
			avalon_bridge_1_byte_enable => CONNECTED_TO_avalon_bridge_1_byte_enable, --                .byte_enable
			avalon_bridge_1_rw          => CONNECTED_TO_avalon_bridge_1_rw,          --                .rw
			avalon_bridge_1_write_data  => CONNECTED_TO_avalon_bridge_1_write_data,  --                .write_data
			avalon_bridge_1_read_data   => CONNECTED_TO_avalon_bridge_1_read_data    --                .read_data
		);

