.text
.align=2

.global _start
_start:
	mov r0, #4			@Load 4 into r0
	mov r1, #5			@Load 5 into r1
	add r2, r0, r1		@Add r0 to r1 and place in r2

	add r2, r2, r2		@Add r2 (4+5) to r2 (9) and place in r2
	sub r2, r2, #3		@Subtract 3 from r2 and place in r2

	str r2, [r0, #156]	@Store r2 to 40th word in memory (r0 + 156 = 160, 160 = 40 * 4)	
S:
	B S					@Infinite loop ending
.end
	