onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /occupancy_tb/clk
add wave -noupdate /occupancy_tb/reset
add wave -noupdate /occupancy_tb/enter
add wave -noupdate /occupancy_tb/exit
add wave -noupdate /occupancy_tb/HEX5
add wave -noupdate /occupancy_tb/HEX4
add wave -noupdate /occupancy_tb/HEX3
add wave -noupdate /occupancy_tb/HEX2
add wave -noupdate /occupancy_tb/HEX1
add wave -noupdate /occupancy_tb/HEX0
add wave -noupdate /occupancy_tb/dut/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {301 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {4 ns}
