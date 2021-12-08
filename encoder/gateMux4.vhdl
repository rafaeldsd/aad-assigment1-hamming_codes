library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY gateMux4 IS
  PORT (x1, x2, x3, x4: IN STD_LOGIC;
        sel:    IN STD_LOGIC_VECTOR(1 downto 0);
        y:      OUT STD_LOGIC);
END gateMux4;

architecture Structural of gateMux4 is

    component gateMux2 is
        port (  x1, x2: in  std_logic;
                sel:	in  std_logic;
                y: 	    out std_logic
        );
    end component;
    
    signal s1, s2: std_logic;
    
    begin
    
    mux1: gateMux2 port map (x1, x2, sel(0), s1); 				
    mux2: gateMux2 port map (x3, x4, sel(0), s2); 				
    mux3: gateMux2 port map (s1, s2, sel(1), y);				
    
end Structural;