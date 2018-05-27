file copy -force ../generate/MU1/MU1/MU1.mif ./
vlog ../generate/MU1/MU1/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/MU1/MU1/synth/MU1.vhd -2008

file copy -force ../generate/MU2/MU2/MU2.mif ./
vlog ../generate/MU2/MU2/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/MU2/MU2/synth/MU2.vhd -2008

vlog ../generate/glbl.v

vcom ../vhdl/content_ctrl_.vhd -2008
vcom ../vhdl/content_ctrl_rtl.vhd -2008 
vcom ../vhdl/io_ctrl_.vhd -2008 
vcom ../vhdl/io_ctrl_rtl.vhd -2008 
vcom ../vhdl/top_.vhd -2008 
vcom ../vhdl/top_struc.vhd -2008 
vcom ../vhdl/vga_ctrl_.vhd -2008 
vcom ../vhdl/vga_ctrl_rtl.vhd -2008 

vcom ../tb/tb_io_ctrl.vhd -2008 
vcom ../tb/tb_vga_ctrl.vhd -2008 
vcom ../tb/tb_vga.vhd -2008 
vcom ../tb/vga_monitor_.vhd -2008 
vcom ../tb/vga_monitor_sim.vhd -2008 