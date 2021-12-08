library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY gateMux2 IS
  PORT (x1, x2: IN STD_LOGIC;
        sel:    IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateMux2;

architecture Structural of gateMux2 is

COMPONENT gateAnd2 IS
    PORT (x1, x2: IN STD_LOGIC;
          y:      OUT STD_LOGIC);
END COMPONENT;

COMPONENT gateOr2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END COMPONENT;

COMPONENT gateNot IS
  PORT (x1:     IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END COMPONENT;

signal s1, s2, s3: std_logic;

begin

not1: gateNot port map (sel, s1); 				
and1: gateAnd2 port map (x1, s1, s2);  	
and2: gateAnd2 port map (x2, sel, s3); 		
or1: gateOr2 port map (s2, s3, y);	

end Structural;