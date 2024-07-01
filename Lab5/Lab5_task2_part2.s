.equ PUSHBUTTON, 0xFF200050
.equ LED, 0xFF200000
start:
	movia r2,PUSHBUTTON
	ldwio r3,(r2) 	# Read in buttons - active high
	movia r2,LED
	stwio r3,0(r2) 	# Write to LEDs
	br start