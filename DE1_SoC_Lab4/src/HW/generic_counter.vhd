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
    cntrl_pin        : IN  std_logic_vector(3 downto 0);
    max_count        : IN  std_logic_vector(bits-1 downto 0);
    min_count        : IN  std_logic_vector(bits-1 downto 0);
    pulse            : OUT std_logic;
    );
END ENTITY generic_counter;

ARCHITECTURE rtl OF generic_counter IS
  SIGNAL count_sig          : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL next_count         : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL count_up           : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL count_down         : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL plus_one           : std_logic_vector(bits   downto 0):= (others => '0');
  SIGNAL minus_one          : std_logic_vector(bits   downto 0):= (others => '0');
  
  ALIAS  enable             : std_logic is cntrl_pin(0);
  ALIAS  direction          : std_logic is cntrl_pin(1);
  ALIAS  pwm_n              : std_logic is cntrl_pin(2);
  ALIAS  overflow           : std_logic is cntrl_pin(3);
BEGIN
  plus_one <= std_logic_vector(unsigned('0' & count_sig) + 1);
  minus_one <= std_logic_vector(unsigned('0' & count_sig) - 1);
  
  count_reg : PROCESS(clk,reset_n,count_sig)
  BEGIN
    IF(reset_n = '0') THEN
      count_sig <= (others => '0');
    ELSIF(RISING_EDGE(CLK)) THEN
      IF(cntrl_pin = '1') THEN
        count_sig <= next_count;
      ELSE
        count_sig <= count_sig;
      END IF;
    END IF;
  END PROCESS;
  
  
  
  
  count_up_logic:PROCESS(count_sig,max_count,plus_one)
  BEGIN
    IF(count_sig >= max_count) THEN
      count_up <= (others => '0');
    ELSE 
      count_up <= plus_one(bits-1 downto 0);
    END IF;
  END PROCESS;
  
  count_down_logic:PROCESS(count_sig,max_count,plus_one)
  BEGIN
    IF(count_sig >= max_count) THEN
      count_down <= (others => '0');
    ELSE 
      count_down <= minus_one(bits-1 downto 0);
    END IF;
  END PROCESS;
  
  PROCESS(count_sig,max_count)
  BEGIN
    IF(reset_n = '0') THEN
      pulse <= '0';
    ELSIF(count_sig >= max_count) THEN
      pulse <= '1';
    ELSE 
      pulse <= '0';
    END IF;
  END PROCESS;
  
END ARCHITECTURE rtl;