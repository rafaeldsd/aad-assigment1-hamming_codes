library ieee;
use ieee.std_logic_1164.all;

entity hamming_decoder is
    port(   y:          in std_logic_vectorr(14 downto 0);
            p:          out std_logic_vectorr(10 downto 0)
    );
end hamming_decoder;

architecture structural of hamming_decoder is

component gateXor2 is
        port(	x1: in 	std_logic;
                x2: in 	std_logic;
                y:	out	std_logic);
end component;
    
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

signal s_xor_a: std_logic_vector(6 downto 0);

signal s_xor_b: std_logic_vector(6 downto 0);

signal s_xor_c: std_logic_vector(6 downto 0);

signal s_xor_d: std_logic_vector(6 downto 0);

signal s_and: std_logic_vector(10 downto 0);

begin

-- parity equation 1: y1 ⊕ y2 ⊕ y3 ⊕ y7 ⊕ y8 ⊕ y9 ⊕ y11 ⊕ y12
xor1_a: gateXor2 	port map (y(0), y(1), s_xor_a(0)); 			
xor2_a: gateXor2 	port map (s_xor_a(0), y(2), s_xor_a(1)); 	
xor3_a: gateXor2 	port map (s_xor_a(1), y(6), s_xor_a(2)); 
xor4_a: gateXor2 	port map (s_xor_a(2), y(7), s_xor_a(3)); 
xor5_a: gateXor2 	port map (s_xor_a(3), y(8), s_xor_a(4)); 	
xor6_a: gateXor2 	port map (s_xor_a(4), y(10), s_xor_a(5)); 
xor7_a: gateXor2    port map (s_xor_a(5), y(11), s_xor_a(6)); 
    
-- parity equation 2: y1 ⊕ y4 ⊕ y5 ⊕ y7 ⊕ y8 ⊕ y10 ⊕ y11 ⊕ y13
xor1_b: gateXor2 	port map (y(0), y(3), s_xor_b(0)); 			
xor2_b: gateXor2 	port map (s_xor_b(0), y(4), s_xor_b(1)); 	
xor3_b: gateXor2 	port map (s_xor_b(1), y(6), s_xor_b(2)); 
xor4_b: gateXor2 	port map (s_xor_b(2), y(7), s_xor_b(3)); 
xor5_b: gateXor2 	port map (s_xor_b(3), y(9), s_xor_b(4)); 	
xor6_b: gateXor2 	port map (s_xor_b(4), y(10), s_xor_b(5)); 
xor7_b: gateXor2    port map (s_xor_b(5), y(12), s_xor_b(6));

-- parity equation 3: y2 ⊕ y4 ⊕ y6 ⊕ y7 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y14
xor1_c: gateXor2 	port map (y(1), y(3), s_xor_c(0)); 			
xor2_c: gateXor2 	port map (s_xor_c(0), y(5), s_xor_c(1)); 	
xor3_c: gateXor2 	port map (s_xor_c(1), y(6), s_xor_c(2)); 
xor4_c: gateXor2 	port map (s_xor_c(2), y(8), s_xor_c(3)); 
xor5_c: gateXor2 	port map (s_xor_c(3), y(9), s_xor_c(4)); 	
xor6_c: gateXor2 	port map (s_xor_c(4), y(10), s_xor_c(5)); 
xor7_c: gateXor2    port map (s_xor_c(5), y(13), s_xor_c(6));

-- parity equation 4: y3 ⊕ y5 ⊕ y6 ⊕ y8 ⊕ y9 ⊕ y10 ⊕ y11 ⊕ y15
xor1_d: gateXor2 	port map (y(2), y(4), s_xor_d(0)); 			
xor2_d: gateXor2 	port map (s_xor_d(0), y(5), s_xor_d(1)); 	
xor3_d: gateXor2 	port map (s_xor_d(1), y(7), s_xor_d(2)); 
xor4_d: gateXor2 	port map (s_xor_d(2), y(8), s_xor_d(3)); 
xor5_d: gateXor2 	port map (s_xor_d(3), y(9), s_xor_d(4)); 	
xor6_d: gateXor2 	port map (s_xor_d(4), y(10), s_xor_d(5)); 
xor7_d: gateXor2    port map (s_xor_d(5), y(14), s_xor_d(6));

-- H matrix
-- 1st column
and1: 	gateAnd4 port map (not s_xor_a(6), not s_xor_b(6), s_xor_c(6), s_xor_d(6), s_and(0)); 	
-- 2nd column
and2: 	gateAnd4 port map (not s_xor_a(6), s_xor_b(6), s_xor_c(6), not s_xor_d(6), s_and(1)); 	
-- 3rd column
and3: 	gateAnd4 port map (s_xor_a(6), s_xor_b(6), not s_xor_c(6), not s_xor_d(6), s_and(2));
-- 4th column	
and4: 	gateAnd4 port map (s_xor_a(6), not s_xor_b(6), s_xor_c(6), not s_xor_d(6), s_and(3)); 	
-- 5th column	
and5: 	gateAnd4 port map (not s_xor_a(6), s_xor_b(6), not s_xor_c(6), s_xor_d(6), s_and(4));
-- 6th column	 	
and6: 	gateAnd4 port map (s_xor_a(6), not s_xor_b(6), not s_xor_c(6), s_xor_d(6), s_and(5)); 	
-- 7th column	 	
and7: 	gateAnd4 port map (s_xor_a(6), not s_xor_b(6), not s_xor_c(6), not s_xor_d(6), s_and(6)); 	
-- 8th column	
and8: 	gateAnd4 port map (not s_xor_a(6), s_xor_b(6), not s_xor_c(6), not s_xor_d(6), s_and(7)); 	
-- 8th column	
and9:	gateAnd4 port map (not s_xor_a(6), not s_xor_b(6), s_xor_c(6), not s_xor_d(6), s_and(8));
-- 9th column	 		
and10: 	gateAnd4 port map (not s_xor_a(6), not s_xor_b(6), not s_xor_c(6), s_xor_d(6), s_and(9));
-- 10th column	 	
and11: 	gateAnd4 port map (not s_xor_a(6), not s_xor_b(6), not s_xor_c(6), not s_xor_d(6), s_and(10)); 	


-- 1-bit error correction
xor_last1: 	gateXor2 port map (y(0), s_and(0), p(10));
xor_last2: 	gateXor2 port map (y(1), s_and(1), p(9));
xor_last3: 	gateXor2 port map (y(2), s_and(2), p(8));
xor_last4: 	gateXor2 port map (y(3), s_and(3), p(7));
xor_last5: 	gateXor2 port map (y(4), s_and(4), p(6));
xor_last6: 	gateXor2 port map (y(5), s_and(5), p(5));
xor_last7: 	gateXor2 port map (y(6), s_and(6), p(4));
xor_last8: 	gateXor2 port map (y(7), s_and(7), p(3));
xor_last9: 	gateXor2 port map (y(8), s_and(8), p(2));
xor_last10: gateXor2 port map (y(9), s_and(9), p(1));
xor_last11: gateXor2 port map (y(10), s_and(10), p(0));

end structural;