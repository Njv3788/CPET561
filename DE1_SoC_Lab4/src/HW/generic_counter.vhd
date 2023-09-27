--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY generic_counter IS
  GENERIC(
    bits             : integer := 32
    );
  PORT(
    clk              : IN  std_logic;                      -- 50 Mhz system clock
    reset_n          : IN  std_logic;                      -- active low system reset
    enable           : IN  std_logic;
    max_count        : IN  std_logic_vector(bits-1 downto 0);
    blip             : OUT std_logic;
    );
END ENTITY generic_counter;

ARCHITECTURE rtl OF generic_counter IS
  SIGNAL count_sig          : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL next_count         : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL plus_one           : std_logic_vector(bits   downto 0):= (others => '0');
BEGIN
  plus_one <= std_logic_vector(unsigned('0' & count_sig) + 1);
  count_reg : PROCESS(clk,reset_n)
  BEGIN
    IF(reset_n = 0) THEN
      count_sig <= (others => '0')
    ELSIF(RISING_EDGE(CLK) THEN
      count_sig <= next_count;
    END IF;
  END PROCESS;
  
  set:PROCESS(count_sig,max_count)
  BEGIN
    IF(count_sig >= max_count) THEN
      next_count <= (others => '0')
    ELSE 
      next_count <= plus_one(bits-1 downto 0);
    END IF;
  END PROCESS;
  
  PROCESS(count_sig,max_count)
  BEGIN
    IF(count_sig >= max_count) THEN
      blip <= '1';
    ELSE 
      blip <= '0';
    END IF;
  END PROCESS;
END ARCHITECTURE rtl;