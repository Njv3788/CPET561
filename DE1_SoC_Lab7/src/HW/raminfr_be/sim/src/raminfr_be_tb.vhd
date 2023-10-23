-------------------------------------------------------------------------------
-- Dr. Kaputa
-- seven segment test bench
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity raminfr_be_tb is
end raminfr_be_tb;

architecture arch of raminfr_be_tb is
  
  COMPONENT raminfr_be IS
    PORT(
      clk                 : IN  std_logic;
      reset_n             : IN  std_logic;
      writebyteenable_n   : IN  std_logic_vector(3 DOWNTO 0);
      address             : IN  std_logic_vector(11 DOWNTO 0);
      writedata           : IN  std_logic_vector(31 DOWNTO 0);
      --
      readdata            : OUT std_logic_vector(31 DOWNTO 0)
    );
  END COMPONENT raminfr_be;

  constant period         : time := 20ns;
  SIGNAL   clk                 :std_logic := '0';
  SIGNAL   reset_n             :std_logic := '0';
  SIGNAL   writebyteenable_n   :std_logic_vector(3 DOWNTO 0) := "1111";
  SIGNAL   writedata           :std_logic_vector(31 DOWNTO 0):= (others => '0');
  SIGNAL   readdata            :std_logic_vector(31 DOWNTO 0);
  SIGNAL   address             :std_logic_vector(11 DOWNTO 0):= (others => '0');
  SIGNAL   flag                :std_logic_vector( 2 DOWNTO 0):= (others => '0');
  SIGNAL   DONE                :std_logic := '0';
  
  TYPE write_enable_type IS ARRAY (3 DOWNTO 0) OF std_logic_vector ( 3 DOWNTO 0);
  TYPE test_words_type   IS ARRAY (3 DOWNTO 0) OF std_logic_vector (31 DOWNTO 0);
  
  constant uint32_test_words  :test_words_type := (x"00000000",x"00000000",x"00000000",x"ABCDEF90");
  constant uint16_test_words  :test_words_type := (x"00000000",x"00000000",x"12340000",x"00001234");
  constant uint08_test_words  :test_words_type := (x"00111111",x"11001111",x"11110011",x"11111100");
  
  constant write_disable        :std_logic_vector( 3 DOWNTO 0) := "1111";
  constant uint32_write_enable  :write_enable_type := ("1111","1111","1111","0000");
  constant uint16_write_enable  :write_enable_type := ("1111","1111","0011","1100");
  constant uint08_write_enable  :write_enable_type := ("0111","1011","1101","1110");
  
  signal uint32     : std_logic_vector (31 DOWNTO 0) := (others =>'0');
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
      reset_n <= '1';
      wait;
  end process; 
  
  stimulus: process
    begin
    wait for 2 * period;
    for i in 0 to 4095 loop
      address <= std_logic_vector(to_unsigned(i,12));
      writebyteenable_n  <= uint32_write_enable(0);
      writedata          <= uint32_test_words(0);
      wait for period;
      if(not(readdata = uint32_test_words(0)))THEN
        report "expected:"& integer'image(to_integer(unsigned(uint32_test_words(0))))& CR&
               "actual:  "& integer'image(to_integer(unsigned(readdata)))& CR;
        flag(0) <= '1';
      end if;
      DONE <= '0';
    end loop;
  
    for i in 0 to 4095 loop
      address <= std_logic_vector(to_unsigned(i,12));
      for j in 0 to 1 loop
        writebyteenable_n  <= uint16_write_enable(j);
        writedata          <= uint16_test_words(j);
        wait for period;
        uint32 <= uint16_test_words(j);
        if(not(readdata(15+j*16 downto j*16) = uint32(15+j*16 downto j*16)))THEN
          report "expected:"& integer'image(to_integer(unsigned(uint16_write_enable(j))))& CR&
                 "actual:  "& integer'image(to_integer(unsigned(readdata))& CR;
          flag(1) <= '1';
        end if;
        DONE <= '0';
      end loop;
    end loop;
    DONE <= '1';
    wait;
  end process;
  
  uut: raminfr_be
    port map(    
      clk              => clk,
      reset_n          => reset_n,
      writebyteenable_n=> writebyteenable_n,
      address          => address,
      writedata        => writedata,
      readdata         => readdata
    );
end arch;
