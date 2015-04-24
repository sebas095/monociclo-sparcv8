LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
 
ENTITY windowManager_tb IS
END windowManager_tb;
 
ARCHITECTURE behavior OF windowManager_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT windowManager
    PORT(
         op : IN  std_logic_vector(1 downto 0);
         op3 : IN  std_logic_vector(5 downto 0);
         cwp : IN  std_logic_vector(1 downto 0);
         rs1 : IN  std_logic_vector(4 downto 0);
         rs2 : IN  std_logic_vector(4 downto 0);
         rd : IN  std_logic_vector(4 downto 0);
         ncwp : OUT  std_logic_vector(1 downto 0);
         new_rs1 : OUT  std_logic_vector(5 downto 0);
         new_rs2 : OUT  std_logic_vector(5 downto 0);
         new_rd : OUT  std_logic_vector(5 downto 0);
         registroO7 : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal op : std_logic_vector(1 downto 0) := (others => '0');
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal cwp : std_logic_vector(1 downto 0) := (others => '0');
   signal rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal rd : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal ncwp : std_logic_vector(1 downto 0);
   signal new_rs1 : std_logic_vector(5 downto 0);
   signal new_rs2 : std_logic_vector(5 downto 0);
   signal new_rd : std_logic_vector(5 downto 0);
   signal registroO7 : std_logic_vector(5 downto 0);
   
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: windowManager PORT MAP (
          op => op,
          op3 => op3,
          cwp => cwp,
          rs1 => rs1,
          rs2 => rs2,
          rd => rd,
          ncwp => ncwp,
          new_rs1 => new_rs1,
          new_rs2 => new_rs2,
          new_rd => new_rd,
          registroO7 => registroO7
        );

   stim_proc: process
   begin		
      cwp <= "01";
		op <= "10";
		op3 <= "101101";
		rs1 <= "00011";
		rs2 <= "10001";
		rd <= "10010";
      wait;
   end process;

END;
