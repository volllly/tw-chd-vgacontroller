library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture struc of content_ctrl is
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

  signal s_addra_mu1: std_logic_vector(16 downto 0);
  signal s_douta_mu1: std_logic_vector(11 downto 0);
  
  signal s_addra_mu2: std_logic_vector(13 downto 0);
  signal s_douta_mu2: std_logic_vector(11 downto 0);
  
  signal x_mov: integer range 0 to 540;
  signal y_mov: integer range 0 to 380;

  begin
    i_mu1: MU1
      port map(
        clka  => clk_i,
        addra => s_addra_mu1,
        douta => s_douta_mu1
      );
    i_mu2: MU2
      port map(
        clka  => clk_i,
        addra => s_addra_mu2,
        douta => s_douta_mu2
      );

    p_mov: process(reset_i, v_pos_i)
      variable v_index: integer range 0 to 127;
      constant c_iclk_f: integer := 1;   
      begin
        if reset_i = '1' then
          x_mov <= 0;
          y_mov <= 0;
        elsif v_pos_i'event and to_integer(unsigned(v_pos_i)) = 0 then
          v_index := (v_index + 1) mod c_iclk_f;
          if v_index = 0 then
            if pbsync_i(3) = '1' then
              x_mov <= (x_mov - 1) mod 540;
            elsif pbsync_i(2) = '1' then
              x_mov <= (x_mov + 1) mod 540;
            end if;
            if pbsync_i(1) = '1' then
              y_mov <= (y_mov - 1) mod 380;
            elsif pbsync_i(0) = '1' then
              y_mov <= (y_mov + 1) mod 380;
            end if;
          end if;
        end if;
    end process;
      
    p_color: process(reset_i, h_pos_i, v_pos_i, s_douta_mu1, s_douta_mu2)
      variable color: integer range 0 to 3;
      variable x_fix: integer range 0 to 640;
      variable y_fix: integer range 0 to 480;
      begin
        red_o <= x"0";
        green_o <= x"0";
        blue_o <= x"0";
        s_addra_mu1 <= (others => '0');
        s_addra_mu2 <= (others => '0');
        if not reset_i = '1' then
          if swsync_i(15) = '0'  then
            if swsync_i(14) = '1' then
              color := (to_integer(unsigned(h_pos_i)) / 64) mod 4;
              color := (color + (to_integer(unsigned(v_pos_i)) / 48)) mod 4;
            else
              color := (to_integer(unsigned(h_pos_i)) / 40) mod 4;
            end if;
            case color is
              when 0 =>
                red_o <= x"F";
                green_o <= x"0";
                blue_o <= x"0";
              when 1 =>
                red_o <= x"0";
                green_o <= x"F";
                blue_o <= x"0";
              when 2 =>
                red_o <= x"0";
                green_o <= x"0";
                blue_o <= x"F";
              when others =>
                red_o <= x"0";
                green_o <= x"0";
                blue_o <= x"0";
            end case;
          elsif swsync_i(15) = '1' then
            x_fix := to_integer(unsigned(h_pos_i)) mod 320;
            y_fix := to_integer(unsigned(v_pos_i)) mod 240;
            s_addra_mu1 <= std_logic_vector(to_unsigned(y_fix * 320 + x_fix,  s_addra_mu1'length));
            red_o <= s_douta_mu1(11 downto 8);
            green_o <= s_douta_mu1(7 downto 4);
            blue_o <= s_douta_mu1(3 downto 0);
          end if;
          if swsync_i(13) = '1' then
            x_fix := to_integer(unsigned(h_pos_i));
            y_fix := to_integer(unsigned(v_pos_i));
            if x_fix >= x_mov and x_fix < x_mov + 100 and y_fix >= y_mov and y_fix < y_mov + 100 then
              s_addra_mu2 <= std_logic_vector(to_unsigned((y_fix - y_mov) * 100 + x_fix - x_mov,  s_addra_mu2'length));
              if not s_douta_mu2 = x"FFF" then
                red_o <= s_douta_mu2(11 downto 8);
                green_o <= s_douta_mu2(7 downto 4);
                blue_o <= s_douta_mu2(3 downto 0);
              end if;
            end if;
          end if;
        end if;
    end process;
end architecture;