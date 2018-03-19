library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of vga_ctrl is
  signal s_h_count: std_logic_vector(9 downto 0);
  signal s_v_count: std_logic_vector(9 downto 0);
  begin
    red_o <= red_i;
    green_o <= green_i;
    blue_o <= blue_i;

    p_h: process(clk_i, reset_i)
      variable v_h_count: integer range 0 to 800;
      variable v_h_pos: integer range 0 to 640;
      begin
        if reset_i = '1' then
          v_h_count := 0;
          v_h_pos := 0;
          h_sync_o <= '0';
        elsif clk_i'event and clk_i = '1' then
          if px_en_i = '1' then
            if v_h_count >= 800 then
              v_h_count := 0;
            else
              v_h_count := v_h_count + 1;
            end if;
            
            if v_h_count < 144 then
              h_sync_o <= '1';
            else 
              h_sync_o <= '0';
            end if;

            if v_h_count >= 144 and v_h_count < 144 + 640 then
              v_h_pos := v_h_count - 144;
            end if;
          end if;
        end if;
        s_h_count <= std_logic_vector(to_unsigned(v_h_count, s_h_count'length));
        h_pos_o <= std_logic_vector(to_unsigned(v_h_pos, h_pos_o'length));
    end process;

    p_v: process(clk_i, reset_i)
      variable v_v_count: integer range 0 to 252;
      variable v_v_pos: integer range 0 to 480;
      begin
        if reset_i = '1' then
          v_v_count := 0;
          v_v_pos := 0;
          v_sync_o <= '0';
        elsif clk_i'event and clk_i = '1' then
          if px_en_i = '1' and v_v_count = 96 then
            if v_v_count >= 525 then
              v_v_count := 0;
            else
              v_v_count := v_v_count + 1;
            end if;
            
            if v_v_count < 35 then
              v_sync_o <= '1';
            else 
              v_sync_o <= '0';
            end if;

            if v_v_count >= 35 and v_v_count < 35 + 480 then
              v_v_pos := v_v_count - 35;
            end if;
          end if;
        end if;
        s_v_count <= std_logic_vector(to_unsigned(v_v_count, s_v_count'length));
        v_pos_o <= std_logic_vector(to_unsigned(v_v_pos, v_pos_o'length));
    end process;
end architecture;