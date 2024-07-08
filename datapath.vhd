library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

--Control Word ranges
-- Range DA(15:13)
-- Range AA(12:10)
-- Range BA(9:7)
-- Range MB(6)
-- Range FS(5:2)
-- Range MD(1)
-- Range RW(0)

entity datapath is
port(
	CONTROL_WORD: in std_logic_vector(15 downto 0);
	V, C, N, Z: out  std_logic;
	CLK: in std_logic;
	Constant_in : in std_logic_vector(7 downto 0);
	DATA_in: in std_logic_vector(7 downto 0);
	DATA_out: out std_logic_vector(7 downto 0)
);
end entity;

architecture BEHAVIORAL of datapath is

signal FS : std_logic_vector(3 downto 0);
signal DA : std_logic_vector(2 downto 0);
signal AA : std_logic_vector(2 downto 0);
signal BA : std_logic_vector(2 downto 0);
signal MB, MD, RW : std_logic;

signal A, B_mux, B, D_mux, D: std_logic_vector(7 downto 0);

component reg_file
	port(
		DA, AA, BA: in std_logic_vector(2 downto 0);
		RW: in std_logic;
		CLK: in std_logic;
		DATA: in std_logic_vector(7 downto 0);
		A_data, B_data: out std_logic_vector(7 downto 0)
	);
end component;

component fun_file
port(
	FS: in std_logic_vector(3 downto 0); -- Function Select
	V, C, N, Z: out  std_logic;				 -- Signal Out
	AF_data, BF_data: in std_logic_vector(7 downto 0); -- Function unit data input
	DF_data: out std_logic_Vector(7 downto 0) -- Function unit data output
);
end component;

	
begin

	DA <= CONTROL_WORD(15 downto 13);
	AA <= CONTROL_WORD(12 downto 10);
	BA <= CONTROL_WORD(9 downto 7);
	MB <= CONTROL_WORD(6);
	FS <= CONTROL_WORD(5 downto 2);
	MD <= CONTROL_WORD(1);
	RW <= CONTROL_WORD(0);

	process(MB,B)
	begin
		case MB is 
			when '1' => B_mux <= Constant_in;
			when others => B_mux <= B;
		end case;
	end process;
	
func_unit: fun_file port map (FS => FS, V => V, C => C, N => N, Z => Z, AF_data => A, BF_data => B_mux, DF_data => D);

reg_unit: reg_file port map (DA => DA, AA => AA, BA => BA, RW => RW, CLK => CLK, DATA => D_mux, A_data => A, B_data => B);

process(MD,D)
	begin
		case MD is 
			when '1' => D_mux <= DATA_in;
			when others => D_mux <= D;
		end case;
	end process;

process(RW)
	begin
		if (RW = '0') then
			DATA_OUT <= B_MUX;
		else
			DATA_OUT <= "00000000";
		end if;
	end process;
end architecture BEHAVIORAL; 