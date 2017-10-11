library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity ledc8x8 is
port ( -- Sem doplnte popis rozhrani obvodu.
		 SMCLK : in STD_LOGIC;
		 RESET : in STD_LOGIC;
		 ROW : out STD_LOGIC_VECTOR (7 downto 0);
		 LED : out STD_LOGIC_VECTOR (7 downto 0)
);
end ledc8x8;

architecture main of ledc8x8 is

    -- Sem doplnte definice vnitrnich signalu.
	 signal freq_counter : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	 signal row_signal : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
	 signal enable : STD_LOGIC := '0';

begin
    -- Sem doplnte popis obvodu. Doporuceni: pouzivejte zakladni obvodove prvky
    -- (multiplexory, registry, dekodery,...), jejich funkce popisujte pomoci
    -- procesu VHDL a propojeni techto prvku, tj. komunikaci mezi procesy,
    -- realizujte pomoci vnitrnich signalu deklarovanych vyse.

    -- DODRZUJTE ZASADY PSANI SYNTETIZOVATELNEHO VHDL KODU OBVODOVYCH PRVKU,
    -- JEZ JSOU PROBIRANY ZEJMENA NA UVODNICH CVICENI INP A SHRNUTY NA WEBU:
    -- http://merlin.fit.vutbr.cz/FITkit/docs/navody/synth_templates.html.

    -- Nezapomente take doplnit mapovani signalu rozhrani na piny FPGA
    -- v souboru ledc8x8.ucf.
	 counter: process (SMCLK, RESET)
	 begin
			if RESET = '1' then
					freq_counter <= "00000000";
					enable <= '0';
			elsif rising_edge (SMCLK) then
					if freq_counter = "11111111" then
							enable <= '1';
							freq_counter <= "00000000";
					else
							enable <= '0';
							freq_counter <= freq_counter + '1';
					end if;
			end if;
	 end process;
	 
	 rotation: process (SMCLK, RESET)
	 begin
			if RESET = '1' then
					row_signal <= "00000001";
			elsif rising_edge (SMCLK) and enable = '1' then
					case row_signal is
							when "00000001" => row_signal <= "00000010";
							when "00000010" => row_signal <= "00000100";
							when "00000100" => row_signal <= "00001000";
							when "00001000" => row_signal <= "00010000";
							when "00010000" => row_signal <= "00100000";
							when "00100000" => row_signal <= "01000000";
							when "01000000" => row_signal <= "10000000";
							when "10000000" => row_signal <= "00000001";
							when others => null;
					end case;
			end if;
			ROW <= row_signal;
	 end process;
	 
	 --indexovani ledek
	 --0 1 2...
	 --1 x x
	 --2 x x
	 --.
	 --.
	 --index   76543210
	 --signal "00000000"
	 
	 display: process (SMCLK)
	 begin
			if RESET = '1' then
					LED <= "11111111";
			elsif rising_edge (SMCLK) then
					case row_signal is
							when "00000010" | "00000100" | "00001000" | "00010000" => LED <= "01110111";
							when "00100000" => LED <= "01010101";
							when "01000000" => LED <= "10111011";
							when others => LED <= "11111111";
					end case;
			end if;
	  end process;
end main;
