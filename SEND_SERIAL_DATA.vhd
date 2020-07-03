----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:55:45 06/26/2012 
-- Design Name: 
-- Module Name:    SEND_SERIAL_DATA - Behavioral 
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

entity SEND_SERIAL_DATA is
    Port ( PACK_8BIT_0 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_1 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_2 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_3 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_4 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_5 : in  STD_LOGIC_VECTOR(7 downto 0);
			  
           PACKET_SENT_i : in  STD_LOGIC;
           CLK_i : in  STD_LOGIC;
           RST_i : in  STD_LOGIC;
           SEND_8BIT_DATA_o : out  STD_LOGIC_VECTOR (7 downto 0);
           SEND_o : out  STD_LOGIC);
end SEND_SERIAL_DATA;

architecture Behavioral of SEND_SERIAL_DATA is
signal s_send_interval_counter : integer range 0 to 131071;
signal s_send_state_machine : std_logic_vector(4 downto 0);
begin

	process(CLK_i, RST_i)
	begin
		if rising_edge(CLK_i) then
		
			if (RST_i = '1') then
			
				SEND_8BIT_DATA_o <= "00000000";
				SEND_o <= '0';
				s_send_state_machine <= "00000";
				s_send_interval_counter <= 0;
			
			else
			
				if (s_send_interval_counter = 7680) then
			
					case s_send_state_machine is
					
						-- PACKET 0
						when "00000" =>
											SEND_8BIT_DATA_o <= PACK_8BIT_0;
											SEND_o <= '1'; 
											s_send_state_machine <= "00001";
											
						when "00001" =>
											SEND_o <= '0';
											if (PACKET_SENT_i = '1') then
												s_send_state_machine <= "00010";
											else
												s_send_state_machine <= "00001";
											end if;

						-- PACKET 1
						when "00010" =>
											SEND_8BIT_DATA_o <= PACK_8BIT_1;
											SEND_o <= '1'; 
											s_send_state_machine <= "00011";
						
						when "00011" =>
											SEND_o <= '0';
											if (PACKET_SENT_i = '1') then
												s_send_state_machine <= "00100";
											else
												s_send_state_machine <= "00011";
											end if;				
											
						-- PACKET 2
						when "00100" =>
											SEND_8BIT_DATA_o <= PACK_8BIT_2;
											SEND_o <= '1'; 
											s_send_state_machine <= "00101";
											
						when "00101" =>
											SEND_o <= '0';
											if (PACKET_SENT_i = '1') then
												s_send_state_machine <= "00110";
											else
												s_send_state_machine <= "00101";
											end if;
						
						-- PACKET 3
						when "00110" =>
											SEND_8BIT_DATA_o <= PACK_8BIT_3;
											SEND_o <= '1'; 
											s_send_state_machine <= "00111";
						
						when "00111" =>
											SEND_o <= '0';
											if (PACKET_SENT_i = '1') then
												s_send_state_machine <= "01000";
											else
												s_send_state_machine <= "00111";
											end if;
						
						-- PACKET 4
						when "01000" =>
											SEND_8BIT_DATA_o <= PACK_8BIT_4;
											SEND_o <= '1'; 
											s_send_state_machine <= "01001";

						when "01001" =>
											SEND_o <= '0';
											if (PACKET_SENT_i = '1') then
												s_send_state_machine <= "01010";
											else
												s_send_state_machine <= "01001";
											end if;
											
						-- PACKET 5
						when "01010" =>
											SEND_8BIT_DATA_o <= PACK_8BIT_5;
											SEND_o <= '1'; 
											s_send_state_machine <= "01011";

						when "01011" =>
											SEND_o <= '0';
											if (PACKET_SENT_i = '1') then
												s_send_state_machine <= "11110";
											else
												s_send_state_machine <= "01011";
											end if;
											
						-- END PACKET		
						when "11110" =>
											SEND_8BIT_DATA_o <= "10101010";
											SEND_o <= '1';
											s_send_state_machine <= "11111";
						
						when "11111" =>
											SEND_o <= '0';
											if (PACKET_SENT_i = '1') then
												s_send_interval_counter <= 0;
												s_send_state_machine <= "11111";
											else
												s_send_state_machine <= "11111";
											end if;
											
						when others =>
											s_send_interval_counter <= 0;
											SEND_o <= '0'; 
					
					end case;
					
				else
				
					SEND_o <= '0';
					s_send_state_machine <= "00000";
					SEND_8BIT_DATA_o <= "00000000";
					s_send_interval_counter <= s_send_interval_counter + 1;
					
				end if;
			
			end if;
			
		end if;
	end process;

end Behavioral;

