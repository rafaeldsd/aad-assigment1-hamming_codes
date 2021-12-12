LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

ENTITY control IS
  PORT (clk:  IN STD_LOGIC;
        nRst: IN STD_LOGIC;
        cout: OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END control;

architecture structural of control is

component counter is
  port(	  clk: in std_logic;
          nRst: in std_logic;
          counterout: out std_logic_vector(3 downto 0));
end component;

component rom is
  port (  i :  	in std_logic_vector(3 downto 0);
          o :   out std_logic_vector(6 downto 0)
    );
  end component;
  
  signal s_counterOut: std_logic_vector(3 downto 0);
  
  begin
  
  counter1: counter port map (clk, nRst, s_counterOut); 			
  rom1: 	rom port map (s_counterOut, cout); 
    
  end structural;