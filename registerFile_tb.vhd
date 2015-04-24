LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY registerFile_tb IS
END registerFile_tb;
 
ARCHITECTURE behavior OF registerFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registerFile
    PORT(
         reset : IN  std_logic;
         rs1 : IN  std_logic_vector(5 downto 0);
         rs2 : IN  std_logic_vector(5 downto 0);
         rd : IN  std_logic_vector(5 downto 0);
         we : IN  std_logic;
         DWR : IN  std_logic_vector(31 downto 0);
         CRs1 : OUT  std_logic_vector(31 downto 0);
         CRs2 : OUT  std_logic_vector(31 downto 0);
         CRd : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal reset : std_logic := '1';
   signal rs1 : std_logic_vector(5 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(5 downto 0) := (others => '0');
   signal rd : std_logic_vector(5 downto 0) := (others => '0');
   signal we : std_logic := '0';
   signal DWR : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal CRs1 : std_logic_vector(31 downto 0);
   signal CRs2 : std_logic_vector(31 downto 0);
   signal CRd : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registerFile PORT MAP (
          reset => reset,
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          we => we,
          DWR => DWR,
          CRs1 => CRs1,
          CRs2 => CRs2,
          CRd => CRd
        );

   stim_proc: process
   begin		
      wait for 20 ns;
		reset<='0';
		rs1<="000000";
		rs2<="000000";
		rd<="000001";
		dwr<=x"00000000";
		we<='0';
		
      wait for 20 ns;	
		rs1<="000001";
		rs2<="000001";
		rd <="000001";
		dwr<=x"00000000";
		we<='0';
		
      wait for 20 ns;
		rs1<="000010";
		rs2<="000010";
		rd<="000001";
		dwr<=x"00000000";
		we<='0';
		
      wait for 20 ns;
		rs1<="000011";
		rs2<="000011";
		rd<="000011";
		dwr<=x"00000000";
		we<='0';
		
      wait for 20 ns;
		rs1<="000001";
		rs2<="000001";
		rd<="000001";
		dwr<=x"0000000A";
		we<='1';
		
      wait for 20 ns;
		rs1<="000001";
		rs2<="000001";
		rd<="000001";
		dwr<=x"0000000A";
		we<='0';
      wait;
   end process;

END;
