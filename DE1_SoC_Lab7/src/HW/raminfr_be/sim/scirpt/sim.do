vlib work
vcom -93 -work work ../../src/raminfr.vhd
vcom -93 -work work ../../src/raminfr_be.vhd
vcom -93 -work work ../src/raminfr_be_tb.vhd
vsim -voptargs=+acc raminfr_be_tb
do wave.do
run 178272 ns