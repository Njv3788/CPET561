vlib work
vcom -93 -work work ../../src/HW/generic_counter.vhd
vcom -93 -work work ../../src/HW/angle_counter.vhd
vcom -93 -work work ../../src/HW/pwm_generator.vhd
vcom -93 -work work ../../src/HW/finite_state_machine.vhd
vcom -93 -work work ../../src/HW/read_only_ram.vhd
vcom -93 -work work ../../src/HW/servo_controller.vhd
vcom -93 -work work ../src/servo_controller_tb.vhd
vsim -voptargs=+acc servo_controller_tb
do wave.do
run 38000 ns
