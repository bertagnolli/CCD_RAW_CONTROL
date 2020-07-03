----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:32 06/12/2013 
-- Design Name: 
-- Module Name:    TOP - Behavioral 
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
USE ieee.std_logic_ARITH.ALL;
USE ieee.std_logic_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOP is
    Port ( CH1 : in  STD_LOGIC;			-- Physical reset switch
           CLK37 : in  STD_LOGIC;		-- 37.5MHz clock input
			  LED_RESET : in STD_LOGIC;	-- Hardware reset signal input
           CCD_DIS1 : out  STD_LOGIC;	-- CCD Disable integration 1 output 
           CCD_DIS2 : out  STD_LOGIC;
           CCD_DIS3 : out  STD_LOGIC;
           CCD_DIS4 : out  STD_LOGIC;
           CCD_CLK1 : out  STD_LOGIC;	-- CCD Clock signal
           CCD_CLK2 : out  STD_LOGIC;
           CCD_CLK3 : out  STD_LOGIC;
           CCD_CLK4 : out  STD_LOGIC;
           CCD_SI1 : out  STD_LOGIC;	-- CCD Signal Integration output
           CCD_SI2 : out  STD_LOGIC;
           CCD_SI3 : out  STD_LOGIC;
           CCD_SI4 : out  STD_LOGIC;
           FLEDA : out  STD_LOGIC;		-- Front LED control signals
           FLEDB : out  STD_LOGIC;
           FLEDC : out  STD_LOGIC;
           FLEDD : out  STD_LOGIC;
           RLEDA : out  STD_LOGIC;		-- Rear LED control signals
           RLEDB : out  STD_LOGIC;
           RLEDC : out  STD_LOGIC;
           RLEDD : out  STD_LOGIC;
           EN_BACK : out  STD_LOGIC; 	-- Background LED control signal
			  
           TEST : inout  STD_LOGIC_VECTOR (15 downto 0));	--Test INOUT pins
end TOP;

architecture Behavioral of TOP is

component DESERIALIZER is
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
end component;

component IMAGE_CONTROL is
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
end component;

component STATUS_SENDER is
    Port ( PACK_8BIT_0 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_1 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_2 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_3 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_4 : in  STD_LOGIC_VECTOR(7 downto 0);
			  PACK_8BIT_5 : in  STD_LOGIC_VECTOR(7 downto 0);

           CLK_i : in  STD_LOGIC;
           RST_i : in  STD_LOGIC;
			  SEND_o : out STD_LOGIC;
           TX_o : out  STD_LOGIC);
end component;

signal s_reset : std_logic;
signal CLKFX, CLKFX180, CLKFXDV, dcmrst, clk2x : std_logic;
signal clkxx, ck1us, clkx, c1us : std_logic;
signal s_BAUD_CLK_BUF, s_BAUD_CLK : std_logic;
signal s_ccd_dis, s_ccd_clk, s_ccd_si : std_logic;
signal s_baud_clk_counter : integer range 0 to 15;
signal s_ILLUM_INT_o, s_ILLUM2_INT_o, s_BGND_INT_o, s_INIT_ILLUM_o, s_INIT_DIS_o, s_END_DIS_o : std_logic_vector(7 downto 0);
signal s_rx_data : std_logic_vector(7 downto 0);
begin

test(0) <= dcmrst;
test(1) <= led_reset;
test(2) <= c1us;
test(3) <= clkx;
test(4) <= ch1;
test(5) <= s_BAUD_CLK;
test(6) <= s_rx_data(0);
test(7) <= s_rx_data(1);
test(8) <= s_rx_data(2);
test(9) <= s_rx_data(3);
test(10) <= s_rx_data(4);
test(11) <= s_rx_data(5);
test(12) <= s_rx_data(6);
test(13) <= s_rx_data(7);

dcmrst<= not led_reset;
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------

   -- DCM_CLKGEN: Frequency Aligned Digital Clock Manager
   --             Spartan-6
   -- Xilinx HDL Language Template, version 12.1

   DCM_CLKGEN_inst : DCM_CLKGEN
   generic map (
      CLKFXDV_DIVIDE => 2,       -- CLKFXDV divide value (2, 4, 8, 16, 32)
      CLKFX_DIVIDE => 1,         -- Divide value - D - (1-256)
      CLKFX_MD_MAX => 3.0,       -- Specify maximum M/D ratio for timing anlysis
      CLKFX_MULTIPLY => 3,       -- Multiply value - M - (2-256)
      CLKIN_PERIOD => 23.0,       -- Input clock period specified in nS
      SPREAD_SPECTRUM => "NONE", -- Spread Spectrum mode "NONE", "CENTER_LOW_SPREAD" or "CENTER_HIGH_SPREAD" 
      STARTUP_WAIT => FALSE      -- Delay config DONE until DCM LOCKED (TRUE/FALSE)
   )
   port map (
      CLKFX => CLKFX,         -- 1-bit Generated clock output
      CLKFX180 => CLKFX180,   -- 1-bit Generated clock output 180 degree out of phase from CLKFX.
      CLKFXDV => CLKFXDV,     -- 1-bit Divided clock output
      LOCKED => open, --test(1),      -- 1-bit Locked output
      PROGDONE => open,		   -- 1-bit Active high output to indicate the successful re-programming
      STATUS => open,  		   -- 2-bit DCM status
      CLKIN => CLK37,         -- 1-bit Input clock
      FREEZEDCM => '0', 			-- 1-bit Prevents frequency adjustments to input clock
      PROGCLK => '0', 				-- 1-bit Clock input for M/D reconfiguration
      PROGDATA => '0', 				-- 1-bit Serial data input for M/D reconfiguration
      PROGEN => '0', 				-- 1-bit Active high program enable
      RST => dcmrst 					-- 1-bit Reset input pin
   );

   -- End of DCM_inst instantiation
   BUFG_inst : BUFG
   port map ( O => clk2x,  I => clkfx); -- 3 * 37.5= 112.5MHz
