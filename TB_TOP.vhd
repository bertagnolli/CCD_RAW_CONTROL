--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:32:38 06/12/2013
-- Design Name:   
-- Module Name:   M:/Projetos/VHDL/L8/BENCH_FPGA/BENCH_FPGA_V00_33/TB_TOP.vhd
-- Project Name:  BENCH_FPGA_V00_33
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TOP
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
 
ENTITY TB_TOP IS
END TB_TOP;
 
ARCHITECTURE behavior OF TB_TOP IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TOP
    PORT(
         CH1 : IN  std_logic;
         CLK37 : IN  std_logic;
         LED_RESET : IN  std_logic;
         CCD_DIS1 : OUT  std_logic;
         CCD_DIS2 : OUT  std_logic;
         CCD_DIS3 : OUT  std_logic;
         CCD_DIS4 : OUT  std_logic;
         CCD_CLK1 : OUT  std_logic;
         CCD_CLK2 : OUT  std_logic;
         CCD_CLK3 : OUT  std_logic;
         CCD_CLK4 : OUT  std_logic;
         CCD_SI1 : OUT  std_logic;
         CCD_SI2 : OUT  std_logic;
         CCD_SI3 : OUT  std_logic;
         CCD_SI4 : OUT  std_logic;
         FLEDA : OUT  std_logic;
         FLEDB : OUT  std_logic;
         FLEDC : OUT  std_logic;
         FLEDD : OUT  std_logic;
         RLEDA : OUT  std_logic;
         RLEDB : OUT  std_logic;
         RLEDC : OUT  std_logic;
         RLEDD : OUT  std_logic;
         EN_BACK : OUT  std_logic;
			RX_i : IN std_logic;
         TEST : INOUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CH1 : std_logic := '1';
   signal CLK37 : std_logic := '0';
   signal LED_RESET : std_logic := '1';

	--BiDirs
   signal TEST : std_logic_vector(15 downto 0);
	signal RX_i : std_logic := '1';

 	--Outputs
   signal CCD_DIS1 : std_logic;
   signal CCD_DIS2 : std_logic;
   signal CCD_DIS3 : std_logic;
   signal CCD_DIS4 : std_logic;
   signal CCD_CLK1 : std_logic;
   signal CCD_CLK2 : std_logic;
   signal CCD_CLK3 : std_logic;
   signal CCD_CLK4 : std_logic;
   signal CCD_SI1 : std_logic;
   signal CCD_SI2 : std_logic;
   signal CCD_SI3 : std_logic;
   signal CCD_SI4 : std_logic;
   signal FLEDA : std_logic;
   signal FLEDB : std_logic;
   signal FLEDC : std_logic;
   signal FLEDD : std_logic;
   signal RLEDA : std_logic;
   signal RLEDB : std_logic;
   signal RLEDC : std_logic;
   signal RLEDD : std_logic;
   signal EN_BACK : std_logic;

   -- Clock period definitions
   constant CLK37_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TOP PORT MAP (
          CH1 => CH1,
          CLK37 => CLK37,
          LED_RESET => LED_RESET,
          CCD_DIS1 => CCD_DIS1,
          CCD_DIS2 => CCD_DIS2,
          CCD_DIS3 => CCD_DIS3,
          CCD_DIS4 => CCD_DIS4,
          CCD_CLK1 => CCD_CLK1,
          CCD_CLK2 => CCD_CLK2,
          CCD_CLK3 => CCD_CLK3,
          CCD_CLK4 => CCD_CLK4,
          CCD_SI1 => CCD_SI1,
          CCD_SI2 => CCD_SI2,
          CCD_SI3 => CCD_SI3,
          CCD_SI4 => CCD_SI4,
          FLEDA => FLEDA,
          FLEDB => FLEDB,
          FLEDC => FLEDC,
          FLEDD => FLEDD,
          RLEDA => RLEDA,
          RLEDB => RLEDB,
          RLEDC => RLEDC,
          RLEDD => RLEDD,
          EN_BACK => EN_BACK,
			 RX_i => RX_i,
          TEST => TEST
        );

   -- Clock process definitions
   CLK37_process :process
   begin
		CLK37 <= '0';
		wait for CLK37_period/2;
		CLK37 <= '1';
		wait for CLK37_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
--		TEST <= (others=>'1');
		LED_RESET <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		LED_RESET <= '1';
		wait for 5000 ns;	
		CH1 <= '0';
		wait for 1000 ns;	
		CH1 <= '1';
		wait for 1000 ns;	
		-- Handshake
		RX_i <= '0';		-- Init bit
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 0
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 1
		wait for 969 ns;
		RX_i <= '0';		-- Bit 2
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 3
		wait for 969 ns;		
		RX_i <= '0';		-- Bit 4
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 5
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 6
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 7
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		-- Byte 1
		RX_i <= '0';		-- Init bit
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 0
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 1
		wait for 969 ns;
		RX_i <= '1';		-- Bit 2
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 3
		wait for 969 ns;		
		RX_i <= '1';		-- Bit 4
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 5
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 6
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 7
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		-- Byte 2
		RX_i <= '0';		-- Init bit
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 0
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 1
		wait for 969 ns;
		RX_i <= '1';		-- Bit 2
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 3
		wait for 969 ns;		
		RX_i <= '1';		-- Bit 4
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 5
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 6
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 7
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		-- Byte 3
		RX_i <= '0';		-- Init bit
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 0
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 1
		wait for 969 ns;
		RX_i <= '1';		-- Bit 2
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 3
		wait for 969 ns;		
		RX_i <= '1';		-- Bit 4
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 5
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 6
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 7
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		-- Byte 4
		RX_i <= '0';		-- Init bit
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 0
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 1
		wait for 969 ns;
		RX_i <= '0';		-- Bit 2
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 3
		wait for 969 ns;		
		RX_i <= '0';		-- Bit 4
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 5
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 6
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 7
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		-- Byte 5
		RX_i <= '0';		-- Init bit
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 0
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 1
		wait for 969 ns;
		RX_i <= '0';		-- Bit 2
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 3
		wait for 969 ns;		
		RX_i <= '0';		-- Bit 4
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 5
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 6
		wait for 969 ns;	
		RX_i <= '0';		-- Bit 7
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		-- Byte 6
		RX_i <= '0';		-- Init bit
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 0
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 1
		wait for 969 ns;
		RX_i <= '1';		-- Bit 2
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 3
		wait for 969 ns;		
		RX_i <= '1';		-- Bit 4
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 5
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 6
		wait for 969 ns;	
		RX_i <= '1';		-- Bit 7
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	
		RX_i <= '1';		-- End Bit
		wait for 969 ns;	


      wait for CLK37_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
