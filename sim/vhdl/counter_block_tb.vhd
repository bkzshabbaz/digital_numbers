library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_block_tb is
--no ports
end counter_block_tb;

architecture tb of counter_block_tb is
signal clk, count : std_logic := '0';
signal number : std_logic_vector (5 downto 0);
signal done : boolean := false;
constant period : time := 10 ns;
begin

clk <= not clk after period/2 when done /= true else '0';

dut : entity work.counter_block
        generic map (
            DEFAULT_NUM => 50
        )
        port map (
            count => count,
            clk => clk,
            number => number
        );

simulation : process
begin
wait for 10 ns;
count <= '1';
wait for 1 * period;
count <= '0';
wait for 1000 ns;
done <= true;
end process simulation;
end tb;