-----------------------------------------------------------------------------------------
   process (clk2x,dcmrst) -- clock generation with 112.5MHz
	variable dv1a,dv2,dv3,dv4: integer range 0 to 15 := 0;
	variable dv1: integer range 0 to 63 := 0;
	begin
	  if dcmrst='1' then
	     dv1:=0; dv3:=0;
		  clkx<='0';
		  c1us<='0';
	  elsif rising_edge(clk2x) then
	  
		  dv3:=dv3+1; 
		  if (dv3=s_ILLUM_INT_o) and (clkx='0') then dv3:=0; clkx<='1'; end if;-- 9.375MHz
		  if (dv3=s_ILLUM_INT_o) and (clkx='1') then dv3:=0; clkx<='0'; end if;--

		  dv1:=dv1+1; 
		  if (dv1=55) and (c1us='0') then dv1:=0; c1us<='1'; end if;-- 1.0046MHz
		  if (dv1=57) and (c1us='1') then dv1:=0; c1us<='0'; end if;--

	  end if;
	end process;

--   BUFG_1u : BUFG
--   port map ( O => c1us,  I => ck1us); -- 1.0046MHz
--	BUFG_x : BUFG
--   port map ( O => clkx,  I => clkxx); -- 9.375MHz
	
	process (c1us, led_reset, ch1)
	begin
		if rising_edge(c1us) then
		--------------------------------------
		-- Baud clock generation (38400 Hz) --
		--------------------------------------
			if ((not(led_reset) or not(ch1)) = '1') then

				s_BAUD_CLK <= '0';
				s_baud_clk_counter <= 0;

			else
			
				if (s_baud_clk_counter = 12) then
					s_baud_clk_counter <= 0;
					s_BAUD_CLK <= not(s_BAUD_CLK);
				else
					s_baud_clk_counter <= s_baud_clk_counter + 1;
				end if;
				
			end if;
		 end if;
		 
	end process;
	
--   BUFG_BAUD_CLK : BUFG
--   port map ( O => s_BAUD_CLK,  I => s_BAUD_CLK_BUF); -- 38400Hz
	
-------------------------------------------------------------------------------------------------------------------
s_reset <= (not(led_reset) or not(ch1));

i_DESERIALIZER : DESERIALIZER 
    Port map( 	RX_i => TEST(15),
					CLK_i => c1us,
					BAUD_CLK_i => s_BAUD_CLK,
					RESET_i => s_reset,
			  
					ILLUM_INT_o => s_ILLUM_INT_o,
					ILLUM2_INT_o => s_ILLUM2_INT_o,
					BGND_INT_o => s_BGND_INT_o,
					INIT_ILLUM_o => s_INIT_ILLUM_o,
					INIT_DIS_o => s_INIT_DIS_o,
					END_DIS_o => s_END_DIS_o 
				);

i_IMAGE_CONTROL : IMAGE_CONTROL 
    Port map( 	ILLUM_INT_i => s_ILLUM2_INT_o,
					ILLUM2_INT_i => s_ILLUM2_INT_o,
					BGND_INT_i => s_BGND_INT_o,
					INIT_ILLUM_i => s_INIT_ILLUM_o,
					INIT_DIS_i => s_INIT_DIS_o,
					END_DIS_i => s_END_DIS_o,
			  
					CLK_i => clkx,
					RST_i => s_reset,
			  
					CCD_DIS_o => s_ccd_dis,
					CCD_CLK_o => s_ccd_clk,
					CCD_SI_o => s_ccd_si,
			  
					FLED_o => FLEDA,
					RLED_o => RLEDA,
					BGND_o => EN_BACK
           );
			  
CCD_DIS1 <= s_ccd_dis;
CCD_DIS2 <= s_ccd_dis;
CCD_DIS3 <= s_ccd_dis;
CCD_DIS4 <= s_ccd_dis;

CCD_CLK1 <= s_ccd_clk;
CCD_CLK2 <= s_ccd_clk;
CCD_CLK3 <= s_ccd_clk;
CCD_CLK4 <= s_ccd_clk;

CCD_SI1 <= s_ccd_si;
CCD_SI2 <= s_ccd_si;
CCD_SI3 <= s_ccd_si;
CCD_SI4 <= s_ccd_si;

FLEDB <= '0';
FLEDC <= '0';
FLEDD <= '0';

RLEDB <= '0';
RLEDC <= '0';
RLEDD <= '0';
			  
i_STATUS_SENDER : STATUS_SENDER 
    Port map( 	PACK_8BIT_0 => s_ILLUM_INT_o,
					PACK_8BIT_1 => s_ILLUM2_INT_o,
					PACK_8BIT_2 => s_BGND_INT_o,
					PACK_8BIT_3 => s_INIT_ILLUM_o,
					PACK_8BIT_4 => s_INIT_DIS_o,
					PACK_8BIT_5 => s_END_DIS_o,
					
					CLK_i => s_BAUD_CLK,
					RST_i => s_reset,
					SEND_o => open,
					TX_o => test(14)
				);

end Behavioral;