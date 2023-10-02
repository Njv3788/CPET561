-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity servo_controller_tb is
end servo_controller_tb;

architecture arch of servo_controller_tb is
  
  TYPE ram_type IS ARRAY (1 DOWNTO 0) OF std_logic_vector (31 DOWNTO 0);
  TYPE math_type IS ARRAY (1 DOWNTO 0) OF std_logic_vector (32 DOWNTO 0);
  
  component servo_controller is
    port(
      clk              : IN std_logic;                      -- 50 Mhz system clock
      write            : IN std_logic;                      -- active high write enable
      reset_n          : IN std_logic;                      -- active low system reset
      address          : IN std_logic_vector(0 DOWNTO 0);   --address of register to be written to (from CPU)
      writedata        : IN std_logic_vector(31 DOWNTO 0);  --data from the CPU to be stored in the component
      irq              : OUT std_logic;
      pwm              : OUT std_logic
  );end component; 
  
  signal output           : std_logic;
  constant period         : time := 20ns;
  signal clk              : std_logic := '0';
  signal write            : std_logic := '0';
  signal reset            : std_logic := '0';
  signal ram              : ram_type := (x"00000008",x"00000002");
  signal math             : math_type ;
  signal address          : std_logic_vector(0 DOWNTO 0)  := "0";
  signal writedata        : std_logic_vector(31 DOWNTO 0);
  signal irq              : std_logic;
begin
  writedata <= ram(to_integer(unsigned(address)));
  math(0) <= std_logic_vector(unsigned('0' & ram(0)) + 1);
  math(1) <= std_logic_vector(unsigned('0' & ram(1)) - 1);
  
  -- clock process
  clock: process
    begin
      clk <= not clk;
      wait for period/2;
  end process; 
  
  -- reset process
  async_reset: process
    begin
      wait for 2 * period;
      reset <= '1';
      wait;
  end process; 
  
  stimulus: process(irq)
    begin
      if(irq = '1') then
        write <= '1';
        address <= not address;
        if(not (ram(1) = ram(0))) then
          ram(to_integer(unsigned(address))) <= math(to_integer(unsigned(address)))(31 DOWNTO 0);
        end if;
      else
        write <= '0';
      end if;
  end process;
  
  uut: servo_controller
    port map(    
      clk              => clk,
      reset_n          => reset,
      write            => write,
      address          => address,
      writedata        => writedata,
      irq              => irq 
    );
end arch;
