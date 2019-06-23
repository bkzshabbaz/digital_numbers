library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_block is
    generic (DEFAULT_NUM : integer := 50);
    port (  count : in std_logic;
            clk : in std_logic;
            number : out std_logic_vector (5 downto 0));
end counter_block;

architecture counter of counter_block is
signal num : integer := DEFAULT_NUM;
begin

process (clk)
begin
    if rising_edge(clk) then
        if (count = '1') then
            num <= DEFAULT_NUM;
        else
            if (num = 0) then
                num <= DEFAULT_NUM;
            else
                num <= num - 1;
            end if;
        end if;
    end if;
end process;

number <= std_logic_vector(to_unsigned(num, number'length));

end counter;

