vlib work
vcom -93 -work work ../../src/HW/MULT/MULT.vhd
vcom -93 -work work ../../src/HW/generic_laterial_shift.vhd
vcom -93 -work work ../../src/HW/filter_base_16_tap.vhd
vcom -93 -work work ../src/filter_base_16_tap_tb.vhd
vsim -voptargs=+acc filter_base_16_tap_tb.vhd
do wave.do
run 5000 ns
