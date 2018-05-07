library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library work;
use work.mc8051_p.all;

architecture struc_mem2 of vga_controler_top is
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
    generic(
      loadout_g: natural := 0
    );
    port(
      clk_i:      in  std_logic;
      reset_i:    in  std_logic;
      swsync_i:   in  std_logic_vector(15 downto 0);
      pbsync_i:   in  std_logic_vector(3  downto 0);
      h_pos_i:    in  std_logic_vector(11 downto 0);
      v_pos_i:    in  std_logic_vector(11 downto 0);
      ena_i:      in std_logic;
      wea_i:      in std_logic_vector(0 downto 0);
      addra_i:    in std_logic_vector(16 downto 0);
      dina_i:     in std_logic_vector(11 downto 0);
      
      red_o:      out std_logic_vector(3 downto 0);
      green_o:    out std_logic_vector(3 downto 0);
      blue_o:     out std_logic_vector(3 downto 0)
    );
  end component;

  component PLL is
    port(
      clk_in1  : in  std_logic;
      clk_out1 : out std_logic;
      reset    : in  std_logic;
      locked   : out std_logic
    );
  end component;

  component mc8051_top is
    port (
      clk       : in std_logic;
      reset     : in std_logic;
      int0_i    : in std_logic_vector(C_IMPL_N_EXT-1 downto 0);
      int1_i    : in std_logic_vector(C_IMPL_N_EXT-1 downto 0);
      all_t0_i  : in std_logic_vector(C_IMPL_N_TMR-1 downto 0);
      all_t1_i  : in std_logic_vector(C_IMPL_N_TMR-1 downto 0);
      all_rxd_i : in std_logic_vector(C_IMPL_N_SIU-1 downto 0);
      p0_i      : in std_logic_vector(7 downto 0);
      p1_i      : in std_logic_vector(7 downto 0);
      p2_i      : in std_logic_vector(7 downto 0);
      p3_i      : in std_logic_vector(7 downto 0); 

      p0_o        : out std_logic_vector(7 downto 0);
      p1_o        : out std_logic_vector(7 downto 0);
      p2_o        : out std_logic_vector(7 downto 0);
      p3_o        : out std_logic_vector(7 downto 0);
      all_rxd_o   : out std_logic_vector(C_IMPL_N_SIU-1 downto 0);
      all_txd_o   : out std_logic_vector(C_IMPL_N_SIU-1 downto 0);
      all_rxdwr_o : out std_logic_vector(C_IMPL_N_SIU-1 downto 0);
      test_o      : out std_logic_vector(7 downto 0)
    );  
  end component;

  signal s_swsync:      std_logic_vector(15 downto 0);
  signal s_pbsync:      std_logic_vector(3  downto 0);
  signal s_px_en:       std_logic;
  
  signal s_red:         std_logic_vector(3 downto 0);
  signal s_green:       std_logic_vector(3 downto 0);
  signal s_blue:        std_logic_vector(3 downto 0);

  signal s_h_pos:       std_logic_vector(11 downto 0);
  signal s_v_pos:       std_logic_vector(11 downto 0);

  signal s_select_da:   std_logic;
  signal s_set_da:      std_logic;
  signal s_ena:         std_logic;
  signal s_wea:         std_logic_vector(0 downto 0);

  signal s_da:          std_logic_vector(23 downto 0);
  signal s_addra:       std_logic_vector(16 downto 0);
  signal s_dina:        std_logic_vector(11 downto 0);

  signal s_p2_o:        std_logic_vector(7 downto 0);
  signal s_locked:      std_logic;
  signal s_sync_locked: std_logic_vector(2 downto 0);
  signal s_reset_8051:  std_logic;
  signal s_clk_8051:    std_logic;
   
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

    i_PLL : PLL
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
        p1_o      => s_da(23 downto 16), -- "xxxxx" & s_set_da & s_select_da & addra[16: 15]
        p2_o      => s_da(15 downto 8),  --                                    addra[15:  8]  or  "xxxx" & dina[11: 8]
        p3_o      => s_da(7 downto 0),   --                                    addra[7:   0]  or           dina[7:  0]
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
    generic map(
      loadout_g   => 0
    )
    port map(
      clk_i       => clk_i,
      reset_i     => reset_i,
      swsync_i    => s_swsync,
      pbsync_i    => s_pbsync,
      h_pos_i     => s_h_pos,
      v_pos_i     => s_v_pos,
      ena_i       => s_ena,
      wea_i       => s_wea,
      addra_i     => s_addra,
      dina_i      => s_dina,

      red_o       => s_red,
      green_o     => s_green,
      blue_o      => s_blue
    );


  p_rout_mu3: process(reset_i, s_set_da, s_select_da)
    begin
      s_ena <= '1';
      if s_set_da = '0' and s_select_da = '0' then
        s_ena <= '0';
      end if;

      if reset_i = '1' then
        s_ena <= '0';
        s_wea <= "0";
        s_addra <= (others => '0');
        s_dina <= (others => '0');
      elsif s_set_da'event and s_set_da = '1' then
        s_ena <= '0';
        if s_select_da = '0' then
          s_addra <= s_da(16 downto 0);
          s_wea <= "0";
        else
          s_dina <= s_da(11 downto 0);
          s_wea <= "1";
        end if;
      end if;
  end process;
  s_select_da <= s_da(17);
  s_set_da <= s_da(18);
  s_da(23 downto 19) <= (others => 'Z');

end architecture;