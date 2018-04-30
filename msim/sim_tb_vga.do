vsim -t ns -novopt -L unisims_ver -lib work work.tb_vga work.glbl
view *

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -color yellow  -radix unsigned     /tb_vga/s_clk
add wave -noupdate -format Logic -color yellow  -radix unsigned     /tb_vga/s_reset
add wave -noupdate -format Logic -color yellow  -radix hexadecimal  /tb_vga/i_vga_controler_top/i_content_ctrl/swsync_i
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/s_h_sync
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/s_v_sync
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_vga_ctrl/p_sync/v_h_state
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_vga_ctrl/p_sync/v_v_state
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_vga_ctrl/h_pos_o
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_vga_ctrl/v_pos_o
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_content_ctrl/p_color/x_fix
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_content_ctrl/p_color/y_fix
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_content_ctrl/x_mov
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_content_ctrl/y_mov
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_content_ctrl/s_addra_mu1
add wave -noupdate -format Logic -color blue    -radix unsigned     /tb_vga/i_vga_controler_top/i_content_ctrl/s_douta_mu1
add wave -noupdate -format Logic -color green   -radix unsigned     /tb_vga/s_red
add wave -noupdate -format Logic -color green   -radix unsigned     /tb_vga/s_green
add wave -noupdate -format Logic -color green   -radix unsigned     /tb_vga/s_blue

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {0 ps}
WaveRestoreZoom {0 ps} {1 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -signalnamewidth 0
configure wave -justifyvalue left

run 1 sec