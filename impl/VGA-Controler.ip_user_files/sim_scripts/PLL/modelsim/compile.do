vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -incr -sv "+incdir+../../../ipstatic/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/clk_wiz_v5_3_0" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_base.sv" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dpdistram.sv" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_dprom.sv" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sdpram.sv" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_spram.sv" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_sprom.sv" \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_memory/hdl/xpm_memory_tdpram.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2016.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic/clk_wiz_v5_3_0" "+incdir+../../../ipstatic/clk_wiz_v5_3_0" \
"../../../../../generate/PLL/PLL/PLL_clk_wiz.v" \
"../../../../../generate/PLL/PLL/PLL.v" \

vlog -work xil_defaultlib "glbl.v"
