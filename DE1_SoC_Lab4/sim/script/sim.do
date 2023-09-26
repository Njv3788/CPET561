vlib work
vcom -93 -work work ../../src/HW/lab4_top.vhd
vcom -93 -work work ../src/lab4_top_tb.vhd
vsim -voptargs=+acc lab4_top_tb
do wave.do
run 5200  ns
