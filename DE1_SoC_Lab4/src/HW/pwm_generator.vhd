--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY pwm_generator IS
  GENERIC(
    bits             : integer := 32
    );
  PORT(
    clk              : IN  std_logic;                      -- 50 Mhz system clock
    reset_n          : IN  std_logic;                      -- active low system reset
    enable           : IN  std_logic;
    pulse_period     : IN  std_logic_vector(bits-1 downto 0);
    pulse_width      : IN  std_logic_vector(bits-1 downto 0);
    pulse            : OUT std_logic;
    pwm              : OUT std_logic
    );
END ENTITY pwm_generator;

ARCHITECTURE rtl OF pwm_generator IS
  SIGNAL count_sig          : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL next_count         : std_logic_vector(bits-1 downto 0):= (others => '0');
  SIGNAL plus_one           : std_logic_vector(bits   downto 0):= (others => '0');
BEGIN
  plus_one <= std_logic_vector(unsigned('0' & count_sig) + 1);
  count_reg : PROCESS(clk,reset_n,count_sig)
  BEGIN
    IF(reset_n = '0') THEN
      count_sig <= (others => '0');
    ELSIF(RISING_EDGE(CLK)) THEN
      IF(enable = '1') THEN
        count_sig <= next_count;
      ELSE
        count_sig <= count_sig;
      END IF;
    END IF;
  END PROCESS;
  
  count_logic: PROCESS(count_sig,pulse_period,plus_one)
  BEGIN
    IF(count_sig >= pulse_period) THEN
      next_count <= (others => '0');
    ELSE 
      next_count <= plus_one(bits-1 downto 0);
    END IF;
  END PROCESS;
  
  pluse_logic :PROCESS(count_sig,pulse_period)
  BEGIN
    IF(reset_n = '0') THEN
      pulse <= '0';
    ELSIF(count_sig >= pulse_period) THEN
      pulse <= '1';
    ELSE 
      pulse <= '0';
    END IF;
  END PROCESS;
  
  pwm_logic :PROCESS(count_sig,pulse_width)
  BEGIN
    IF(reset_n = '0') THEN
      pwm <= '0';
    ELSIF(count_sig > pulse_width) THEN
      pwm  <= '0';
    ELSE 
      pwm  <= '1';
    END IF;
  END PROCESS;
END ARCHITECTURE rtl;