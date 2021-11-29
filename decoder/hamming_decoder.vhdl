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

signal s_and: std_logic_vector(10 downto 0);


begin
--general note: y1,    y2,    y3,    y4,    y5,    y6,   y7,   y8,   y9,   y10,  y11,  y12,  y13,  y14,  y15
--              y(14), y(13), y(12), y(11), y(10), y(9), y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1), y(0)

-- p1: y1 ⊕ y2 ⊕ y3 ⊕ y7 ⊕ y8 ⊕ y9 ⊕ y11 ⊕ y12
xor1_a: gateXor2 	port map (y(14), y(13), s_xor_a(0)); 			
xor2_a: gateXor2 	port map (s_xor_a(0), y(12), s_xor_a(1)); 	
xor3_a: gateXor2 	port map (s_xor_a(1), y(8), s_xor_a(2)); 
xor4_a: gateXor2 	port map (s_xor_a(2), y(7), s_xor_a(3)); 
xor5_a: gateXor2 	port map (s_xor_a(3), y(6), s_xor_a(4)); 	
xor6_a: gateXor2 	port map (s_xor_a(4), y(4), s_xor_a(5)); 
xnor_a: gateXnor2        port map (s_xor_a(5), y(3), s_xnor_a); 
    
-- p2: y1 ⊕ y4 ⊕ y5 ⊕ y7 ⊕ y8 ⊕ y10 ⊕ y11 ⊕ y13
xor1_b: gateXor2 	port map (y(14), y(11), s_xor_b(0)); 			
xor2_b: gateXor2 	port map (s_xor_b(0), y(10), s_xor_b(1)); 	
xor3_b: gateXor2 	port map (s_xor_b(1), y(8), s_xor_b(2)); 
xor4_b: gateXor2 	port map (s_xor_b(2), y(7), s_xor_b(3)); 
xor5_b: gateXor2 	port map (s_xor_b(3), y(5), s_xor_b(4)); 	
xor6_b: gateXor2 	port map (s_xor_b(4), y(4), s_xor_b(5)); 
xnor_b: gateXnor2        port map (s_xor_b(5), y(2), s_xnor_b);

-- p3: y2 ⊕ y4 ⊕ y6 ⊕ y7 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y14
xor1_c: gateXor2 	port map (y(13), y(11), s_xor_c(0)); 			
xor2_c: gateXor2 	port map (s_xor_c(0), y(9), s_xor_c(1)); 	
xor3_c: gateXor2 	port map (s_xor_c(1), y(8), s_xor_c(2)); 
xor4_c: gateXor2 	port map (s_xor_c(2), y(6), s_xor_c(3)); 
xor5_c: gateXor2 	port map (s_xor_c(3), y(5), s_xor_c(4)); 	
xor6_c: gateXor2 	port map (s_xor_c(4), y(4), s_xor_c(5)); 
xnor_c: gateXnor2        port map (s_xor_c(5), y(1), s_xnor_c);

-- p4: y3 ⊕ y5 ⊕ y6 ⊕ y8 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y15
xor1_d: gateXor2 	port map (y(12), y(10), s_xor_d(0)); 			
xor2_d: gateXor2 	port map (s_xor_d(0), y(9), s_xor_d(1)); 	
xor3_d: gateXor2 	port map (s_xor_d(1), y(7), s_xor_d(2)); 
xor4_d: gateXor2 	port map (s_xor_d(2), y(6), s_xor_d(3)); 
xor5_d: gateXor2 	port map (s_xor_d(3), y(5), s_xor_d(4)); 	
xor6_d: gateXor2 	port map (s_xor_d(4), y(4), s_xor_d(5)); 
xnor_d: gateXnor2        port map (s_xor_d(5), y(0), s_xnor_d);

-- H matrix = || A | I4 ||  

-- 1 1 1 0 0 0 1 1 1 0 1  | 1 0 0 0
-- 1 0 0 1 1 0 1 1 0 1 1  | 0 1 0 0
-- 0 1 0 1 0 1 1 0 1 1 1  | 0 0 1 0
-- 0 0 1 0 1 1 0 1 1 1 1  | 0 0 0 1

and1: 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, s_xnor_c, s_xnor_d, s_and(0)); 	
and2: 	gateAnd4 port map (not s_xnor_a, s_xnor_b, not s_xnor_c, s_xnor_d, s_and(1)); 	
and3: 	gateAnd4 port map (not s_xnor_a, s_xnor_b, s_xnor_c, not s_xnor_d, s_and(2));
and4: 	gateAnd4 port map (s_xnor_a, not s_xnor_b, not s_xnor_c, s_xnor_d, s_and(3)); 	
and5: 	gateAnd4 port map (not s_xnor_a, s_xnor_b, not s_xnor_c, s_xnor_d, s_and(4));
and6: 	gateAnd4 port map ( s_xnor_a, s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(5)); 	
and7: 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, not s_xnor_c, s_xnor_d, s_and(6)); 	
and8: 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, s_xnor_c, not s_xnor_d, s_and(7)); 	
and9:	gateAnd4 port map (not s_xnor_a, s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(8));
and10: 	gateAnd4 port map (s_xnor_a, not s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(9));
and11: 	gateAnd4 port map (not s_xnor_a, not s_xnor_b, not s_xnor_c, not s_xnor_d, s_and(10)); 	


-- 1-bit error correction
-- mli = seli(p) ⊕ yi, for i = 1,2 , ⋯ 11
xor_last1: 	gateXor2 port map (y(14), s_and(0), p(10));
xor_last2: 	gateXor2 port map (y(13), s_and(1), p(9));
xor_last3: 	gateXor2 port map (y(12), s_and(2), p(8));
xor_last4: 	gateXor2 port map (y(11), s_and(3), p(7));
xor_last5: 	gateXor2 port map (y(10), s_and(4), p(6));
xor_last6: 	gateXor2 port map (y(9), s_and(5), p(5));
xor_last7: 	gateXor2 port map (y(8), s_and(6), p(4));
xor_last8: 	gateXor2 port map (y(7), s_and(7), p(3));
xor_last9: 	gateXor2 port map (y(6), s_and(8), p(2));
xor_last10:     gateXor2 port map (y(5), s_and(9), p(1));
xor_last11:     gateXor2 port map (y(4), s_and(10), p(0));

end structural;