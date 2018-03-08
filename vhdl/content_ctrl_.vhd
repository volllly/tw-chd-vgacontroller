-- Author: Paul Volavsek <paul.volavsek@gmail.com> #20

library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity content_ctrl is
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
end entity;