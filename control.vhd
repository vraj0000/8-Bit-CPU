library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


--Control Word ranges
-- Range DA(15:13)
-- Range AA(12:10)
-- Range BA(9:7)
-- Range MB(6)
-- Range FS(5:2)
-- Range MD(1)
-- Range RW(0)

entity control is
port(
	CLK, GO: in std_logic;
	AR : out std_logic_vector(5 downto 0);
	RD : out std_logic
);
end entity;

architecture BEHAVIORAL of control is

signal counter, counterx: std_logic_vector(5 downto 0) := B"000000";
signal RD_i : std_logic;

begin
	process(CLK, GO)
	begin
		if (rising_edge(CLK)) then
			if (GO = '1') then
				counter <= counter + 1;
			end if;
		end if;
	end process;
	process(GO,counter)
	begin
		if (GO ='1') then
			RD_i <= '1';
			counterx <= counter;
		else 
			RD_i <= '0';
			counterx <= "XXXXXX";
		end if;
	end process;

RD <= RD_i;
AR <= counterx;		
end architecture BEHAVIORAL;