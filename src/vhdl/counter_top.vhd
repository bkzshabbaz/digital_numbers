library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_top is
    port (
        clk :       in std_logic;
        reset :     in std_logic;
        count :     in std_logic;
        segments :  out std_logic_vector (6 downto 0);
        digits :    out std_logic
    );
end entity counter_top;

architecture counter of counter_top is
signal number :     std_logic_vector (7 downto 0);
signal segment_1 :  std_logic_vector (7 downto 0);
signal segment_2 :  std_logic_vector (7 downto 0);
signal digit :      std_logic := '0';
signal refresh_cnt: std_logic_vector (19 downto 0) := (others => '0');
signal LED_cnt :    std_logic_vector (1 downto 0);
signal cnt_edge :   std_logic := '0';
signal debounced :  std_logic;
signal count_p :    std_logic;
signal reset_n :    std_logic;
begin
reset_n <= not reset;
count_p <= not count;
debouncer : entity work.debounce 
    port map (
        clk         => clk,
        reset_n     => reset_n,
        button      => count_p,
        result      => debounced
    );

edge_detector: entity work.edge_detector 
    port map (
        i_clk => clk,
        i_rstb => reset_n,
        i_input => debounced,
        o_pulse => cnt_edge
    );

translator : entity work.segment_translator
    port map (
        num         => number,
        segment_1   => segment_1,
        segment_2   => segment_2
    );

counter : entity work.counter_block
    port map (
        resetn =>   reset_n,
        count   =>  cnt_edge,
        clk     =>  clk,
        number  =>  number
    );

--process (clk)
--begin
--    if rising_edge (clk) then
--        refresh_cnt <= std_logic_vector(unsigned(refresh_cnt) + 1);
--    end if;
--end process;

process (clk) 
variable toggle : std_logic := '0';
begin
    if rising_edge(clk) then
        if (toggle = '1') then
            segments    <= segment_1 (6 downto 0);
            digits      <= '1';
            toggle      := '0';
        else
            segments    <= segment_2 (6 downto 0);
            digits      <= '0';
            toggle      := '1';
        end if;
    end if;

end process;

--LED_cnt <= refresh_cnt(18 downto 17);

--process (clk)
--begin
--if rising_edge(clk) then
--    case LED_cnt is
--    when "00" =>
--        digit <= '1';
--        segments <= segment_1 (6 downto 0);
--    when others =>
--        digit <= '0';
--        segments <= segment_2 (6 downto 0);
--    end case;
--end if;
--end process;
--digits (7 downto 4) <= (others => '1');

end architecture counter;
