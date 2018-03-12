library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_vga is

end tb_vga;

architecture sim of tb_vga is
  component vga_controler_top
    port(
      clk_i:      in  std_logic;
      reset_i:    in  std_logic;
      sw_i:       in  std_logic_vector(15 downto 0);
      pb_i:       in  std_logic_vector(3  downto 0);
      
      red_o:      out std_logic_vector(3 downto 0);
      green_o:    out std_logic_vector(3 downto 0);
      blue_o:     out std_logic_vector(3 downto 0);
      h_sync_o:   out std_logic;
      v_sync_o:   out std_logic
    );
  end component;

  component vga_monitor
    generic(
      g_no_frames:  integer range 1 to 99 := 1;
      g_path:       string                := "vga_output/"
    );
    port(
      s_reset_i:      in std_logic;
      s_vga_red_i:    in std_logic_vector(3 downto 0);
      s_vga_green_i:  in std_logic_vector(3 downto 0);
      s_vga_blue_i:   in std_logic_vector(3 downto 0);
      s_vga_hsync_i:  in std_logic;
      s_vga_vsync_i:  in std_logic
    ); 
  end component;

  signal s_clk:    std_logic;
  signal s_reset:  std_logic;
  signal s_sw:     std_logic_vector(15 downto 0);
  signal s_pb:     std_logic_vector(3  downto 0);

  signal s_red:    std_logic_vector(3 downto 0);
  signal s_green:  std_logic_vector(3 downto 0);
  signal s_blue:   std_logic_vector(3 downto 0);
  signal s_h_sync: std_logic;
  signal s_v_sync: std_logic;

  begin
    i_vga_controler_top: vga_controler_top
      port map(
        clk_i     => s_clk,
        reset_i   => s_reset,
        sw_i      => s_sw,
        pb_i      => s_pb,
        
        red_o     => s_red,
        green_o   => s_green,
        blue_o    => s_blue,
        h_sync_o  => s_h_sync,
        v_sync_o  => s_v_sync
      );
    i_vga_monitor: vga_monitor
      port map(
        s_reset_i     => s_reset,
        s_vga_red_i   => s_red,
        s_vga_green_i => s_green,
        s_vga_blue_i  => s_blue,
        s_vga_hsync_i => s_h_sync,
        s_vga_vsync_i => s_v_sync
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
          std.env.stop(0);
    end process;
end architecture;