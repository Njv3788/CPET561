--*****************************************************************************
--*****************************************************************************

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
USE ieee.numeric_std.ALL;

ENTITY lab4_top IS
  PORT(
    clk              : IN std_logic;                      -- 50 Mhz system clock
    reset_n          : IN std_logic;                      -- active low system reset
    write            : IN std_logic;                      -- active high write enable
    address          : IN std_logic_vector(0 DOWNTO 0);   --address of register to be written to (from CPU)
    writedata        : IN std_logic_vector(31 DOWNTO 0)   --data from the CPU to be stored in the component
    );
END ENTITY lab4_top;

ARCHITECTURE rtl OF lab4_top IS
  COMPONENT read_only_ram IS
    GENERIC(
      bits             : integer := 2
      );
    PORT(
      clk              : IN  std_logic;                           -- 50 Mhz system clock
      reset_n          : IN  std_logic;                           -- active low system reset
      write            : IN  std_logic;                           -- active high write enable
      address          : IN  std_logic_vector(bits-1 DOWNTO 0);   -- address of register to be written to (from CPU)
      writedata        : IN  std_logic_vector(31 DOWNTO 0);       -- data from the CPU to be stored in the component
      max_out          : OUT std_logic_vector(31 DOWNTO 0);
      min_out          : OUT std_logic_vector(31 DOWNTO 0)
      );
  END COMPONENT;
  
  COMPONENT finite_state_machine IS
    PORT(
      clk              : IN  std_logic;                          -- 50 Mhz system clock
      reset_n          : IN  std_logic;                          -- active low system reset
      enable           : IN  std_logic;
      irq              : OUT std_logic;
      direxction       : OUT std_logic;
      idle_out         : OUT std_logic
    );
  END COMPONENT finite_state_machine;
  
  COMPONENT pwm_generator IS
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
   END COMPONENT pwm_generator;
  
  CONSTANT bits           : integer := 1;
  CONSTANT register_width : integer := 32;
  CONSTANT pluse_period   : std_logic_vector(register_width-1 downto 0) := x"0000000A";
  SIGNAL   pluse_width    : std_logic_vector(register_width-1 downto 0) := x"00000006";
  SIGNAL   enable         : std_logic :='0';
BEGIN
  
  process(clk)
  BEGIN
    IF(RISING_EDGE(clk)) THEN
      enable <='0';
    ELSE
      enable <= NOT(enable);
    END IF;
  END PROCESS;
  
  ram : read_only_ram
    GENERIC MAP(
      bits             => bits
    )
    PORT MAP(    
      clk              => clk,
      reset_n          => reset_n,
      write            => write,
      address          => address,
      writedata        => writedata
    );
  
  fsm : finite_state_machine
    PORT MAP(    
      clk              => clk,
      reset_n          => reset_n,
      enable           => '1'
    );
  
  period_cnt: pwm_generator
    GENERIC MAP(
      bits             => register_width
    )
    PORT MAP(    
      clk              => clk,
      reset_n          => reset_n,
      enable           => enable,
      pulse_period     => pluse_period,
      pulse_width      => pluse_width
    );
END ARCHITECTURE rtl;