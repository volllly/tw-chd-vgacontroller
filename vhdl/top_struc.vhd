library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.mc8051_p.all;

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
      px_en_i:  in  std_logic;
      red_i:    in  std_logic_vector(3 downto 0);
      green_i:  in  std_logic_vector(3 downto 0);
      blue_i:   in  std_logic_vector(3 downto 0);

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
      pbsync_i:  in  std_logic_vector(3  downto 0);
      h_pos_i:    in  std_logic_vector(11 downto 0);
      v_pos_i:    in  std_logic_vector(11 downto 0);
      
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

  signal s_p2_o : std_logic_vector(7 downto 0);
  signal s_locked : std_logic;
  signal s_sync_locked : std_logic_vector(2 downto 0);
  signal s_reset_8051 : std_logic;
  signal s_clk_8051 : std_logic;
   
  begin

    p_reset_generator : process (reset_i, s_clk_8051)
      begin
        if reset_i = '1' then
          s_reset_8051 <= '1';
          s_sync_locked <= (others => '0');
        elsif s_clk_8051'event and s_clk_8051='0' then
          s_sync_locked(0) <= s_locked;
          s_sync_locked(1) <= s_sync_locked(0);
          s_sync_locked(2) <= s_sync_locked(1);
            
          if (s_sync_locked(1)='1') and (s_sync_locked(2)='0') then
            s_reset_8051 <= '0';
          end if;
        end if;  
    end process p_reset_generator;

    i_prescaler : prescaler
      port map (
        clk_in1  => clk_i,
        clk_out1 => s_clk_8051,
        reset    => reset_i, 
        locked   => s_locked 
      );
   
    i_mc8051_top : mc8051_top
      port map (
        reset     => s_reset_8051,
        int0_i    => (others => '1'), 
        int1_i    => (others => '1'), 
        all_t0_i  => (others => '0'), 
        all_t1_i  => (others => '0'), 
        all_rxd_i => (others => '0'), 
        all_rxd_o => open,            
        all_txd_o => open,              
        clk       => s_clk_8051,
        p0_i      => (others => '0'), 
        p1_i      => (others => '0'), 
        p2_i      => (others => '0'), 
        p3_i      => (others => '0'), 
        p0_o      => open,            
        p1_o      => open,            
        p2_o      => s_p2_o,
        p3_o      => open,
        test_o    => open
      );

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
      pbsync_i   => s_pbsync,
      h_pos_i     => s_h_pos,
      v_pos_i     => s_v_pos,
      
      red_o       => s_red,
      green_o     => s_green,
      blue_o      => s_blue
    );
end architecture;