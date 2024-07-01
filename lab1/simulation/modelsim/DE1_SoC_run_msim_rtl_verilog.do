transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/andra/OneDrive/Desktop/ECE_469/labs/lab1a {C:/Users/andra/OneDrive/Desktop/ECE_469/labs/lab1a/de1_soc.sv}

