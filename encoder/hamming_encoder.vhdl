LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity encoder is
	port(	clk: in std_logic;
			nRst: in std_logic;
			dIn: in std_logic;
			dOut: out std_logic;
			controlbits: out std_logic_vector(6 downto 0));
end encoder;
architecture Structural of encoder is

signal s_dIn, s_dOut, s_clk, s_nDOut : std_logic;
signal s_andOut1, s_andOut2, s_andOut3, s_andOut4, s_flipOut1, s_flipOut2, s_flipOut3, s_flipOut4, s_xorOut1, s_xorOut2, s_xorOut3, s_xorOut4 : std_logic;
signal s_mux4Out, s_mux2Out;
signal s_rom : std_logic_vector(6 downto 0);


component gateAnd2 is
    port(	x1, x2: in std_logic;
            y: out std_logic);
end component;

component gateNand2 is
    port(	x1, x2: in std_logic;
            y: out std_logic);
end component;

component gateNor2 is
    port(	x1, x2: in std_logic;
            y: out std_logic);
end component;

component gateXor2 is
    port(	x1, x2: in std_logic;
            y: out std_logic);
end component;

component gateMux2 is
    port (  x1, x2: in std_logic;
            sel:    in std_logic;
            y:      out std_logic);
end component;

component gateMux4 is
    port (  x1, x2, x3, x4: in std_logic;
            sel:    in std_logic_VECTOR(1 downto 0);
            y:      out std_logic);
end component;

component FlipFlopD is
  PORT (clk, D:     in std_logic;
        nSet, nRst: in std_logic;
        Q, nQ:      out std_logic);
end component;

component FlipFlopD_4 is
	port(	clk: in std_logic;
			nSet, nRst: std_logic;
			I1, I2, I3, I4: in std_logic;
			O1, O2, O3, O4: out std_logic);
end component;

begin

    ControlUnit : control port map (s_clk, nRst, s_rom);

    and1: gateAnd2 port map (s_dIn,s_rom(6),s_andOut1);
	and2: gateAnd2 port map (s_dIn,s_rom(5),s_andOut2);
	and3: gateAnd2 port map (s_dIn,s_rom(4),s_andOut3);
	and4: gateAnd2 port map (s_dIn,s_rom(3),s_andOut4);
	
	xor1: gateXor2 port map (s_andOut1,s_flipOut1,s_xorOut1);
	xor2: gateXor2 port map (s_andOut2,s_flipOut2,s_xorOut2);
	xor3: gateXor2 port map (s_andOut3,s_flipOut3,s_xorOut3);
	xor4: gateXor2 port map (s_andOut4,s_flipOut4,s_xorOut4);

    flipFlops: FlipFlopD_4 port map (s_clk,'1',nRst,s_xorOut1,s_xorOut2,s_xorOut3,s_xorOut4,s_flipOut1,s_flipOut2,s_flipOut3,s_flipOut4);

    mux4: gateMux4 port map (s_flipOut1, s_flipOut2, s_flipOut3, s_flipOut4, s_rom(1) & s_rom(0), s_mux4Out);

    mux2: gateMux2 port map (s_dIn, s_mux4Out, s_mux2Out);

    flipFlopEnd: FlipFlopD port map(s_clk,'1',nRst,s_dOut,s_nDOut);

    s_clk <= clk;
	s_dIn <= dIn;
	dOut <= s_dOut;
    controlbits <= s_rom(6) & s_rom(5) & s_rom(4) & s_rom(3) & s_rom(2) & s_rom(1) & s_rom(0);

end Structural;