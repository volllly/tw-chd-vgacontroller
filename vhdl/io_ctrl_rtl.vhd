library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

architecture rtl of io_ctrl is
  signal s_int_clk_enable: std_logic;                 -- 1KHz clock enable signal for debounce and 7 segment selection

  begin
    b_int_clk: block                                -- generation of s_int_clk_enable
      constant c_iclk_f: integer := 100000;         -- system clock divisor
      begin
        p_int_clk: process(reset_i, clk_i)
          variable v_pxen_f: integer := 0;
          begin
            if reset_i = '1' then
              v_pxen_f := 0;
            elsif clk_i = '1' and clk_i'event then
              v_pxen_f := v_pxen_f + 1;               -- counts systemclocks
              if v_pxen_f = c_iclk_f then             -- and enables s_int_clk_enable every 100000th tick
                s_int_clk_enable <= '1';
                v_pxen_f := 0;
              else
                s_int_clk_enable <= '0';        -- for one tick
              end if;
            end if;
        end process;
    end block;

    b_px_en: block                                -- generation of s_int_clk_enable
      constant c_pxen_f: integer := 4;         -- system clock divisor
      begin
        p_px_en: process(reset_i, clk_i)
          variable v_pxen_f: integer := 0;
          begin
            if reset_i = '1' then
              v_pxen_f := 0;
            elsif clk_i = '1' and clk_i'event then
              v_pxen_f := v_pxen_f + 1;               -- counts systemclocks
              if v_pxen_f = c_pxen_f then             -- and enables s_int_clk_enable every 100000th tick
                px_en_o <= '1';
                v_pxen_f := 0;
              else
              px_en_o <= '0';        -- for one tick
              end if;
            end if;
        end process;
    end block;
    
    b_i_sync: block                                         -- debouncing and sync logic for pb and sw
      signal s_swsync_db: std_logic_vector(15 downto 0);  -- last state of switchbuttons
      signal s_pbsync_db: std_logic_vector(3 downto 0);   -- last state of pushbuttons
      begin
        p_swsync: process(reset_i, clk_i)               -- debounce switchbuttons
          begin
            if reset_i = '1' then
              s_swsync_db <= (others => '0');
              swsync_o <= (others => '0');
            elsif clk_i = '1' and clk_i'event then  -- with 1KHz
              if s_int_clk_enable = '1' then
                s_swsync_db <= sw_i;                                              -- save the current state  
                swsync_o <= sw_i and s_swsync_db;                               -- and if the last state of one button equals the current state of the same button output that state
              end if;
            end if;
        end process;

        p_pbsync: process(reset_i, clk_i)               -- debounce switchbuttons (same principle as above)
          begin
            if reset_i = '1' then
              s_pbsync_db <= (others => '0');
              pbsync_o <= (others => '0');
            elsif clk_i = '1' and clk_i'event then
              if s_int_clk_enable = '1' then
                s_pbsync_db <= pb_i;
                pbsync_o <= pb_i and s_pbsync_db;
              end if;
            end if;
        end process;
    end block;
end architecture;