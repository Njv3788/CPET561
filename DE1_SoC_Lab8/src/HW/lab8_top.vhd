
library ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY lab8_top IS
  PORT(
    CLOCK_50         : IN  std_logic;                      -- 50 Mhz system clock
    KEY              : IN  std_logic_vector( 3 downto 0); 
    filter_en        : IN  std_logic;
    data_in          : IN  std_logic_vector(15 downto 0);
    data_out         : OUT std_logic_vector(15 downto 0)
  );
END ENTITY lab8_top;

ARCHITECTURE rtl OF lab8_top IS
  COMPONENT filter_base_16_tap IS
    GENERIC(
      bit_depth        :integer := 16
    );
    PORT(
      clk              : IN  std_logic;                      -- 50 Mhz system clock
      reset            : IN  std_logic; 
      filter_en        : IN  std_logic;
      data_in          : IN  std_logic_vector(bit_depth-1 downto 0);
      data_out         : OUT std_logic_vector(bit_depth-1 downto 0)
    );
  END COMPONENT filter_base_16_tap;
BEGIN

 filter : filter_base_16_tap
    generic map(
      bit_depth  => 16
    )
    port map(
      clk              => CLOCK_50,                     -- 50 Mhz system clock
      reset            => KEY(0), 
      filter_en        => filter_en,
      data_in          => data_in,
      data_out         => data_out
    );
  
END rtl;