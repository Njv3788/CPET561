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
      address          : IN  std_logic_vector(2 DOWNTO 0);  --address of register to be written to (from CPU)
      writedata        : IN  std_logic_vector(31 DOWNTO 0); --data from the CPU to be stored in the component
      ext_addr_export  : IN  std_logic_vector(2 DOWNTO 0);  --address of register to be read from (from other VHDL)
      invalid_export   : IN  std_logic;                     --this is a signal to tell the component that there has been an invalid request
      ext_data_export  : OUT std_logic_vector(31 DOWNTO 0); --data visible to other components
      irq              : OUT std_logic                      --signal to interrupt the processor
  );end component; 
  
  signal output           : std_logic;
  constant period         : time := 20ns;
  signal clk              : std_logic := '0';
  signal write            : std_logic := '0';
  signal reset            : std_logic := '1';
  signal address          : std_logic_vector(2 DOWNTO 0)  := "000";
  signal writedata        : std_logic_vector(31 DOWNTO 0) := (others => '0');
  signal ext_addr_export  : std_logic_vector(2 downto 0)  := "000";
  signal invalid_export   : std_logic;
  signal ext_data_export  : std_logic_vector(31 DOWNTO 0);
  signal irq              : std_logic;
Begin
  
  sequential_tb : process 
      begin
        
    end process; 
    
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
      reset <= '0';
      wait;
  end process; 
  
  uut: lab4_top 
    port map(    
      clk              => clk,
      reset_n          => reset,
      write            => write,
      address          => address,
      writedata        => writedata,
      ext_addr_export  => ext_addr_export,
      invalid_export   => invalid_export,
      ext_data_export  => ext_data_export,
      irq              => irq
    );
end arch;
