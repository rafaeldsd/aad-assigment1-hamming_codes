LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity FlipFlopD_4 is
	port(	clk: in std_logic;
			nSet, nRst: std_logic;
			I1, I2, I3, I4: in std_logic;
			O1, O2, O3, O4: out std_logic);
end FlipFlopD_4;

architecture structural of FlipFlopD_4 is
component flipFlopD is
	port (clk, D: IN STD_LOGIC;
        nSet, nRst: IN STD_LOGIC;
        Q, nQ: OUT STD_LOGIC);
end component;
signal nQ : std_logic;
begin
	FlipFlopD1: FlipFlopD port map (clk,I1,nSet,nRst,O1,nQ);
	FlipFlopD2: FlipFlopD port map (clk,I2,nSet,nRst,O2,nQ);
	FlipFlopD3: FlipFlopD port map (clk,I3,nSet,nRst,O3,nQ);
	FlipFlopD4: FlipFlopD port map (clk,I4,nSet,nRst,O4,nQ);
end structural;