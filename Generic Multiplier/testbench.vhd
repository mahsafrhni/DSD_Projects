LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY testbench IS
END;

ARCHITECTURE sim OF testbench IS
    COMPONENT Array_Multiplier IS
        GENERIC (
            N : NATURAL := 32);
        PORT (
            a : IN std_logic_vector(N - 1 DOWNTO 0);
            b : IN std_logic_vector(N - 1 DOWNTO 0);
            Result : OUT std_logic_vector(N + N - 1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL a, b : std_logic_vector(31 DOWNTO 0);
    SIGNAL res : std_logic_vector(63 DOWNTO 0);


BEGIN
    dut : Array_Multiplier PORT MAP(a, b, res);

    PROCESS BEGIN
        a <= "00000000000000000000000000001100";
        b <= "00000000000000000000000000001010";
        WAIT FOR 20 ns;
        a <= "00000100100000000000010000001100";
        b <= "00000000010010000100010000001010";
        WAIT FOR 20 ns;
        a <= "00000000000000001000000000001100";
        b <= "00000000000010000000000000001010";
        WAIT FOR 20 ns;
        a <= "00000000000010000000000000001100";
        b <= "00000000000000001000000000001010";
        WAIT FOR 20 ns;
        a <= "11111111111111111111111111111111";
        b <= "11111111111111111111111111111111";
        WAIT FOR 20 ns;
        WAIT;
    END PROCESS;
END;