-- AND2

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateAnd2;

ARCHITECTURE logicFunction OF gateAnd2 IS
BEGIN
  y <= x1 AND x2;
END logicFunction;

-- AND4

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateAnd4 IS
  PORT (x1, x2, x3, x4: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateAnd4;

ARCHITECTURE logicFunction OF gateAnd4 IS

BEGIN
  y <= (x1 AND x2) AND (x3 AND x4);
END logicFunction;

-- NAND

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNand2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateNand2;

ARCHITECTURE logicFunction OF gateNand2 IS
BEGIN
  y <= NOT (x1 AND x2);
END logicFunction;

-- OR

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateOr2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateOr2;

ARCHITECTURE logicFunction OF gateOr2 IS
BEGIN
  y <= x1 OR x2;
END logicFunction;

-- NOR

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNor2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateNor2;

ARCHITECTURE logicFunction OF gateNor2 IS
BEGIN
  y <= NOT (x1 OR x2);
END logicFunction;

-- XOR

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXor2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateXor2;

ARCHITECTURE logicFunction OF gateXor2 IS
BEGIN
  y <= x1 XOR x2;
END logicFunction;

-- XNOR

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateXNor2 IS
  PORT (x1, x2: IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateXNor2;

ARCHITECTURE logicFunction OF gateXNor2 IS
BEGIN
  y <= NOT (x1 XOR x2);
END logicFunction;

-- NOT

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY gateNot IS
  PORT (x1:     IN STD_LOGIC;
        y:      OUT STD_LOGIC);
END gateNot;

ARCHITECTURE logicFunction OF gateNot IS
BEGIN
  y <= NOT (x1);
END logicFunction;

