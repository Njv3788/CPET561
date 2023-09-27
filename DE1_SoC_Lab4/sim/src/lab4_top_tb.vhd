-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lab4_top_tb is
end lab4_top_tb;

architecture arch of lab4_top_tb is
  component lab4_top is
    port(
      clk              : IN std_logic;                      -- 50 Mhz system clock
      write            : IN std_logic;                      -- active high write enable
      reset_n          : IN std_logic;                      -- active low system reset
      address          : IN std_logic_vector(0 DOWNTO 0);   --address of register to be written to (from CPU)
      writedata        : IN std_logic_vector(31 DOWNTO 0)   --data from the CPU to be stored in the component
  );end component; 
  
  signal output           : std_logic;
  constant period         : time := 20ns;
  signal clk              : std_logic := '0';
  signal write            : std_logic := '0';
  signal reset            : std_logic := '0';
  signal address          : std_logic_vector(0 DOWNTO 0)  := "0";
  signal writedata        : std_logic_vector(31 DOWNTO 0) := "00000000000000000000000000000000";
  signal address_sum      : std_logic_vector(1 downto 0)     := "00";
begin
  
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
  
  stimulus: process
    begin
      wait for 4 * period;
      fill_regs : for i in 0 to 1 loop
        address <= address_sum(0 DOWNTO 0);
        writedata <= std_logic_vector(unsigned(to_unsigned(10000,16)) * (i+1));
        write <= '1';
        wait for period;
        write <= '0';
        address_sum <= std_logic_vector(unsigned('0' & address) + 1);
        wait for period;
      end loop;
      wait;
  end process;
  
  uut: lab4_top 
    port map(    
      clk              => clk,
      reset_n          => reset,
      write            => write,
      address          => address,
      writedata        => writedata
    );
end arch;
