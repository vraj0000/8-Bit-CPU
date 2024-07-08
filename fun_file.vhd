library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;


-- FS is the function select of the arthmatic opeation.
-- V, C, N, Z are the signal output for the ALU to control unit.
entity fun_file is
port(
	FS: in std_logic_vector(3 downto 0); -- Function Select
	V, C, N, Z: out  std_logic;				 -- Signal Out
	AF_data, BF_data: in std_logic_vector(7 downto 0); -- Function unit data input
	DF_data: out std_logic_Vector(7 downto 0) -- Function unit data output
);
end entity;

architecture BEHAVIORAL of fun_file is
begin

	process (FS, BF_data, AF_data)
	begin
			case FS is 
				when "0000" => DF_data <= AF_data;
				when "0001" => DF_data <= AF_data + 1;
				when "0010" => DF_data <= AF_data + BF_data;
				when "0011" => DF_data <= AF_data + BF_data + 1;
				when "0100" => DF_data <= AF_data + not(BF_data);
				when "0101" => DF_data <= AF_data + not(BF_data) + 1;
				when "0110" => DF_data <= AF_data - 1;
				when "0111" => DF_data <= AF_data;
				when "1000" => DF_data <= AF_data and BF_data;
				when "1001" => DF_data <= AF_data or BF_data;
				when "1010" => DF_data <= AF_data xor BF_data;
				when "1011" => DF_data <= not(AF_data);
				when "1100" => DF_data <= BF_data;
				when "1101" => DF_data <= '0' & BF_data(7 downto 1);
				when "1110" => DF_data <= BF_data(6 downto 0) & '0';
				when others => DF_data <= B"00000000";
			end case;
	end process;
	
end architecture BEHAVIORAL; 
