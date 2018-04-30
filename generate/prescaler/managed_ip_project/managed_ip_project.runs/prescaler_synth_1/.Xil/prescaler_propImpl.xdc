set_property SRC_FILE_INFO {cfile:d:/work/mc8051_basys3/hw/generate/artix7_xc7a35tcpg263_1/prescaler/prescaler/prescaler.xdc rfile:../../../../prescaler/prescaler.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
