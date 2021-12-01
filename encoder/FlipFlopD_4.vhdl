LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity FlipFlopD_4 is
	port(	clk: in std_logic;
			nSet, nRst: std_logic;
			sIn1, sIn2, sIn3, sIn4: in std_logic;
			out1, out2, out3, out4: out std_logic);
end FlipFlopD_4;

architecture structural of FlipFlopD_4 is
component flipFlopD is
	port (clk, D: IN STD_LOGIC;
        nSet, nRst: IN STD_LOGIC;
        Q, nQ: OUT STD_LOGIC);
end component;
signal s_nQ : std_logic;
begin
	ffD1: flipFlopDSimul port map (clk,sIn1,nSet,nRst,out1,s_nQ);
	ffD2: flipFlopDSimul port map (clk,sIn2,nSet,nRst,out2,s_nQ);
	ffD3: flipFlopDSimul port map (clk,sIn3,nSet,nRst,out3,s_nQ);
	ffD4: flipFlopDSimul port map (clk,sIn4,nSet,nRst,out4,s_nQ);
end structural;