library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture struc of vga_controler_top is
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

  component content_ctrl
    port(
      clk_i:      in  std_logic;
      reset_i:    in  std_logic;
      swsync_i:   in  std_logic_vector(15 downto 0);
      pbwsync_i:  in  std_logic_vector(3  downto 0);
      h_pos_i:    out std_logic_vector(11 downto 0);
      v_pos_i:    out std_logic_vector(11 downto 0);
      
      red_o:      out std_logic_vector(3 downto 0);
      green_o:    out std_logic_vector(3 downto 0);
      blue_o:     out std_logic_vector(3 downto 0)
    );
  end component;

  signal s_swsync:  std_logic_vector(15 downto 0);
  signal s_pbsync: std_logic_vector(3  downto 0);
  signal s_px_en:   std_logic;
  
  signal s_red:     std_logic_vector(3 downto 0);
  signal s_green:   std_logic_vector(3 downto 0);
  signal s_blue:    std_logic_vector(3 downto 0);

  signal s_h_pos:   std_logic_vector(11 downto 0);
  signal s_v_pos:   std_logic_vector(11 downto 0);

  begin
    i_io_ctrl: io_ctrl
      port map(
        clk_i       => clk_i,
        reset_i     => reset_i,
        sw_i        => sw_i,
        pb_i        => pb_i,
        
        swsync_o    => s_swsync,
        pbsync_o    => s_pbsync,
        px_en_o     => s_px_en
      );

    i_vga_ctrl: vga_ctrl
      port map(
        clk_i       => clk_i,
        reset_i     => reset_i,
        px_en_i     => s_px_en,
        red_i       => s_red,
        green_i     => s_green,
        blue_i      => s_blue,
  
        h_pos_o     => s_h_pos,
        v_pos_o     => s_v_pos,
        h_sync_o    => h_sync_o,
        v_sync_o    => v_sync_o,
        red_o       => red_o,
        green_o     => green_o,
        blue_o      => blue_o
      );

  i_content_ctrl: content_ctrl
    port map(
      clk_i       => clk_i,
      reset_i     => reset_i,
      swsync_i    => s_swsync,
      pbwsync_i   => s_pbsync,
      h_pos_i     => s_h_pos,
      v_pos_i     => s_v_pos,
      
      red_o       => s_red,
      green_o     => s_green,
      blue_o      => s_blue
    );
end architecture;