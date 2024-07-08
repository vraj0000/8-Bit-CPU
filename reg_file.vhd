library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity reg_file is
port(
	DA, AA, BA: in std_logic_vector(2 downto 0);
	RW: in std_logic;
	CLK: in std_logic;
	DATA: in std_logic_vector(7 downto 0);
	A_data, B_data: out std_logic_vector(7 downto 0)
);
end entity;

architecture BEHAVIORAL of reg_file is
signal R0 : std_logic_vector(7 downto 0) := B"00000000";
signal R1 : std_logic_vector(7 downto 0) := B"00000001";
signal R2 : std_logic_vector(7 downto 0) := B"00000010";
signal R3 : std_logic_vector(7 downto 0) := B"00000011";
signal R4 : std_logic_vector(7 downto 0) := B"00000100";
signal R5 : std_logic_vector(7 downto 0) := B"00000101";
signal R6 : std_logic_vector(7 downto 0) := B"00000110";
signal R7 : std_logic_vector(7 downto 0) := B"00000111";

begin


	process (AA)
	begin
			case AA is 
				when "000" => A_data <= R0;
				when "001" => A_data <= R1;
				when "010" => A_data <= R2;
				when "011" => A_data <= R3;
				when "100" => A_data <= R4;
				when "101" => A_data <= R5;
				when "110" => A_data <= R6;
				when others => A_data <= R7;
			end case;
	end process;

	process (BA)
	begin
			case BA is 
				when "000" => B_data <= R0;
				when "001" => B_data <= R1;
				when "010" => B_data <= R2;
				when "011" => B_data <= R3;
				when "100" => B_data <= R4;
				when "101" => B_data <= R5;
				when "110" => B_data <= R6;
				when others => B_data <= R7;
			end case;
	end process;


	process (DA, CLK)
	begin
		if (rising_edge(CLK) and RW = '1') then
			case DA is 
				when "000" => R0 <= DATA;
				when "001" => R1 <= DATA;
				when "010" => R2 <= DATA;
				when "011" => R3 <= DATA;
				when "100" => R4 <= DATA;
				when "101" => R5 <= DATA;
				when "110" => R6 <= DATA;
				when others => R7 <= DATA;
			end case;
		end if;
	end process;
end architecture BEHAVIORAL; 