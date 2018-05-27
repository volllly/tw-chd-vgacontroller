library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_controler_top is
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
end vga_controler_top;
