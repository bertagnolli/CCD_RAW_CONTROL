----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:11:49 10/03/2012 
-- Design Name: 
-- Module Name:    DESERIALIZER - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DESERIALIZER is
    Port ( RX_i : in  STD_LOGIC;										-- RX 232 input
			  CLK_i : in STD_LOGIC;										-- 1 MHz input clock
           BAUD_CLK_i : in  STD_LOGIC;								-- 38400 Hz
           RESET_i : in  STD_LOGIC;
			  
			  RX_DATA_o : out STD_LOGIC_VECTOR(7 downto 0);
			  
           ILLUM_INT_o : out  STD_LOGIC_VECTOR (7 downto 0);
			  ILLUM2_INT_o : out  STD_LOGIC_VECTOR (7 downto 0);
           BGND_INT_o : out  STD_LOGIC_VECTOR (7 downto 0);
           INIT_ILLUM_o : out  STD_LOGIC_VECTOR (7 downto 0);
           INIT_DIS_o : out  STD_LOGIC_VECTOR (7 downto 0);
           END_DIS_o : out  STD_LOGIC_VECTOR (7 downto 0));
end DESERIALIZER;

architecture Behavioral of DESERIALIZER is
------------------------------------------------
-------------- Serial Receiver -----------------
------------------------------------------------
component SERIAL_RX is
    Port ( RX_i : in  STD_LOGIC;												-- RX serial input
           BAUD_CLK_i : in  STD_LOGIC;										-- Baud clock rate (38400)
           RST_i : in  STD_LOGIC;											
			  
			  FAIL_o : out STD_LOGIC;											-- Flag that indicates if there was not an end signal
           PACKET_READY_o : out  STD_LOGIC;								-- Flag that indicates if the receiving state machine is ended
           RX_DATA_o : out  STD_LOGIC_VECTOR (7 downto 0));			-- RX received data (8 bits)
end component;
------------------------------------------------
---------- Serial data interpreter -------------
------------------------------------------------
component SERIAL_PARAMETERS is
    Port ( DATA_i : in  STD_LOGIC_VECTOR (7 downto 0);
           FAIL_i : in  STD_LOGIC;
           PACKET_READY_i : in  STD_LOGIC;
			  
           CLK_i : in  STD_LOGIC;
           RST_i : in  STD_LOGIC;
			  
           ILLUM_INT_o : out  STD_LOGIC_VECTOR (7 downto 0);
			  ILLUM2_INT_o : out  STD_LOGIC_VECTOR (7 downto 0);
           BGND_INT_o : out  STD_LOGIC_VECTOR (7 downto 0);
           INIT_ILLUM_o : out  STD_LOGIC_VECTOR (7 downto 0);
           INIT_DIS_o : out  STD_LOGIC_VECTOR (7 downto 0);
           END_DIS_o : out  STD_LOGIC_VECTOR (7 downto 0));
end component;
------------------------------------------------
signal s_fail, s_packet_ready : std_logic;
signal s_rx_data : std_logic_vector(7 downto 0);

begin

	RX_DATA_o <= s_rx_data;

	i_SERIAL_RX : SERIAL_RX
    Port map( 	RX_i => RX_i,
					BAUD_CLK_i => BAUD_CLK_i,
					RST_i => RESET_i,
			  
					FAIL_o => s_fail,
					PACKET_READY_o => s_packet_ready,
					RX_DATA_o => s_rx_data
					);
					
	i_SERIAL_PARAMETERS : SERIAL_PARAMETERS
    Port map( 	DATA_i => s_rx_data,
					FAIL_i => s_fail,
					PACKET_READY_i => s_packet_ready,
					CLK_i => CLK_i,
					RST_i => RESET_i,
			  
					ILLUM_INT_o => ILLUM_INT_o,
					ILLUM2_INT_o => ILLUM2_INT_o,
					BGND_INT_o => BGND_INT_o,
					INIT_ILLUM_o => INIT_ILLUM_o,
					INIT_DIS_o => INIT_DIS_o,
					END_DIS_o => END_DIS_o
					);

end Behavioral;

