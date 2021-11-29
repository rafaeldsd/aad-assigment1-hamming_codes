library ieee;
use ieee.std_logic_1164.all;

entity hamming_decoder is
    port(   y:          in std_logic_vector(14 downto 0);
            p:          out std_logic_vector(10 downto 0)
    );
end hamming_decoder;

architecture structural of hamming_decoder is

component gateXor2 is
        port(	x1: in 	std_logic;
                x2: in 	std_logic;
                y:	out	std_logic);
end component;

component gateXNor2 is
	port(	x1: in 	std_logic;
		x2: in 	std_logic;
		y: out	std_logic);
end component;
    
component gateAnd4 is
        port(	x1: in std_logic;
                x2: in std_logic;
                x3: in std_logic;
                x4: in std_logic;
                y: out std_logic);
end component;

-- parity check

signal s_xor_a: std_logic_vector(5 downto 0);
signal s_xnor_a: std_logic;

signal s_xor_b: std_logic_vector(5 downto 0);
signal s_xnor_b: std_logic;

signal s_xor_c: std_logic_vector(5 downto 0);
signal s_xnor_c: std_logic;

signal s_xor_d: std_logic_vector(5 downto 0);
signal s_xnor_d: std_logic;

signal s_matrix_and : std_logic_vector(10 downto 0);


begin
--general note: y1,    y2,    y3,    y4,    y5,    y6,   y7,   y8,   y9,   y10,  y11,  y12,  y13,  y14,  y15
--              y(14), y(13), y(12), y(11), y(10), y(9), y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1), y(0)

-- p1: y1 ⊕ y2 ⊕ y3 ⊕ y7 ⊕ y8 ⊕ y9 ⊕ y11 ⊕ y12
xor1a: gateXor2 	port map (y(14), y(13), s_xor_a(0)); 			
xor2a: gateXor2 	port map (s_xor_a(0), y(12), s_xor_a(1)); 	
xor3a: gateXor2 	port map (s_xor_a(1), y(8), s_xor_a(2)); 
xor4a: gateXor2 	port map (s_xor_a(2), y(7), s_xor_a(3)); 
xor5a: gateXor2 	port map (s_xor_a(3), y(6), s_xor_a(4)); 	
xor6a: gateXor2 	port map (s_xor_a(4), y(4), s_xor_a(5)); 
xnora: gateXnor2        port map (s_xor_a(5), y(3), s_xnor_a); 
    
-- p2: y1 ⊕ y4 ⊕ y5 ⊕ y7 ⊕ y8 ⊕ y10 ⊕ y11 ⊕ y13
xor1b: gateXor2 	port map (y(14), y(11), s_xor_b(0)); 			
xor2b: gateXor2 	port map (s_xor_b(0), y(10), s_xor_b(1)); 	
xor3b: gateXor2 	port map (s_xor_b(1), y(8), s_xor_b(2)); 
xor4b: gateXor2 	port map (s_xor_b(2), y(7), s_xor_b(3)); 
xor5b: gateXor2 	port map (s_xor_b(3), y(5), s_xor_b(4)); 	
xor6b: gateXor2 	port map (s_xor_b(4), y(4), s_xor_b(5)); 
xnorb: gateXnor2        port map (s_xor_b(5), y(2), s_xnor_b);

-- p3: y2 ⊕ y4 ⊕ y6 ⊕ y7 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y14
xor1c: gateXor2 	port map (y(13), y(11), s_xor_c(0)); 			
xor2c: gateXor2 	port map (s_xor_c(0), y(9), s_xor_c(1)); 	
xor3c: gateXor2 	port map (s_xor_c(1), y(8), s_xor_c(2)); 
xor4c: gateXor2 	port map (s_xor_c(2), y(6), s_xor_c(3)); 
xor5c: gateXor2 	port map (s_xor_c(3), y(5), s_xor_c(4)); 	
xor6c: gateXor2 	port map (s_xor_c(4), y(4), s_xor_c(5)); 
xnorc: gateXnor2        port map (s_xor_c(5), y(1), s_xnor_c);

-- p4: y3 ⊕ y5 ⊕ y6 ⊕ y8 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y15
xor1d: gateXor2 	port map (y(12), y(10), s_xor_d(0)); 			
xor2d: gateXor2 	port map (s_xor_d(0), y(9), s_xor_d(1)); 	
xor3d: gateXor2 	port map (s_xor_d(1), y(7), s_xor_d(2)); 
xor4d: gateXor2 	port map (s_xor_d(2), y(6), s_xor_d(3)); 
xor5d: gateXor2 	port map (s_xor_d(3), y(5), s_xor_d(4)); 	
xor6d: gateXor2 	port map (s_xor_d(4), y(4), s_xor_d(5)); 
xnord: gateXnor2        port map (s_xor_d(5), y(0), s_xnor_d);

-- H matrix = || A | I4 ||  

-- 1 1 1 0 0 0 1 1 1 0 1  | 1 0 0 0
-- 1 0 0 1 1 0 1 1 0 1 1  | 0 1 0 0
-- 0 1 0 1 0 1 1 0 1 1 1  | 0 0 1 0
-- 0 0 1 0 1 1 0 1 1 1 1  | 0 0 0 1

matrix_and1 : 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, s_xnor_c, s_xnor_d, s_and(0)); 	
matrix_and2 : 	gateAnd4 port map (not s_xnor_a, s_xnor_b, not s_xnor_c, s_xnor_d, s_and(1)); 	
matrix_and3 : 	gateAnd4 port map (not s_xnor_a, s_xnor_b, s_xnor_c, not s_xnor_d, s_and(2));
matrix_and4 : 	gateAnd4 port map (s_xnor_a, not s_xnor_b, not s_xnor_c, s_xnor_d, s_and(3)); 	
matrix_and5 : 	gateAnd4 port map (not s_xnor_a, s_xnor_b, not s_xnor_c, s_xnor_d, s_and(4));
matrix_and6 : 	gateAnd4 port map ( s_xnor_a, s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(5)); 	
matrix_and7 : 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, not s_xnor_c, s_xnor_d, s_and(6)); 	
matrix_and8 : 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, s_xnor_c, not s_xnor_d, s_and(7)); 	
matrix_and9 :	gateAnd4 port map (not s_xnor_a, s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(8));
matrix_and10 : 	gateAnd4 port map (s_xnor_a, not s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(9));
matrix_and11 : 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(10)); 	


-- 1-bit error correction
-- mli = seli(p) ⊕ yi, for i = 1,2 , ⋯ 11
last_xor_1: 	gateXor2 port map (y(14), s_and(0), p(10));
last_xor_2: 	gateXor2 port map (y(13), s_and(1), p(9));
last_xor_3: 	gateXor2 port map (y(12), s_and(2), p(8));
last_xor_4: 	gateXor2 port map (y(11), s_and(3), p(7));
last_xor_5: 	gateXor2 port map (y(10), s_and(4), p(6));
last_xor_6: 	gateXor2 port map (y(9), s_and(5), p(5));
last_xor_7: 	gateXor2 port map (y(8), s_and(6), p(4));
last_xor_8: 	gateXor2 port map (y(7), s_and(7), p(3));
last_xor_9: 	gateXor2 port map (y(6), s_and(8), p(2));
last_xor_10:     gateXor2 port map (y(5), s_and(9), p(1));
last_xor_11:     gateXor2 port map (y(4), s_and(10), p(0));

end structural;