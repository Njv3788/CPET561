--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY lab4_top IS
  PORT(
    clk              : IN  std_logic;                      -- 50 Mhz system clock
    reset_n          : IN  std_logic;                      -- active low system reset
    GPIO_0           : OUT std_logic_vector(35 downto 0)
    );
END ENTITY lab4_top;

ARCHITECTURE rtl OF lab4_top IS

  COMPONENT servo_controller IS
    PORT(
      clk              : IN  std_logic;                      -- 50 Mhz system clock
      reset_n          : IN  std_logic;                      -- active low system reset
      write            : IN  std_logic;                      -- active high write enable
      address          : IN  std_logic_vector(0 DOWNTO 0);   -- address of register to be written to (from CPU)
      writedata        : IN  std_logic_vector(31 DOWNTO 0);  -- data from the CPU to be stored in the component
      irq              : OUT std_logic;
      pwm              : OUT std_logic
      );
  END COMPONENT servo_controller;
  
  SIGNAL write            : std_logic := '0';
  SIGNAL address          : std_logic_vector(0 DOWNTO 0)  := "0";
  SIGNAL writedata        : std_logic_vector(31 DOWNTO 0) := x"0000C350";
  SIGNAL address_sum      : std_logic_vector(1 downto 0)  := "00";
  SIGNAL irq              : std_logic;

BEGIN
  
  stimulus: process(irq)
    begin
      if(irq = '1') then
        write <= '1';
      else
        write <= '0';
      end if;
  end process;
  
  uut: servo_controller
    port map(    
      clk              => clk,
      reset_n          => reset_n,
      write            => write,
      address          => address,
      writedata        => writedata,
      irq              => irq,
      pwm              => GPIO_0(0)
    );
END ARCHITECTURE rtl;