.global _start
_start:
	MOVW R0, #0x0000
	MOVT R0, #0x3F01  			@ Load first operand into R0, 0.50390625 in this example
	MOVW R1, #0xFFB0
	MOVT R1, #0x477F  			@ Load second operand into R1, 65535.6875 in this example
	MOVT R12, 0x7F80			@ Load Mask for exponent into R12
	MOVW R11, #0xFFFF				
	MOVT R11, #0x007F			@ Load Mask for Fraction into R11
	MOVT R10, #0x0080			@ Load 1 to be appended to mantissa in R10
	MOVT R9, #0x0100			@ Load mask to check for overflow in R9
	AND R2, R0, R12			 	@ Mask exponent of R0, store in R2
	AND R3, R1, R12  			@ Mask exponent of R1, store in R3
	LSR R2, R2, #23      		@ Shift down exponent of R0, store in R2
	LSR R3, R3, #23      		@ Shift down exponent of R1, store in R3
	CMP R2, R3           		@ Compare exponents
	BGT R2LARGE          		@ Branch if R2 > R3 (R0 exp - R1 exp)
	SUB R4, R3, R2				@ Get difference of large - small exponent and store in R4
	MOV R2, R3					@ Result exponent in R2
	MOV R3, R4					@ Store difference of large - small exponent in R3
	B MANTISSA           		@ Branch to Mantissa manipulation
R2LARGE:
	SUB R3, R2, R3				@ Store difference of large - small exponent in R3
MANTISSA:
	AND R4, R0, R11			 	@ Mask fraction of R0, store in R4
	ORR R4, R4, R10			  	@ Append leading 1 to form the mantissa of R0
	AND R5, R1, R11			  	@ Mask fraction of R1, store in R5
	ORR R5, R5, R10			  	@ Append leading 1 to form the mantissa of R1
	CMP R0, R1					
	BGT ALIGN_R1         		@ Branch if R0 > R1
	LSR R4, R4, R3      		@ Right shift mantissa of R1 by difference in exponents
	B ADD_MANTISSAS	
ALIGN_R1:
	LSR R5, R5, R3       		@ Right shift mantissa of R0 by difference in exponents
ADD_MANTISSAS:
	ADD R6, R4, R5       		@ Sum the mantissas, store in R6
	AND R7, R6, R9 				@ Use Mask to determine if overflow occured
	CMP R7, #0					
	BEQ FINISH        			@ If no overflow, branch to finish
	LSR R6, R6, #1       		@ Right shift mantissa by 1
	ADD R2, R2, #1       		@ Increment the exponent by 1
FINISH:
	AND R6, R6, R11 			@ Mask Mantissa back to 23 bits
	LSL R2, R2, #23      		@ Shift exponent back up
	ORR R0, R6, R2          	@ Store the result in R0 (65536.1875) 
DONE:
	B DONE						@ R0 now contains the result of the floating-point addition
.end