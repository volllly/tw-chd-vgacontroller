library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture struc_mem2 of content_ctrl is
  component MU1 is
    port(
      clka:  in  std_logic;
      addra: in  std_logic_vector(16 downto 0);
      douta: out std_logic_vector(11 downto 0)
      );
  end component;
  component MU2 is
    port(
      clka:  in  std_logic;
      addra: in  std_logic_vector(13 downto 0);
      douta: out std_logic_vector(11 downto 0)
      );
  end component;
  component MU3 is
    PORT (
      clka:  in std_logic;
      ena:   in std_logic;
      wea:   in std_logic_vector(0 downto 0);
      addra: in std_logic_vector(16 downto 0);
      dina:  in std_logic_vector(11 downto 0);
      clkb:  in std_logic;
      addrb: in std_logic_vector(16 downto 0);
      doutb: out std_logic_vector(11 downto 0)
    );
  end component;


  signal s_addrb_mu3: std_logic_vector(16 downto 0);
  signal s_doutb_mu3: std_logic_vector(11 downto 0);
  
  signal x_mov: integer range 0 to 540;
  signal y_mov: integer range 0 to 380;

  begin
    i_mu3: MU3
      port map(
        clka  => clk_i,
        ena   => ena_i,
        wea   => wea_i,
        addra => addra_i,
        dina  => dina_i,
        clkb  => clk_i,
        addrb => s_addrb_mu3,
        doutb => s_doutb_mu3
      );

    p_color: process(reset_i, h_pos_i, v_pos_i, s_doutb_mu3)
      variable color: integer range 0 to 3;
      variable x_fix: integer range 0 to 640;
      variable y_fix: integer range 0 to 480;
      begin
        red_o <= x"0";
        green_o <= x"0";
        blue_o <= x"0";
        s_addrb_mu3 <= (others => '0');
        if not reset_i = '1' then
          x_fix := to_integer(unsigned(h_pos_i)) mod 320;
          y_fix := to_integer(unsigned(v_pos_i)) mod 240;
          s_addrb_mu3 <= std_logic_vector(to_unsigned(y_fix * 320 + x_fix,  s_addrb_mu3'length));
          red_o <= s_doutb_mu3(11 downto 8);
          green_o <= s_doutb_mu3(7 downto 4);
          blue_o <= s_doutb_mu3(3 downto 0);
        end if;
    end process;
end architecture;