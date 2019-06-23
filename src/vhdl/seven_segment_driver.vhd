entity seven_segment_driver is
    generic (
        N           : integer;
        DIGITS      : integer
    );
    port (
        number      : in std_logic_vector (N-1 downto 0);
        segments    : out std_logic_vector (7 downto 0);

    );
end seven_segment_driver;

architecture driver of seven_segment_driver is

begin

end driver;
