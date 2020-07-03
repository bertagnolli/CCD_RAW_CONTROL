----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:01 06/11/2013 
-- Design Name: 
-- Module Name:    IMAGE_CONTROL - Behavioral 
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity IMAGE_CONTROL is
    Port ( ILLUM_INT_i : in  STD_LOGIC_VECTOR (7 downto 0);
			  ILLUM2_INT_i : in  STD_LOGIC_VECTOR (7 downto 0);
           BGND_INT_i : in  STD_LOGIC_VECTOR (7 downto 0);
			  INIT_ILLUM_i : in  STD_LOGIC_VECTOR (7 downto 0);
           INIT_DIS_i : in  STD_LOGIC_VECTOR (7 downto 0);
           END_DIS_i : in  STD_LOGIC_VECTOR (7 downto 0);
			  
			  CLK_i : in  STD_LOGIC;
           RST_i : in  STD_LOGIC;
			  
           CCD_DIS_o : out  STD_LOGIC;
           CCD_CLK_o : out  STD_LOGIC;
           CCD_SI_o : out  STD_LOGIC;
			  
           FLED_o : out  STD_LOGIC;
           RLED_o : out  STD_LOGIC;
           BGND_o : out  STD_LOGIC
           );
end IMAGE_CONTROL;

architecture Behavioral of IMAGE_CONTROL is
signal s_pixel : std_logic_vector(7 downto 0);
signal s_si_sm, s_illum_state : std_logic_vector(1 downto 0);
signal s_downsample, s_ccd_clk_o : std_logic;
signal s_ILLUM_INT_i, s_ILLUM2_INT_i : STD_LOGIC_VECTOR (7 downto 0);
signal s_BGND_INT_i : STD_LOGIC_VECTOR (7 downto 0);
signal s_INIT_ILLUM_i : STD_LOGIC_VECTOR (7 downto 0);
signal s_INIT_DIS_i : STD_LOGIC_VECTOR (7 downto 0);
signal s_END_DIS_i : STD_LOGIC_VECTOR (7 downto 0);
begin

CCD_CLK_o <= s_downsample;

process(CLK_i, RST_i)
begin

	if falling_edge(CLK_i) then
		if (RST_i = '1') then
		
			CCD_SI_o <= '1';
			s_si_sm <= "00";
			s_ILLUM_INT_i <= X"A0";
			s_BGND_INT_i <= X"A0";
			s_INIT_ILLUM_i <= X"00";
			s_INIT_DIS_i <= X"00";
			s_END_DIS_i <= X"FF";
		
		else
			----------------------------------------------------------------	
			---------------------- CCD SI ----------------------------------	
			----------------------------------------------------------------	
			case s_si_sm is
			
				when "00" =>
					if (s_pixel = X"FF") then
						s_si_sm <= "01";
						CCD_SI_o <= '1';
						s_ILLUM_INT_i <= ILLUM_INT_i;
						s_ILLUM2_INT_i <= ILLUM2_INT_i;
						s_BGND_INT_i <= BGND_INT_i;
						s_INIT_ILLUM_i <= INIT_ILLUM_i;
						s_INIT_DIS_i <= INIT_DIS_i;
						s_END_DIS_i <= END_DIS_i;
					else
						s_si_sm <= "00";
						CCD_SI_o <= '0';
					end if;
				
				when "01" =>
					s_si_sm <= "10";
				
				when "10" =>
					s_si_sm <= "00";
					CCD_SI_o <= '0';
					
				when others =>
					s_si_sm <= "00";
					CCD_SI_o <= '0';
					
			end case;
			----------------------------------------------------------------
			
		end if;
	end if;

end process;

process(CLK_i, RST_i, s_pixel)
begin

	if rising_edge(CLK_i) then
		if (RST_i = '1') then
		  CCD_DIS_o <= '0';
		  FLED_o <= '0';
		  RLED_o <= '0';
		  BGND_o <= '0';
		  s_ccd_clk_o <= '0';
		  s_pixel <= X"00";
		  s_illum_state <= "00";
		  s_downsample <= '0';
		else
		
			case s_downsample is
			
				when '0' =>
				
					s_ccd_clk_o <= not(s_ccd_clk_o);
				
					s_downsample <= '1';
					
					----------------------------------------------------------------	
					------------------- Illumination control -----------------------
					----------------------------------------------------------------
					case s_illum_state is
					
						when "00" => -- Rear

							FLED_o <= '0';
							BGND_o <= '0';

							if (s_pixel < s_INIT_ILLUM_i) then
							
								RLED_o <= '0';
								
							else
							
								if (s_pixel > s_ILLUM_INT_i) then
								
									RLED_o <= '0';
									
								else
								
									RLED_o <= '1';
								
								end if;
							
							end if;
							
							if (s_pixel = X"FF") then
								s_illum_state <= "01";
							else
								s_illum_state <= "00";
							end if;

						when "01" => -- Front
						
							RLED_o <= '0';
							BGND_o <= '0';
				
							if (s_pixel < s_INIT_ILLUM_i) then
							
								FLED_o <= '0';
								
							else
							
								if (s_pixel > s_ILLUM2_INT_i) then
								
									FLED_o <= '0';
									
								else
								
									FLED_o <= '1';
								
								end if;
							
							end if;
							
							if (s_pixel = X"FF") then
								s_illum_state <= "10";
							else
								s_illum_state <= "01";
							end if;
										
						when "10" => -- Background
						
							FLED_o <= '0';
							RLED_o <= '0';

							if (s_pixel < s_INIT_ILLUM_i) then
							
								BGND_o <= '0';
								
							else
							
								if (s_pixel > BGND_INT_i) then
								
									BGND_o <= '0';
									
								else
								
									BGND_o <= '1';
								
								end if;
							
							end if;
							
							if (s_pixel = X"FF") then
								s_illum_state <= "00";
							else
								s_illum_state <= "10";
							end if;
							
						when others =>
							s_illum_state <= "00";
										
										
					end case;
					----------------------------------------------------------------		

					if (s_END_DIS_i = X"00") then
					
						CCD_DIS_o <= '0';
						
					else
					
						if (s_pixel < s_INIT_DIS_i) then
							
							CCD_DIS_o <= '0';
						
						else
						
							if (s_pixel < s_END_DIS_i) then
								
								CCD_DIS_o <= '1';
								
							else
							
								CCD_DIS_o <= '0';
							
							end if;
						
						end if;
					
					end if;
					
					s_pixel <= s_pixel + 1;
				
				when '1' =>
				
					s_downsample <= '0';

			
				when others =>
					
					s_downsample <= '0';
					
			end case;
		
		end if;
	end if;

end process;

end Behavioral;