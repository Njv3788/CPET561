--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY lab5_top IS
  PORT(
    CLOCK_50         : IN  std_logic;                      -- 50 Mhz system clock
    KEY              : IN  std_logic_vector( 3 downto 0); 
    HEX0             : OUT std_logic_vector( 6 downto 0);
    HEX1             : OUT std_logic_vector( 6 downto 0);
    HEX2             : OUT std_logic_vector( 6 downto 0);
    HEX3             : OUT std_logic_vector( 6 downto 0);
    HEX4             : OUT std_logic_vector( 6 downto 0);
    HEX5             : OUT std_logic_vector( 6 downto 0);
    GPIO_0           : OUT std_logic_vector(35 downto 0);
    LEDR             : OUT std_logic_vector( 9 downto 0) 
    );
END ENTITY lab5_top;

ARCHITECTURE rtl OF lab5_top IS

  component nios_system is
    port (
      clk_clk              : in  std_logic                    := '0';             --              clk.clk
      hex_0_export         : out std_logic_vector(6 downto 0);                    --            hex_0.export
      hex_1_export         : out std_logic_vector(6 downto 0);                    --            hex_1.export
      hex_2_export         : out std_logic_vector(6 downto 0);                    --            hex_2.export
      hex_3_export         : out std_logic_vector(6 downto 0);                    --            hex_3.export
      hex_4_export         : out std_logic_vector(6 downto 0);                    --            hex_4.export
      hex_5_export         : out std_logic_vector(6 downto 0);                    --            hex_5.export
      key_0_export         : in  std_logic_vector(3 downto 0) := (others => '0'); --            key_0.export
      reset_reset_n        : in  std_logic                    := '0';             --            reset.reset_n
      servo_controller_pwm : out std_logic                                        -- servo_controller.pwm
    );
  end component nios_system;
  
  signal cntr : std_logic_vector(25 downto 0);
BEGIN

  --- heartbeat counter --------
  counter_proc : process (CLOCK_50) begin
    if (rising_edge(CLOCK_50)) then
      if (KEY(0) = '0') then
        cntr <= "00" & x"000000";
      else
        cntr <= cntr + ("00" & x"000001");
      end if;
    end if;
  end process counter_proc;
  LEDR(9 downto 8) <= cntr(25 downto 24);

  nios_processor : component nios_system
  port map (
    clk_clk              => CLOCK_50,
    reset_reset_n        => KEY(0),
    servo_controller_pwm => GPIO_0(0),
    hex_0_export         => HEX0,
    hex_1_export         => HEX1,
    hex_2_export         => HEX2,
    hex_3_export         => HEX3,
    hex_4_export         => HEX4,
    hex_5_export         => HEX5,
    key_0_export         => KEY
  );

END ARCHITECTURE rtl;