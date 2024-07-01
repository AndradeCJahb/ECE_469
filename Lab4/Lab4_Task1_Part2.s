.global _start
_start:
	
	MOV r0, #3
LOOP:
	PUSH {LR}
	CMP R0, #1
	BGT ELSE
	MOV R0, #1
	ADD SP, SP, #8
	MOV PC, LR
ELSE:
	SUB R0, R0, #1
	BL LOOP
	POP {LR}
	MUL R0, R1, R0
	MOV PC, LR
	.end