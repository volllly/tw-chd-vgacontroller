library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of vga_ctrl is
  begin
    p_sync: process(clk_i, reset_i)
      type t_h_sync is (bp, l, fp, r);
      type t_v_sync is (bp, f, fp, r);
      variable v_h_state: t_h_sync;
      variable v_v_state: t_v_sync;
      variable v_h_count: integer range 0 to 641;
      variable v_v_count: integer range 0 to 481;
      begin
        if reset_i = '1' then
          v_h_state := r;
          v_v_state := r;
          v_h_count := 0;
          v_v_count := 0;
          h_sync_o <= '1';
          v_sync_o <= '1';
          h_pos_o <= (others => '0');
          v_pos_o <= (others => '0');
        elsif clk_i'event and clk_i = '1' then
          if px_en_i = '1' then
            red_o   <= red_i;
            green_o <= green_i;
            blue_o  <= blue_i;

            h_sync_o <= '0';
            v_sync_o <= '0';
            h_pos_o <= (others => '0');
            v_pos_o <= (others => '0');

            v_h_count := v_h_count + 1;
            case v_h_state is
              when fp =>
                red_o   <= (others => '0');
                green_o <= (others => '0');
                blue_o  <= (others => '0');
                if v_h_count >= 16 then
                  v_h_state := r;
                  v_h_count := 0;
                  v_v_count := v_v_count + 1;
                end if;
              when r =>
                red_o   <= (others => '0');
                green_o <= (others => '0');
                blue_o  <= (others => '0');
                h_sync_o <= '1';
                if v_h_count >= 96 then
                  v_h_state := bp;
                  v_h_count := 0;
                end if;
              when bp =>
                red_o   <= (others => '0');
                green_o <= (others => '0');
                blue_o  <= (others => '0');
                if v_h_count >= 48 then
                  v_h_state := l;
                  v_h_count := 0;
                end if;
              when l =>
                h_pos_o <= std_logic_vector(to_unsigned(v_h_count - 1, h_pos_o'length));
                if v_h_count >= 640 then
                  v_h_state := fp;
                  v_h_count := 0;
                end if;
            end case;

            case v_v_state is
              when fp =>
                red_o   <= (others => '0');
                green_o <= (others => '0');
                blue_o  <= (others => '0');
                if v_v_count >= 10 then
                  v_v_state := r;
                  v_v_count := 0;
                end if;
              when r =>
                red_o   <= (others => '0');
                green_o <= (others => '0');
                blue_o  <= (others => '0');
                v_sync_o <= '1';
                if v_v_count >= 2 then
                  v_v_state := bp;
                  v_v_count := 0;
                end if;
              when bp =>
                red_o   <= (others => '0');
                green_o <= (others => '0');
                blue_o  <= (others => '0');
                if v_v_count >= 33 then
                  v_v_state := f;
                  v_v_count := 0;
                end if;
              when f =>
                v_pos_o <= std_logic_vector(to_unsigned(v_v_count, v_pos_o'length));
                if v_v_count >= 480 then
                  v_v_state := fp;
                  v_v_count := 0;
                end if;
            end case;
          end if;
        end if;
    end process;
end architecture;