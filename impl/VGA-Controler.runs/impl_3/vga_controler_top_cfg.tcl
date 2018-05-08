proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir C:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/impl/VGA-Controler.cache/wt [current_project]
  set_property parent.project_path C:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/impl/VGA-Controler.xpr [current_project]
  set_property ip_repo_paths c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/impl/VGA-Controler.cache/ip [current_project]
  set_property ip_output_repo c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/impl/VGA-Controler.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet C:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/impl/VGA-Controler.runs/synth_2/vga_controler_top_cfg.dcp
  add_files -quiet c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/MU3/MU3/MU3.dcp
  set_property netlist_only true [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/MU3/MU3/MU3.dcp]
  add_files -quiet c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/MU2/MU2/MU2.dcp
  set_property netlist_only true [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/MU2/MU2/MU2.dcp]
  add_files -quiet c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/MU1/MU1/MU1.dcp
  set_property netlist_only true [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/MU1/MU1/MU1.dcp]
  add_files -quiet c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/mc8051_ram/mc8051_ram/mc8051_ram.dcp
  set_property netlist_only true [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/mc8051_ram/mc8051_ram/mc8051_ram.dcp]
  add_files -quiet c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/PLL/PLL/PLL.dcp
  set_property netlist_only true [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/PLL/PLL/PLL.dcp]
  add_files -quiet c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/mc8051_rom/mc8051_rom/mc8051_rom.dcp
  set_property netlist_only true [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/mc8051_rom/mc8051_rom/mc8051_rom.dcp]
  read_xdc -prop_thru_buffers -ref PLL -cells inst c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/PLL/PLL/PLL_board.xdc
  set_property processing_order EARLY [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/PLL/PLL/PLL_board.xdc]
  read_xdc -ref PLL -cells inst c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/PLL/PLL/PLL.xdc
  set_property processing_order EARLY [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/PLL/PLL/PLL.xdc]
  read_xdc -mode out_of_context -ref mc8051_rom -cells U0 c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/mc8051_rom/mc8051_rom/mc8051_rom_ooc.xdc
  set_property processing_order EARLY [get_files c:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/generate/mc8051_rom/mc8051_rom/mc8051_rom_ooc.xdc]
  read_xdc C:/Users/Paul/Desktop/Technikum/4_Semester/CHD/VGA-Controler/impl/VGA-Controler.srcs/constrs_1/new/VGA-Contrler-constrs.xdc
  link_design -top vga_controler_top_cfg -part xc7a35tcpg236-1
  write_hwdef -file vga_controler_top_cfg.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force vga_controler_top_cfg_opt.dcp
  report_drc -file vga_controler_top_cfg_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design -directive ExtraPostPlacementOpt
  write_checkpoint -force vga_controler_top_cfg_placed.dcp
  report_io -file vga_controler_top_cfg_io_placed.rpt
  report_utilization -file vga_controler_top_cfg_utilization_placed.rpt -pb vga_controler_top_cfg_utilization_placed.pb
  report_control_sets -verbose -file vga_controler_top_cfg_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step phys_opt_design
set rc [catch {
  create_msg_db phys_opt_design.pb
  phys_opt_design -directive AlternateFlowWithRetiming
  write_checkpoint -force vga_controler_top_cfg_physopt.dcp
  close_msg_db -file phys_opt_design.pb
} RESULT]
if {$rc} {
  step_failed phys_opt_design
  return -code error $RESULT
} else {
  end_step phys_opt_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design -directive Explore
  write_checkpoint -force vga_controler_top_cfg_routed.dcp
  report_drc -file vga_controler_top_cfg_drc_routed.rpt -pb vga_controler_top_cfg_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file vga_controler_top_cfg_timing_summary_routed.rpt -rpx vga_controler_top_cfg_timing_summary_routed.rpx
  report_power -file vga_controler_top_cfg_power_routed.rpt -pb vga_controler_top_cfg_power_summary_routed.pb -rpx vga_controler_top_cfg_power_routed.rpx
  report_route_status -file vga_controler_top_cfg_route_status.rpt -pb vga_controler_top_cfg_route_status.pb
  report_clock_utilization -file vga_controler_top_cfg_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

