
CSEG	AT	0

; Using R7.R6.R5.R4.R3.R2.R1.R0 as 8*8=64-bit number

MOV		R7, #0 ; * 256^7 +
MOV		R6, #0 ; * 256^6 +
MOV		R5, #0 ; * 256^5 +
MOV		R4, #0 ; * 256^4 +
MOV		R3, #0 ; * 256^3 +
MOV		R2, #0 ; * 256^2 +
MOV		R1, #1 ; * 256^1 +
MOV		R0, #7 ; * 256^0 + 1 (zero-th loop)

; Use DPTR to check if loop count was correct
MOV		DPTR, #0

LJMP SETUP


SETUP:
	INC R7
	INC R6
	INC R5
	INC R4
	INC R3
	INC R2
	INC R1
	INC R0 ; dont increment R0 to remove 0th loop (ultra expanding big brain)
	LJMP BIG_LOOP


BIG_LOOP:
	INC DPTR
	DJNZ R0, BIG_LOOP
	DJNZ R1, BIG_LOOP
	DJNZ R2, BIG_LOOP
	DJNZ R3, BIG_LOOP
	DJNZ R4, BIG_LOOP
	DJNZ R5, BIG_LOOP
	DJNZ R6, BIG_LOOP
	DJNZ R7, BIG_LOOP
	LJMP PROG_END

PROG_END:
	SJMP	PROG_END


END
