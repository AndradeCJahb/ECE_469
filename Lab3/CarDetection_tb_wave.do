onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CarDetection_tb/CLOCK_PERIOD
add wave -noupdate /CarDetection_tb/clk
add wave -noupdate /CarDetection_tb/outer
add wave -noupdate /CarDetection_tb/inner
add wave -noupdate /CarDetection_tb/enter
add wave -noupdate /CarDetection_tb/exit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {1579 ps}
