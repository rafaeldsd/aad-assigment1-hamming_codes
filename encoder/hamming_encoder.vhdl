library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY hamming_encoder IS
 PORT(datain : IN BIT_VECTOR(0 TO 10); --d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10
  hamout : OUT BIT_VECTOR(0 TO 14)); --d0 d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 p0 p1 p2 p3 
END hamming_encoder;

ARCHITECTURE beh OF hamming_encoder IS
SIGNAL p0, p1, p2, p3 : BIT; --check bits
BEGIN
--generate check bits
 p0 <= datain(0) XOR datain(1) XOR datain(2) XOR datain(6) XOR datain(7) XOR datain(8) XOR datain(10);
 p1 <= datain(0) XOR datain(3) XOR datain(4) XOR datain(6) XOR datain(7) XOR datain(9) XOR datain(10);
 p2 <= datain(1) XOR datain(3) XOR datain(5) XOR datain(6) XOR datain(8) XOR datain(9) XOR datain(10);
 p3 <= datain(2) XOR datain(4) XOR datain(5) XOR datain(7) XOR datain(8) XOR datain(9) XOR datain(10);

--connect up outputs
hamout(11 TO 14) <= (p0, p1, p2, p3);
hamout(0 TO 10) <= datain(0 TO 10);

END beh;