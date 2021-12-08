LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity counter is
	port(	clk: in std_logic;
			nRst: in std_logic;
			counterout: out std_logic_vector(3 downto 0));
end counter;
architecture structural of counter is

component FlipFlopD is
	port (	clk, D: IN STD_LOGIC;
        	nSet, nRst: IN STD_LOGIC;
        	Q, nQ: OUT STD_LOGIC);
end component;

signal S_Q1, S_Q2, S_Q3, S_Q4 : STD_LOGIC;
begin
	FlipFlopD1: FlipFlopD port map (clk,S_Q1,'1',nRst,counterout(0),S_Q1);
	FlipFlopD2: FlipFlopD port map (s_Q1,S_Q2,'1',nRst,counterout(1),S_Q2);
	FlipFlopD3: FlipFlopD port map (s_Q2,S_Q3,'1',nRst,counterout(2),S_Q3);
	FlipFlopD4: FlipFlopD port map (s_Q3,S_Q4,'1',nRst,counterout(3),S_Q4);
end structural;