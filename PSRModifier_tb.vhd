LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PSRModifier_tb IS
END PSRModifier_tb;
 
ARCHITECTURE behavior OF PSRModifier_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PSRModifier
    PORT(
         ALUop : IN  std_logic_vector(5 downto 0);
         ALUResult : IN  std_logic_vector(31 downto 0);
         reset : IN  std_logic;
         op1 : IN  std_logic;
         op2 : IN  std_logic;
			PSREnable : OUT std_logic;
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ALUop : std_logic_vector(5 downto 0) := (others => '0');
   signal ALUResult : std_logic_vector(31 downto 0) := (others => '0');
   signal reset : std_logic := '0';
   signal op1 : std_logic := '0';
   signal op2 : std_logic := '0';

 	--Outputs
   signal nzvc : std_logic_vector(3 downto 0);
	signal PSREnable : std_logic;
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PSRModifier PORT MAP (
          ALUop => ALUop,
          ALUResult => ALUResult,
          reset => reset,
          op1 => op1,
          op2 => op2,
			 PSREnable => PSREnable,
          nzvc => nzvc
        );

   -- Stimulus process
   stim_proc: process
   begin		
      reset<='1';
      wait for 100 ns;
		reset<='0';
		ALUResult<=x"00000000";
		op1<='1';
		op2<='1';
		ALUop<="010000";
		wait for 100 ns;
		ALUResult<=x"00000010";
		op1<='1';
		op2<='1';
		ALUop<="010000";
		wait for 100 ns;
		ALUResult<=x"F0000010";
		op1<='1';
		op2<='1';
		ALUop<="010000";
		wait;
   end process;

END;
