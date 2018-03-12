library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_io_ctrl is

end tb_io_ctrl;

architecture sim of tb_io_ctrl is
  component io_ctrl
    port(
      clk_i:      in  std_logic;
      reset_i:    in  std_logic;
      sw_i:       in  std_logic_vector(15 downto 0);
      pb_i:       in  std_logic_vector(3  downto 0);
      
      swsync_o:   out std_logic_vector(15 downto 0);
      pbsync_o:   out std_logic_vector(3  downto 0);
      px_en_o:    out std_logic
    );
  end component;

  signal s_clk:    std_logic;
  signal s_reset:  std_logic;
  signal s_sw:     std_logic_vector(15 downto 0);
  signal s_pb:     std_logic_vector(3  downto 0);

  signal s_swsync: std_logic_vector(15 downto 0);
  signal s_pbsync: std_logic_vector(3 downto 0);
  signal s_px_en:  std_logic;

  begin
    i_io_ctrl: io_ctrl
      port map(
        clk_i     => s_clk,
        reset_i   => s_reset,
        sw_i      => s_sw,
        pb_i      => s_pb,
        
        swsync_o  => s_swsync,
        pbsync_o  => s_pbsync,
        px_en_o   => s_px_en
      );

    p_clk: process
      begin
        s_clk <= '0';
        wait for 5 ns;
        s_clk <= '1';
        wait for 5 ns;
    end process;

    p_reset: process
        begin
          s_reset <= '1';
          wait for 20 ns;
          s_reset <= '0';
          wait;
    end process;

    p_io_ctrl: process
      begin
        s_pb <= x"F";
        wait until s_pbsync = x"F";
        s_pb <= x"0";
        wait until s_pbsync = x"0";
        report "IO_CTRL: Button debounce tested" severity note;

        s_sw <= x"FFFF";
        wait until s_swsync = x"FFFF";
        s_sw <= x"0000";
        wait until s_swsync = x"0000";
        report "IO_CTRL: Switch debounce tested" severity note;

        wait until s_px_en = '0';
        wait for 20 ns;
        assert (s_px_en'last_event = 20 ns) report "IO_CTRL: PX Enable not working "&time'image(s_px_en'last_event) severity error;
        wait for 40 ns;
        assert (s_px_en = '0') and (s_px_en'last_event = 20 ns) report "IO_CTRL: PX Enable not working "&time'image(s_px_en'last_event) severity error;
        report "IO_CTRL: PX Enable tested" severity note;
        std.env.stop(0);
    end process;
end architecture;