----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:19:29 06/12/2013 
-- Design Name: 
-- Module Name:    SERIAL_PARAMETERS - Behavioral 
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

entity SERIAL_PARAMETERS is
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
end SERIAL_PARAMETERS;

architecture Behavioral of SERIAL_PARAMETERS is
signal s_has_packet, s_clear_has_packet : std_logic;
signal s_command_state_machine : std_logic_vector(2 downto 0);

begin

	process(CLK_i, RST_i)
	begin
		if rising_edge(CLK_i) then															--	On rising edge of 1MHz clock	
			if (RST_i = '1') then															-- If there is a reset signal
			
				s_command_state_machine <= "000";										-- Set initial state to 0
				s_clear_has_packet <= '0';													-- Clear has packet flag
				
				ILLUM_INT_o <= X"0D";
				ILLUM2_INT_o <= X"96";
				BGND_INT_o <= X"96";
				INIT_ILLUM_o <= X"00";
				INIT_DIS_o <= X"00";
				END_DIS_o <= X"00";
				
			else
				
				s_clear_has_packet <= '0';													-- Set the clear flag to '0' to asure if will be active only 1 cycle
																									-- this will be active only 1 clock cycle
				case s_command_state_machine is
					
					when "000" =>																-- On the first state (Waiting for command)
						
										
										if (s_has_packet = '1') then						-- If the module received a new packet
										
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											
											if (DATA_i = "01101001") then					-- Check if there is a "Handshake" ("01101001")
												s_command_state_machine <= "001";		-- Go to next state
											else													-- If the data is different from the "Handshake" pattern
												s_command_state_machine <= "000";		-- Stay here and wait for a new packet
											end if;
											
										else														-- If there is no packet
											s_command_state_machine <= "000";			-- Wait for a packet
										end if;
										
					when "001" =>																-- On the first state (Waiting for command)
										if (s_has_packet = '1') then						-- If the module received a new packet
										
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											
											ILLUM_INT_o <= DATA_i;
											s_command_state_machine <= "110";		-- Go to next state
											
										else														-- If there is no packet
											s_command_state_machine <= "001";			-- Wait for a packet
										end if;
										
					when "010" =>																-- On the first state (Waiting for command)
										if (s_has_packet = '1') then						-- If the module received a new packet
										
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											
											BGND_INT_o <= DATA_i;
											s_command_state_machine <= "011";		-- Go to next state
											
										else														-- If there is no packet
											s_command_state_machine <= "010";			-- Wait for a packet
										end if;
										
					when "011" =>																-- On the first state (Waiting for command)
										if (s_has_packet = '1') then						-- If the module received a new packet
										
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											
											INIT_ILLUM_o <= DATA_i;
											s_command_state_machine <= "100";		-- Go to next state
											
										else														-- If there is no packet
											s_command_state_machine <= "011";			-- Wait for a packet
										end if;
										
					when "100" =>																-- On the first state (Waiting for command)
										if (s_has_packet = '1') then						-- If the module received a new packet
										
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											
											INIT_DIS_o <= DATA_i;
											s_command_state_machine <= "101";		-- Go to next state
											
										else														-- If there is no packet
											s_command_state_machine <= "100";			-- Wait for a packet
										end if;
										
					when "101" =>																-- On the first state (Waiting for command)
										if (s_has_packet = '1') then						-- If the module received a new packet
										
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											
											END_DIS_o <= DATA_i;
											s_command_state_machine <= "000";			-- Go to next state
											
										else														-- If there is no packet
											s_command_state_machine <= "101";			-- Wait for a packet
										end if;
										
					when "110" =>																-- On the first state (Waiting for command)
										if (s_has_packet = '1') then						-- If the module received a new packet
										
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											
											ILLUM2_INT_o <= DATA_i;
											s_command_state_machine <= "010";			-- Go to next state
											
										else														-- If there is no packet
											s_command_state_machine <= "110";			-- Wait for a packet
										end if;
					
					when others =>
											s_clear_has_packet <= '1';						-- Clear the has packet flag
											s_command_state_machine <= "000";			-- Go to next state

				end case;
				
			end if;
		end if;
			
	end process;
	
	process(RST_i, PACKET_READY_i, s_clear_has_packet)
	begin
		if ((RST_i = '1') or (s_clear_has_packet = '1')) then	-- If there is a reset signal or a clear packet flag
		
			s_has_packet <= '0';												-- Clear the has packet signal
			
		else
			if rising_edge(PACKET_READY_i) then							-- On a rising edge of a Packet ready flag
				s_has_packet <= '1';											-- Set the has packet signal
			end if;			
		end if;
	
	end process;


end Behavioral;

