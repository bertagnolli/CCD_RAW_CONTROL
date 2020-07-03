--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:02:04 06/13/2013
-- Design Name:   
-- Module Name:   M:/Projetos/VHDL/L8/BENCH_FPGA/BENCH_FPGA_V00_33/TB_DESERIALIZER.vhd
-- Project Name:  BENCH_FPGA_V00_33
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DESERIALIZER
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
 
ENTITY TB_DESERIALIZER IS
END TB_DESERIALIZER;
 
ARCHITECTURE behavior OF TB_DESERIALIZER IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DESERIALIZER
    PORT(
         RX_i : IN  std_logic;
         CLK_i : IN  std_logic;
         BAUD_CLK_i : IN  std_logic;
         RESET_i : IN  std_logic;
         ILLUM_INT_o : OUT  std_logic_vector(7 downto 0);
         BGND_INT_o : OUT  std_logic_vector(7 downto 0);
         INIT_ILLUM_o : OUT  std_logic_vector(7 downto 0);
         INIT_DIS_o : OUT  std_logic_vector(7 downto 0);
         END_DIS_o : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RX_i : std_logic := '1';
   signal CLK_i : std_logic := '0';
   signal BAUD_CLK_i : std_logic := '0';
   signal RESET_i : std_logic := '0';

 	--Outputs
   signal ILLUM_INT_o : std_logic_vector(7 downto 0);
   signal BGND_INT_o : std_logic_vector(7 downto 0);
   signal INIT_ILLUM_o : std_logic_vector(7 downto 0);
   signal INIT_DIS_o : std_logic_vector(7 downto 0);
   signal END_DIS_o : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_i_period : time := 1 ns;
	constant BAUD_CLK_i_period : time := 26 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DESERIALIZER PORT MAP (
          RX_i => RX_i,
          CLK_i => CLK_i,
          BAUD_CLK_i => BAUD_CLK_i,
          RESET_i => RESET_i,
          ILLUM_INT_o => ILLUM_INT_o,
          BGND_INT_o => BGND_INT_o,
          INIT_ILLUM_o => INIT_ILLUM_o,
          INIT_DIS_o => INIT_DIS_o,
          END_DIS_o => END_DIS_o
        );

   -- Clock process definitions
   CLK_i_process :process
   begin
		CLK_i <= '0';
		wait for CLK_i_period/2;
		CLK_i <= '1';
		wait for CLK_i_period/2;
   end process;
	
   BAUD_CLK_i_process :process
   begin
		BAUD_CLK_i <= '0';
		wait for BAUD_CLK_i_period/2;
		BAUD_CLK_i <= '1';
		wait for BAUD_CLK_i_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		RESET_i <= '1';
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		RESET_i <= '0';
		wait for 100 ns;
		-- Handshake
		RX_i <= '0'; -- Init bit
		wait for 26 ns;
		RX_i <= '1'; -- Bit 0
		wait for 26 ns;
		RX_i <= '0'; -- Bit 1
		wait for 26 ns;
		RX_i <= '0'; -- Bit 2
		wait for 26 ns;
		RX_i <= '1'; -- Bit 3
		wait for 26 ns;
		RX_i <= '0'; -- Bit 4
		wait for 26 ns;
		RX_i <= '1'; -- Bit 5
		wait for 26 ns;
		RX_i <= '1'; -- Bit 6
		wait for 26 ns;
		RX_i <= '0'; -- Bit 7
		wait for 26 ns;
		RX_i <= '1'; -- End Bit
		wait for 26 ns;
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		-- Byte 0
		RX_i <= '0'; -- Init bit
		wait for 26 ns;
		RX_i <= '1'; -- Bit 0
		wait for 26 ns;
		RX_i <= '0'; -- Bit 1
		wait for 26 ns;
		RX_i <= '0'; -- Bit 2
		wait for 26 ns;
		RX_i <= '0'; -- Bit 3
		wait for 26 ns;
		RX_i <= '0'; -- Bit 4
		wait for 26 ns;
		RX_i <= '0'; -- Bit 5
		wait for 26 ns;
		RX_i <= '0'; -- Bit 6
		wait for 26 ns;
		RX_i <= '0'; -- Bit 7
		wait for 26 ns;
		RX_i <= '1'; -- End Bit
		wait for 26 ns;
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		-- Byte 1
		RX_i <= '0'; -- Init bit
		wait for 26 ns;
		RX_i <= '0'; -- Bit 0
		wait for 26 ns;
		RX_i <= '1'; -- Bit 1
		wait for 26 ns;
		RX_i <= '0'; -- Bit 2
		wait for 26 ns;
		RX_i <= '0'; -- Bit 3
		wait for 26 ns;
		RX_i <= '0'; -- Bit 4
		wait for 26 ns;
		RX_i <= '0'; -- Bit 5
		wait for 26 ns;
		RX_i <= '0'; -- Bit 6
		wait for 26 ns;
		RX_i <= '0'; -- Bit 7
		wait for 26 ns;
		RX_i <= '1'; -- End Bit
		wait for 26 ns;
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		-- Byte 2
		RX_i <= '0'; -- Init bit
		wait for 26 ns;
		RX_i <= '1'; -- Bit 0
		wait for 26 ns;
		RX_i <= '1'; -- Bit 1
		wait for 26 ns;
		RX_i <= '0'; -- Bit 2
		wait for 26 ns;
		RX_i <= '0'; -- Bit 3
		wait for 26 ns;
		RX_i <= '0'; -- Bit 4
		wait for 26 ns;
		RX_i <= '0'; -- Bit 5
		wait for 26 ns;
		RX_i <= '0'; -- Bit 6
		wait for 26 ns;
		RX_i <= '0'; -- Bit 7
		wait for 26 ns;
		RX_i <= '1'; -- End Bit
		wait for 26 ns;
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		-- Byte 3
		RX_i <= '0'; -- Init bit
		wait for 26 ns;
		RX_i <= '0'; -- Bit 0
		wait for 26 ns;
		RX_i <= '0'; -- Bit 1
		wait for 26 ns;
		RX_i <= '1'; -- Bit 2
		wait for 26 ns;
		RX_i <= '0'; -- Bit 3
		wait for 26 ns;
		RX_i <= '0'; -- Bit 4
		wait for 26 ns;
		RX_i <= '0'; -- Bit 5
		wait for 26 ns;
		RX_i <= '0'; -- Bit 6
		wait for 26 ns;
		RX_i <= '0'; -- Bit 7
		wait for 26 ns;
		RX_i <= '1'; -- End Bit
		wait for 26 ns;
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		-- Byte 4
		RX_i <= '0'; -- Init bit
		wait for 26 ns;
		RX_i <= '1'; -- Bit 0
		wait for 26 ns;
		RX_i <= '0'; -- Bit 1
		wait for 26 ns;
		RX_i <= '1'; -- Bit 2
		wait for 26 ns;
		RX_i <= '0'; -- Bit 3
		wait for 26 ns;
		RX_i <= '0'; -- Bit 4
		wait for 26 ns;
		RX_i <= '0'; -- Bit 5
		wait for 26 ns;
		RX_i <= '0'; -- Bit 6
		wait for 26 ns;
		RX_i <= '0'; -- Bit 7
		wait for 26 ns;
		RX_i <= '1'; -- End Bit
		wait for 26 ns;
		RX_i <= '1'; -- Idle
		wait for 26 ns; 
		RX_i <= '1'; -- Idle
		wait for 26 ns; 

      wait for CLK_i_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
