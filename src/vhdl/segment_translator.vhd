library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity segment_translator is
port (
    num : in std_logic_vector (7 downto 0);
    segments : out std_logic_vector (7 downto 0)
);
end segment_translator;

architecture translator of segment_translator is

begin
    with num select 
    segments <= b"11000000" when x"00",
                b"11111001" when x"01",
                b"10100100" when x"02",
                b"10110000" when x"03",
                b"10011001" when x"04",
                b"10010010" when x"05",
                b"10000010" when x"06",
                b"11111000" when x"07",
                b"10000000" when x"08",
                b"10010000" when x"09",
                b"10001000" when x"0a",
                b"10000011" when x"0b",
                b"11000110" when x"0c",
                b"10100001" when x"0d",
                b"10000110" when x"0e",
                b"10001110" when x"0f",
                b"11111111" when others; 

end translator;
