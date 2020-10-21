; Task 1

DSEG	AT	30h
ARG_0:		DS	4
ARG_1:		DS	4
ARG_SIZE:	DS	1

CSEG	AT	0

RESET:
	AJMP	MAIN
;--------------------------------	
;Here goes your solution
ADD_M:
	CLR C
	INC R7
	DJNZ R7, ADD_IN_LOOP ; check if number of bytes is not 0
	RET
ADD_IN_LOOP:
	MOV A, @R0
	ADDC A, @R1
	MOV @R0, A
	INC R0
	INC R1
	DJNZ R7, ADD_IN_LOOP
	RET

;--------------------------------

MAIN:
	MOV		SP, #7Fh	
	MOV		DPTR, #TEST_DATA
TEST_LP:	
	MOV		R7, #9
	MOV		R0, #ARG_0
LD_LP:
	CLR		A
	MOVC	A, @A+DPTR
	MOV		@R0, A
	INC		DPTR
	INC		R0
	DJNZ	R7, LD_LP
	JZ		STOP
	MOV		R0, #ARG_0
	MOV		R1, #ARG_1
	MOV		R7, ARG_SIZE	
	ACALL	ADD_M

TEST_STEP:	
	SJMP	TEST_LP
	
STOP:
	SJMP	STOP
	
	
TEST_DATA:
	DB 0xA5, 0xA5, 0x17, 0xC0, 0xFC, 0x44, 0x9E, 0x36, 3
	DB 0x41, 0xF9, 0x6E, 0xE1, 0x56, 0xF0, 0x58, 0x31, 2
	DB 0x9F, 0x12, 0x06, 0xE9, 0xB1, 0x9B, 0x9D, 0xDA, 3
	DB 0xF9, 0x1A, 0x15, 0x65, 0x2F, 0xE8, 0xD4, 0x24, 4
	DB 0x2A, 0x3F, 0xA0, 0x97, 0x85, 0x33, 0xDA, 0xA2, 4
	DB 0x03, 0xF1, 0x0C, 0x8F, 0x8B, 0x52, 0x72, 0x65, 3
	DB 0xA4, 0xEA, 0x1C, 0xC9, 0x76, 0x36, 0xEE, 0xB0, 4
	DB 0xA5, 0x46, 0xAC, 0x4A, 0x61, 0x2D, 0x34, 0xA6, 3
	DB 0x62, 0xA6, 0x57, 0x5F, 0x1C, 0xF7, 0x44, 0xDA, 1
	DB 0xEC, 0x2B, 0x30, 0xAF, 0x4A, 0xA5, 0x15, 0x1D, 3
	DB 0x54, 0x8B, 0xFD, 0xD0, 0x48, 0x35, 0xC3, 0x6A, 1
	DB 0x0F, 0x81, 0x1B, 0x87, 0xAD, 0x49, 0x83, 0xD2, 1
	DB 0xF7, 0xCC, 0xBF, 0x48, 0xBE, 0x74, 0xB6, 0x1B, 3
	DB 0x79, 0xF2, 0x2D, 0x00, 0xBE, 0xF6, 0x91, 0x10, 4
	DB 0x09, 0x28, 0x06, 0xB0, 0x58, 0x1B, 0x3A, 0xCB, 4
	DB 0xD9, 0x8D, 0x5E, 0x4E, 0xB4, 0xA9, 0x5E, 0x72, 3
	DB 0x59, 0xC3, 0x95, 0x74, 0x79, 0xC8, 0xEC, 0x2D, 1
	DB 0x59, 0xC3, 0x95, 0x74, 0x79, 0xC8, 0xEC, 0x2D, 0
	
	END
	
