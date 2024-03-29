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
    
component gateAnd4 is
        port(	x1: in std_logic;
                x2: in std_logic;
                x3: in std_logic;
                x4: in std_logic;
                y: out std_logic);
end component;

-- parity check

signal s_xor_a, s_xor_b, s_xor_c, s_xor_d: std_logic_vector(3 downto 0);

signal s_matrix_and : std_logic_vector(10 downto 0);

signal s_a : std_logic_vector(2 downto 0);
signal s_b : std_logic_vector(2 downto 0);


begin

-- p1: y1 ⊕ y2 ⊕ y3 ⊕ y7 ⊕ y8 ⊕ y9 ⊕ y11 ⊕ y12
-- p2: y1 ⊕ y4 ⊕ y5 ⊕ y7 ⊕ y8 ⊕ y10 ⊕ y11 ⊕ y13
-- p3: y2 ⊕ y4 ⊕ y6 ⊕ y7 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y14
-- p4: y3 ⊕ y5 ⊕ y6 ⊕ y8 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y15


-- A <= y(14) XOR y(8) XOR y(7) XOR y(4);
-- B <= y(9) XOR y(6) XOR y(5) XOR y(4);

s_a1: gateXor2 	port map (y(14), y(8), s_a(0));
s_a2: gateXor2  port map (s_a(0), y(7), s_a(1));
s_a3: gateXor2  port map (s_a(1), y(4), s_a(2));

s_b1: gateXor2 	port map (y(9), y(6), s_b(0));
s_b2: gateXor2  port map (s_b(0), y(5), s_b(1));
s_b3: gateXor2  port map (s_b(1), y(4), s_b(2));
 			
-- y1,    y2,    y3,    y4,    y5,    y6,   y7,   y8,   y9,   y10,  y11,  y12,  y13,  y14,  y15
-- y(14), y(13), y(12), y(11), y(10), y(9), y(8), y(7), y(6), y(5), y(4), y(3), y(2), y(1), y(0)

-- p1: A ⊕ y2 ⊕ y3 ⊕ y9 ⊕ y12
xor1a: gateXor2 	port map (s_a(2), y(13), s_xor_a(0)); 			
xor2a: gateXor2 	port map (s_xor_a(0), y(12), s_xor_a(1)); 	
xor3a: gateXor2 	port map (s_xor_a(1), y(6), s_xor_a(2)); 	
xor4a: gateXor2         port map (s_xor_a(2), y(3), s_xor_a(3)); 
    
-- p2: A ⊕ y4 ⊕ y5 ⊕ y10 ⊕ y13
xor1b: gateXor2 	port map (s_a(2), y(11), s_xor_b(0)); 			
xor2b: gateXor2 	port map (s_xor_b(0), y(10), s_xor_b(1)); 	
xor3b: gateXor2 	port map (s_xor_b(1), y(5), s_xor_b(2)); 	
xor4b: gateXor2         port map (s_xor_b(2), y(2), s_xor_b(3));

-- p3: B ⊕ y2 ⊕ y4 ⊕ y7 ⊕ y14
xor1c: gateXor2 	port map (s_b(2), y(13), s_xor_c(0)); 			
xor2c: gateXor2 	port map (s_xor_c(0), y(11), s_xor_c(1)); 			
xor3c: gateXor2 	port map (s_xor_c(1), y(8), s_xor_c(2)); 
xor4c: gateXor2         port map (s_xor_c(2), y(1), s_xor_c(3));

-- p4: B ⊕ y3 ⊕ y5 ⊕ y8 ⊕ y15
xor1d: gateXor2 	port map (s_b(2), y(12), s_xor_d(0)); 			
xor2d: gateXor2 	port map (s_xor_d(0), y(10), s_xor_d(1)); 			
xor3d: gateXor2 	port map (s_xor_d(1), y(7), s_xor_d(2)); 
xor4d: gateXor2         port map (s_xor_d(2), y(0), s_xor_d(3));

-- H matrix = || A | I4 ||  

-- 1 1 1 0 0 0 1 1 1 0 1  | 1 0 0 0
-- 1 0 0 1 1 0 1 1 0 1 1  | 0 1 0 0
-- 0 1 0 1 0 1 1 0 1 1 1  | 0 0 1 0
-- 0 0 1 0 1 1 0 1 1 1 1  | 0 0 0 1

matrix_and1 : 	gateAnd4 port map (s_xor_a(3)           , s_xor_b(3)            , not s_xor_c(3)        , not s_xor_d(3)        , s_matrix_and(0)); 	
matrix_and2 : 	gateAnd4 port map (s_xor_a(3)           , not s_xor_b(3)        , s_xor_c(3)            , not s_xor_d(3)        , s_matrix_and(1)); 	
matrix_and3 : 	gateAnd4 port map (s_xor_a(3)           , not s_xor_b(3)        , not s_xor_c(3)        , s_xor_d(3)            , s_matrix_and(2));
matrix_and4 : 	gateAnd4 port map (not s_xor_a(3)       , s_xor_b(3)            , s_xor_c(3)            , not s_xor_d(3)        , s_matrix_and(3)); 	
matrix_and5 : 	gateAnd4 port map (not s_xor_a(3)       , s_xor_b(3)            , not s_xor_c(3)        , s_xor_d(3)            , s_matrix_and(4));
matrix_and6 : 	gateAnd4 port map (not s_xor_a(3)       , not s_xor_b(3)        , s_xor_c(3)            , s_xor_d(3)            , s_matrix_and(5)); 	
matrix_and7 : 	gateAnd4 port map (s_xor_a(3)           , s_xor_b(3)            , s_xor_c(3)            , not s_xor_d(3)        , s_matrix_and(6)); 	
matrix_and8 : 	gateAnd4 port map (s_xor_a(3)           , s_xor_b(3)            , not s_xor_c(3)        , s_xor_d(3)            , s_matrix_and(7)); 	
matrix_and9 :	gateAnd4 port map (s_xor_a(3)           , not s_xor_b(3)        , s_xor_c(3)            , s_xor_d(3)            , s_matrix_and(8));
matrix_and10 : 	gateAnd4 port map (not s_xor_a(3)       , s_xor_b(3)            , s_xor_c(3)            , s_xor_d(3)            , s_matrix_and(9));
matrix_and11 : 	gateAnd4 port map (s_xor_a(3)           , s_xor_b(3)            , s_xor_c(3)            , s_xor_d(3)            , s_matrix_and(10)); 	


-- 1-bit error correction
-- mli = seli(p) ⊕ yi, for i = 1,2 , ⋯ 11
last_xor_1: 	gateXor2 port map (y(14), s_matrix_and(0), p(10));
last_xor_2: 	gateXor2 port map (y(13), s_matrix_and(1), p(9));
last_xor_3: 	gateXor2 port map (y(12), s_matrix_and(2), p(8));
last_xor_4: 	gateXor2 port map (y(11), s_matrix_and(3), p(7));
last_xor_5: 	gateXor2 port map (y(10), s_matrix_and(4), p(6));
last_xor_6: 	gateXor2 port map (y(9), s_matrix_and(5), p(5));
last_xor_7: 	gateXor2 port map (y(8), s_matrix_and(6), p(4));
last_xor_8: 	gateXor2 port map (y(7), s_matrix_and(7), p(3));
last_xor_9: 	gateXor2 port map (y(6), s_matrix_and(8), p(2));
last_xor_10:    gateXor2 port map (y(5), s_matrix_and(9), p(1));
last_xor_11:    gateXor2 port map (y(4), s_matrix_and(10), p(0));

end structural;