sdcc ../sw/src/main.c -o ../sw/build/
echo "sdcc: main.c sucessfully compiled"
../sw/tools/packihx_tcl/win/packihx_tcl.exe ../sw/build/main.ihx ../sw/build/mc8051_rom.hex

../sw/tools/convhex/win/convhex.exe ../sw/build/mc8051_rom.hex

file copy -force ../sw/build/mc8051_rom.mif ../msim/

echo "mc8051 software application built successfully!"
