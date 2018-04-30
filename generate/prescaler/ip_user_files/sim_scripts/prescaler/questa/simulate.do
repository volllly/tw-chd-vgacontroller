onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib prescaler_opt

do {wave.do}

view wave
view structure
view signals

do {prescaler.udo}

run -all

quit -force
