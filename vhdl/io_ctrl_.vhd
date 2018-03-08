library IEEE; 
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity io_ctrl is
  port(
    clk_i:      in  std_logic;
    reset_i:    in  std_logic;
    sw_i:       in  std_logic_vector(15 downto 0);
    pb_i:       in  std_logic_vector(3  downto 0);
    
    swsync_o:   out std_logic_vector(15 downto 0);
    pbsync_o:   out std_logic_vector(3  downto 0);
    px_en_o:    out std_logic
  );
end entity;