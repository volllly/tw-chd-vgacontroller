onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib mc8051_rom_opt

do {wave.do}

view wave
view structure
view signals

do {mc8051_rom.udo}

run -all

quit -force
