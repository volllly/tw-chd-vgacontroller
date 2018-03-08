library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_ctrl is
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
end entity;