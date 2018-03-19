library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_vga_ctrl is

end tb_vga_ctrl;

architecture sim of tb_vga_ctrl is
  component vga_ctrl
    port(
      clk_i:    in  std_logic;
      reset_i:  in  std_logic;
      px_en_i:  out std_logic;
      red_i:    out std_logic_vector(3 downto 0);
      green_i:  out std_logic_vector(3 downto 0);
      blue_i:   out std_logic_vector(3 downto 0);

      h_pos_o:  out std_logic_vector(11 downto 0);
      v_pos_o:  out std_logic_vector(11 downto 0);
      h_sync_o: out std_logic;
      v_sync_o: out std_logic;
      red_o:    out std_logic_vector(3 downto 0);
      green_o:  out std_logic_vector(3 downto 0);
      blue_o:   out std_logic_vector(3 downto 0)
    );
  end component;

  signal s_clk:       std_logic;
  signal s_reset:     std_logic;
  signal s_px_en:     std_logic;
  signal s_red_i:     std_logic_vector(3 downto 0);
  signal s_green_i:   std_logic_vector(3 downto 0);
  signal s_blue_i:    std_logic_vector(3 downto 0);

  signal s_h_pos:     std_logic_vector(11 downto 0);
  signal s_v_pos:     std_logic_vector(11 downto 0);
  signal s_h_sync:    std_logic;
  signal s_v_sync:    std_logic;
  signal s_red_o:     std_logic_vector(3 downto 0);
  signal s_green_o:   std_logic_vector(3 downto 0);
  signal s_blue_o:    std_logic_vector(3 downto 0);

  begin
    i_vga_ctrl: vga_ctrl
      port map(
        clk_i     => s_clk,
        reset_i   => s_reset,
        px_en_i   => s_px_en,
        red_i     => s_red_i,
        green_i   => s_green_i,
        blue_i    => s_blue_i,

        h_pos_o   => s_h_pos,
        v_pos_o   => s_v_pos,
        h_sync_o  => s_h_sync,
        v_sync_o  => s_v_sync,
        red_o     => s_red_o,
        green_o   => s_green_o,
        blue_o    => s_blue_o
      );

    p_clk: process
      begin
        s_clk <= '0';
        wait for 5 ns;
        s_clk <= '1';
        wait for 5 ns;
    end process;

    p_px_en: process
      begin
        s_px_en <= '0';
        wait for 20 ns;
        s_px_en <= '1';
        wait for 20 ns;
    end process;

    p_reset: process
        begin
          s_reset <= '1';
          wait for 20 ns;
          s_reset <= '0';
          wait;
    end process;

    p_vga_ctrl: process
      begin
        


        std.env.stop(0);
    end process;
end architecture;