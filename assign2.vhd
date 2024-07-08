library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity assign2 is
port(
	CLK, GO: in std_logic;
	Data_out: out std_logic_vector(7 downto 0);
	con_in: in std_logic_vector(7 downto 0);
	data_in: in std_logic_vector(7 downto 0)
);
end entity;

architecture BEHAVIORAL of assign2 is
component memory
port ( 
	address : in std_logic_vector(5 downto 0);
	data : out std_logic_vector(15 downto 0);
	RD : in std_logic
);
end component;

component control
port(
	CLK, GO: in std_logic;
	AR : out std_logic_vector(5 downto 0);
	RD : out std_logic
);
end component;

component datapath is
port(
	CONTROL_WORD: in std_logic_vector(15 downto 0);
	V, C, N, Z: out  std_logic;
	CLK: in std_logic;
	Constant_in : in std_logic_vector(7 downto 0);
	DATA_in: in std_logic_vector(7 downto 0);
	DATA_out: out std_logic_vector(7 downto 0)
);
end component;

signal address: std_logic_vector(5 downto 0);
signal control_word: std_logic_vector( 15 downto 0);
signal RD_I: std_logic;
signal V,C,N,Z: std_logic;

begin

control1: control port map(CLK => CLK, GO => GO, AR => address, RD => RD_I);
memory1: memory port map(address => address, data => control_word, RD => RD_I);
datapath1: datapath port map(CONTROL_WORD => control_word, V => V, C => C, N => N, Z => Z,
									  CLK => CLK, Constant_in => con_in, DATA_IN => data_in, DATA_out => Data_out);

end architecture BEHAVIORAL;