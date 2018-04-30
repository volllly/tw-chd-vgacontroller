file copy -force ../generate/MU1/MU1/MU1.mif ./
vlog ../generate/MU1/MU1/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/MU1/MU1/synth/MU1.vhd -2008

file copy -force ../generate/MU2/MU2/MU2.mif ./
vlog ../generate/MU2/MU2/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/MU2/MU2/synth/MU2.vhd -2008


vlog ../generate/prescaler/prescaler/prescaler_clk_wiz.v
vlog ../generate/prescaler/prescaler/prescaler.v
vlog ../generate/mc8051_rom/mc8051_rom/blk_mem_gen_v8_3_2/simulation/blk_mem_gen_v8_3.v
vcom ../generate/mc8051_rom/mc8051_rom/synth/mc8051_rom.vhd -2008
vcom ../generate/mc8051_ram/mc8051_ram/synth/mc8051_ram.vhd -2008

vlog ../generate/glbl.v

vcom ../vhdl/mc8051/mc8051_p.vhd -2008
     
vcom ../vhdl/mc8051/control_mem_.vhd -2008
vcom ../vhdl/mc8051/control_mem_rtl.vhd -2008
vcom ../vhdl/mc8051/control_mem_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/control_fsm_.vhd -2008
vcom ../vhdl/mc8051/control_fsm_rtl.vhd -2008
vcom ../vhdl/mc8051/control_fsm_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/mc8051_control_.vhd -2008
vcom ../vhdl/mc8051/mc8051_control_struc.vhd -2008
vcom ../vhdl/mc8051/mc8051_control_struc_cfg.vhd -2008
     
vcom ../vhdl/mc8051/alucore_.vhd -2008
vcom ../vhdl/mc8051/alucore_rtl.vhd -2008
vcom ../vhdl/mc8051/alucore_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/alumux_.vhd -2008
vcom ../vhdl/mc8051/alumux_rtl.vhd -2008
vcom ../vhdl/mc8051/alumux_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/addsub_cy_.vhd -2008
vcom ../vhdl/mc8051/addsub_cy_rtl.vhd -2008
vcom ../vhdl/mc8051/addsub_cy_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/addsub_ovcy_.vhd -2008
vcom ../vhdl/mc8051/addsub_ovcy_rtl.vhd -2008
vcom ../vhdl/mc8051/addsub_ovcy_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/addsub_core_.vhd -2008
vcom ../vhdl/mc8051/addsub_core_struc.vhd -2008
vcom ../vhdl/mc8051/addsub_core_struc_cfg.vhd -2008
     
vcom ../vhdl/mc8051/comb_divider_.vhd -2008
vcom ../vhdl/mc8051/comb_divider_rtl.vhd -2008
vcom ../vhdl/mc8051/comb_divider_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/comb_mltplr_.vhd -2008
vcom ../vhdl/mc8051/comb_mltplr_rtl.vhd -2008
vcom ../vhdl/mc8051/comb_mltplr_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/dcml_adjust_.vhd -2008
vcom ../vhdl/mc8051/dcml_adjust_rtl.vhd -2008
vcom ../vhdl/mc8051/dcml_adjust_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/mc8051_alu_.vhd -2008
vcom ../vhdl/mc8051/mc8051_alu_struc.vhd -2008
vcom ../vhdl/mc8051/mc8051_alu_struc_cfg.vhd -2008
     
vcom ../vhdl/mc8051/mc8051_siu_.vhd -2008
vcom ../vhdl/mc8051/mc8051_siu_rtl.vhd -2008
vcom ../vhdl/mc8051/mc8051_siu_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/mc8051_tmrctr_.vhd -2008
vcom ../vhdl/mc8051/mc8051_tmrctr_rtl.vhd -2008
vcom ../vhdl/mc8051/mc8051_tmrctr_rtl_cfg.vhd -2008
     
vcom ../vhdl/mc8051/mc8051_core_.vhd -2008
vcom ../vhdl/mc8051/mc8051_core_struc.vhd -2008
vcom ../vhdl/mc8051/mc8051_core_struc_cfg.vhd -2008
  
vcom ../vhdl/mc8051/mc8051_top_.vhd -2008
vcom ../vhdl/mc8051/mc8051_top_struc.vhd -2008
vcom ../vhdl/mc8051/mc8051_top_struc_cfg.vhd -2008


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