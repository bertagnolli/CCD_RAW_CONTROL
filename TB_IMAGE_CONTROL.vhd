--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:21:37 06/11/2013
-- Design Name:   
-- Module Name:   M:/Projetos/VHDL/L8/BENCH_FPGA/BENCH_FPGA_V00_33/TB_IMAGE_CONTROL.vhd
-- Project Name:  BENCH_FPGA_V00_33
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: IMAGE_CONTROL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_IMAGE_CONTROL IS
END TB_IMAGE_CONTROL;
 
ARCHITECTURE behavior OF TB_IMAGE_CONTROL IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IMAGE_CONTROL
    PORT(
         ILLUM_INT_i : IN  std_logic_vector(7 downto 0);
			ILLUM2_INT_i : IN  std_logic_vector(7 downto 0);
         BGND_INT_i : IN  std_logic_vector(7 downto 0);
         INIT_DIS_i : IN  std_logic_vector(7 downto 0);
         END_DIS_i : IN  std_logic_vector(7 downto 0);
         INIT_ILLUM_i : IN  std_logic_vector(7 downto 0);
         CLK_i : IN  std_logic;
         RST_i : IN  std_logic;
         CCD_DIS_o : OUT  std_logic;
         CCD_CLK_o : OUT  std_logic;
         CCD_SI_o : OUT  std_logic;
         FLED_o : OUT  std_logic;
         RLED_o : OUT  std_logic;
         BGND_o : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal ILLUM_INT_i : std_logic_vector(7 downto 0) := (others => '0');
	signal ILLUM2_INT_i : std_logic_vector(7 downto 0) := (others => '0');
   signal BGND_INT_i : std_logic_vector(7 downto 0) := (others => '0');
   signal INIT_DIS_i : std_logic_vector(7 downto 0) := (others => '0');
   signal END_DIS_i : std_logic_vector(7 downto 0) := (others => '0');
   signal INIT_ILLUM_i : std_logic_vector(7 downto 0) := (others => '0');
   signal CLK_i : std_logic := '0';
   signal RST_i : std_logic := '0';

 	--Outputs
   signal CCD_DIS_o : std_logic;
   signal CCD_CLK_o : std_logic;
   signal CCD_SI_o : std_logic;
   signal FLED_o : std_logic;
   signal RLED_o : std_logic;
   signal BGND_o : std_logic;

   -- Clock period definitions
   constant CLK_i_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IMAGE_CONTROL PORT MAP (
          ILLUM_INT_i => ILLUM_INT_i,
			 ILLUM2_INT_i => ILLUM2_INT_i,
          BGND_INT_i => BGND_INT_i,
          INIT_DIS_i => INIT_DIS_i,
          END_DIS_i => END_DIS_i,
          INIT_ILLUM_i => INIT_ILLUM_i,
          CLK_i => CLK_i,
          RST_i => RST_i,
          CCD_DIS_o => CCD_DIS_o,
          CCD_CLK_o => CCD_CLK_o,
          CCD_SI_o => CCD_SI_o,
          FLED_o => FLED_o,
          RLED_o => RLED_o,
          BGND_o => BGND_o
        );

   -- Clock process definitions
   CLK_i_process :process
   begin
		CLK_i <= '0';
		wait for CLK_i_period/2;
		CLK_i <= '1';
		wait for CLK_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
      ILLUM_INT_i <= X"A0";
		ILLUM2_INT_i <= X"C0";
      BGND_INT_i <= X"10";
      INIT_DIS_i <= X"00";
      END_DIS_i <= X"05";
      INIT_ILLUM_i <= X"00";
		RST_i <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		RST_i <= '0';

      wait for CLK_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
