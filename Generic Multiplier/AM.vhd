LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
ENTITY Array_Multiplier IS
    GENERIC (
        N : NATURAL := 32);
    PORT (
        a : IN std_logic_vector(N - 1 DOWNTO 0);
        b : IN std_logic_vector(N - 1 DOWNTO 0);
        Result : OUT std_logic_vector(N + N - 1 DOWNTO 0)
    );
END Array_Multiplier;

ARCHITECTURE mul OF Array_Multiplier IS

    COMPONENT Half_Adder
        PORT (
            X1, X2 : IN std_logic;
            S, Cout : OUT std_logic
        );
    END COMPONENT;

    COMPONENT Full_Adder
        PORT (
            X1, X2, Cin : IN std_logic;
            S, Cout : OUT std_logic
        );
    END COMPONENT;

    SIGNAL c : std_logic_vector(N * (N - 1) - 2 DOWNTO 0);
    SIGNAL s : std_logic_vector((N - 1) * (N - 2) - 1 DOWNTO 0);
    TYPE and_res IS ARRAY (0 TO N - 1) OF std_logic_vector(0 TO N - 1); -- and input ha
    SIGNAL ab : and_res;
-- c (cin adder = cout adder ghabli)
-- s output adder ha ke mire satr bad (adder paein)
BEGIN
    PROCESS (a, b)
    BEGIN
        FOR i IN 0 TO N - 1 LOOP
            FOR j IN 0 TO N - 1 LOOP
                ab(i)(j) <= a(i) AND b(j);
				-- input ha and mishan chon dar input adder ha niaz darim
            END LOOP;
        END LOOP;
    END PROCESS;
    Result(0) <= ab(0)(0);
    row : FOR i IN 0 TO N - 1 GENERATE
        column : FOR j IN 0 TO N - 2 GENERATE
			-- satr o sotoon madar
            first_first : IF i = 0 AND j = 0 GENERATE -- half adder satr aval
                HAff : Half_Adder PORT MAP(ab(0)(1), ab(1)(0), Result(1), c(0));--res
            END GENERATE first_first; 
            first_others : IF i = 0 AND j > 0 GENERATE -- avalin half adder satr haye bad
                HAfx : Half_Adder PORT MAP(ab(j + 1)(0), ab(j)(1), s(j - 1), c(j));
            END GENERATE first_others;
            others_first : IF i < n - 1 AND i > 0 AND j = 0 GENERATE -- full adder haye satr aval
                FAxf : Full_Adder PORT MAP(ab(0)(i + 1), s((i - 1) * (n - 2)), c((i - 1) * (n - 1)), Result(i + 1), c(i * (N - 1))); --res(i+1)
            END GENERATE others_first; 
            others_others : IF i < n - 1 AND i > 0 AND j < N - 2 AND j > 0 GENERATE -- full adder haye baghie satr ha
                FAxx : Full_Adder PORT MAP(ab(j)(i + 1), s((i - 1) * (n - 2) + j), c((i - 1) * (n - 1) + j), s(i * (N - 2) + j - 1), c(i * (N - 1) + j));
            END GENERATE others_others;
            others_last : IF i < n - 1 AND i > 0 AND j = N - 2 GENERATE -- akharin full adder baghie ro misaze
                FAxl : Full_Adder PORT MAP(ab(j + 1)(i), ab(j)(i + 1), c((i - 1) * (n - 1) + j), s(i * (N - 2) + j - 1), c(i * (N - 1) + j));
            END GENERATE others_last;
            last_first : IF i = n - 1 AND i > 0 AND j = 0 GENERATE -- half adder akharin satr ro misaze
                FAlf : Half_Adder PORT MAP(c((i - 1) * (n - 1)), s((i - 1) * (n - 2)), Result(i + 1), c(i * (N - 1))); --res
            END GENERATE last_first;
            last_others : IF i = n - 1 AND j < n - 2 AND j > 0 GENERATE -- baghie full adder haye akharin satr ro misaze
                FAlx : Full_Adder PORT MAP(c((i) * (n - 1) + j - 1), s((i - 1) * (n - 2) + j), c((i - 1) * (n - 1) + j), Result(n + j), c((i) * (n - 1) + j)); --res
            END GENERATE last_others;
            last_last : IF i = n - 1 AND j = n - 2 GENERATE -- akharin full adder madar
                FAll : Full_Adder PORT MAP(ab(j + 1)(i), c((i - 1) * (n - 1) + j), c((i) * (n - 1) + j - 1), Result(n + j), Result(n + j + 1)); --res
            END GENERATE last_last;
        END GENERATE;
    END GENERATE;
END mul;
