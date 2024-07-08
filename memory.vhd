library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity memory is
  port ( address : in std_logic_vector(5 downto 0);
         data : out std_logic_vector(15 downto 0);
			RD : in std_logic);
end entity;

architecture behavioral of memory is
  type mem is array ( 0 to 2**3 - 1) of std_logic_vector(15 downto 0);
  constant my_Rom : mem := (
    0  => "0010100110010101",
    1  => "1000001100111001",
    2  => "1111110000000101",
    3  => "0010000001001001",
    4  => "0000000110000000",
    5  => "1000000000000011",
	 6  => "1010000000101001",
	 7  => "XXXXXXXXXXXXXXXX");
begin
   process (address)
   begin
	if (RD = '1') then
     case address is
       when "000000" => data <= my_rom(0);
       when "000001" => data <= my_rom(1);
       when "000010" => data <= my_rom(2);
       when "000011" => data <= my_rom(3);
       when "000100" => data <= my_rom(4);
       when "000101" => data <= my_rom(5);
		 when "000110" => data <= my_rom(6);
		 when "000111" => data <= my_rom(7);
       when others => data <= "0000000000000000";
	 end case;
	end if;
  end process;
end architecture behavioral;


