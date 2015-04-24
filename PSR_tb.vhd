LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PSR_tb IS
END PSR_tb;
 
ARCHITECTURE behavior OF PSR_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSR
    PORT(
         clk : IN  std_logic;
         ncwp : IN  std_logic_vector(1 downto 0);
         reset : IN  std_logic;
         enable : IN  std_logic;
         nzvc : IN  std_logic_vector(3 downto 0);
         carry : OUT  std_logic;
         icc : OUT  std_logic_vector(3 downto 0);
         cwp : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ncwp : std_logic_vector(1 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal enable : std_logic := '0';
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal carry : std_logic;
   signal icc : std_logic_vector(3 downto 0);
   signal cwp : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSR PORT MAP (
          clk => clk,
          ncwp => ncwp,
          reset => reset,
          enable => enable,
          nzvc => nzvc,
          carry => carry,
          icc => icc,
          cwp => cwp
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset<='1';
		enable<='1';
		nzvc<="0010";
		wait for 50 ns;
		reset<='0';
		enable<='1';
		nzvc<="1010";
		wait for 50 ns;
		enable<='0';
		nzvc<="1110";
		wait for 50 ns;
		enable<='1';
		nzvc<="0101";
      wait;
   end process;

END;
