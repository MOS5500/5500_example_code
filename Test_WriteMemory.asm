; This program Try Memory Write with different Data Size
; 
; Author: Claudio "CP" La Rosa
; Public version 1.0 - June 2026

.ORG 0

.INCLUDE list.i
.INCLUDE serial.i


.DATA


	str_hd				DC4.T 10,13,"Memory Write Test",0

	str_1				DC4.T 10,13,"Value to Store from register: ",0
	str_2				DC4.T 10,13,"Value to store from memory:   ",0
	str_short			DC4.T 10,13,"***** SHORT test *****",0
	str_tryte			DC4.T 10,13,"***** TRYTE test *****",0

	str_push_tttt		DC4.T 10,13,"***** Stack: Tryte-Tryte-Tryte-Tryte *****",0
	str_push_tst		DC4.T 10,13,"***** Stack: Tryte-Short-Tryte *****",0
	str_push_tts		DC4.T 10,13,"***** Stack: Tryte-Tryte-Short *****",0
	str_push_stt		DC4.T 10,13,"***** Stack: Short-Tryte-Tryte *****",0
	str_push_ss			DC4.T 10,13,"***** Stack: Short-Short *****",0

	str_pop_st1		DC4.T 10,13,"***** Load Tryte from stack. Should be 8 ***** ",0
	str_pop_st2		DC4.T 10,13,"***** Load Tryte from stack. Should be 7 ***** ",0
	str_pop_st3		DC4.T 10,13,"***** Load Tryte from stack. Should be 5 ***** ",0
	str_pop_st4		DC4.T 10,13,"***** Load Tryte from stack. Should be 4 ***** ",0
	
	
	

	
	
	;
	; ERRORS
	;
	str_div_by_zero	DC.T "Division By Zero: FATAL error.",0
	

	

.CODE

	;--------------------------------------
	 ;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2
	;---------------------------------------


	;-------- Stack initializing ----------
	 ANYI R60,R0,#8000	;R60 Stack address for kernel procedures
	 STSP R60			;Kernel Stack 
	 ;--------------------------------------

	 ;-- for print integer ternary
	 ANYI R15,R0,#24

	
	; Print Header
	 LEA R27,str_hd
	 JSR println

	 JSR new_line
	 JSR new_line
	 LEA R27,str_short
	 JSR println

	
	;------------------- FIll Memory
	ANYI R1,R0,#15000	; Start Address
	;Value to store
	ANYI R2,R0,#265720
	ASHI R2,R2,#-12
	ANYI R2,R2,#265720



	ST.W 0(R1),R2; Store R2 in Address 15000

	;---- Print value from register
	LEA R27,str_1
	JSR print

	ANY R10,R0,R2
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	ANYI R10,R0,#0	;set R10 to 0 before load from memory

	;---- Print value from memory
	LEA R27,str_2
	JSR print

	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	
	; write a short value at address 15000
	ANYI R2,R0,#-265720
	ST.S 0(R1),R2

	;---- Print value from memory after short write
	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;************************************************************

	JSR new_line
	;------------------- FIll Memory
	ANYI R1,R0,#15000	; Start Address
	;Value to store
	ANYI R2,R0,#265720
	ASHI R2,R2,#-12
	ANYI R2,R2,#265720
	

	ST.W 0(R1),R2; Store R2 in Address 15000

	;---- Print value from memory
	LEA R27,str_2
	JSR print

	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	
	; write a short value at address ** 15001 **
	INC R1
	ANYI R2,R0,#-265720
	ST.S 0(R1),R2

	;---- Print value from memory after short write
	DEC R1
	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;************************************************************
	JSR new_line
	;------------------- FIll Memory
	ANYI R1,R0,#15000	; Start Address
	;Value to store
	ANYI R2,R0,#265720
	ASHI R2,R2,#-12
	ANYI R2,R2,#265720
	

	ST.W 0(R1),R2; Store R2 in Address 15000

	ANYI R10,R0,#0	;set R10 to 0 before load from memory

	;---- Print value from memory
	LEA R27,str_2
	JSR print

	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	
	; write a short value at address ** 15002 **
	INC R1
	INC R1
	ANYI R2,R0,#-265720
	ST.S 0(R1),R2

	;---- Print value from memory after short write
	ANYI R1,R0,#15000	; Start Address
	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;************************************************************
	;***********************   TRYTE        *********************
	;************************************************************
	JSR new_line
	JSR new_line
	LEA R27,str_tryte
	JSR println
	;------------------- FIll Memory
	ANYI R1,R0,#15000	; Start Address
	;Value to store
	ANYI R2,R0,#265720
	ASHI R2,R2,#-12
	ANYI R2,R2,#265720
	

	ST.W 0(R1),R2; Store R2 in Address 15000

	;---- Print value from memory
	LEA R27,str_2
	JSR print

	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	
	; write a TRYTE value at address ** 15000 **
	ANYI R2,R0,#-364
	ST.T 0(R1),R2

	ANYI R10,R0,#0	;set R10 to 0 before load from memory

	;---- Print value from memory after tryte write
	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;Write a TRYTE at address 15001
	;------------------- FIll Memory
	ANYI R1,R0,#15000	; Start Address
	;Value to store
	ANYI R2,R0,#265720
	ASHI R2,R2,#-12
	ANYI R2,R2,#265720
	

	ST.W 0(R1),R2; Store R2 in Address 15000

	;---- Print value from memory
	LEA R27,str_2
	JSR print

	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	
	; write a TRYTE value at address ** 15001 **
	INC R1
	ANYI R2,R0,#-364
	ST.T 0(R1),R2

	ANYI R10,R0,#0	;set R10 to 0 before load from memory

	;---- Print value from memory after tryte write
	DEC R1
	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;Write a TRYTE at address 15002
	;------------------- FIll Memory
	ANYI R1,R0,#15000	; Start Address
	;Value to store
	ANYI R2,R0,#265720
	ASHI R2,R2,#-12
	ANYI R2,R2,#265720
	

	ST.W 0(R1),R2; Store R2 in Address 15000

	;---- Print value from memory
	LEA R27,str_2
	JSR print

	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	
	; write a TRYTE value at address ** 15002 **
	INC R1
	INC R1
	ANYI R2,R0,#-364
	ST.T 0(R1),R2

	ANYI R10,R0,#0	;set R10 to 0 before load from memory

	;---- Print value from memory after tryte write
	DEC R1
	DEC R1
	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;Write a TRYTE at address 15003
	;------------------- FIll Memory
	ANYI R1,R0,#15000	; Start Address
	;Value to store
	ANYI R2,R0,#265720
	ASHI R2,R2,#-12
	ANYI R2,R2,#265720
	

	ST.W 0(R1),R2; Store R2 in Address 15000

	;---- Print value from memory
	LEA R27,str_2
	JSR print

	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line
	
	; write a TRYTE value at address ** 15003 **
	ADDI R1,R1,#3
	ANYI R2,R0,#-364
	ST.T 0(R1),R2

	ANYI R10,R0,#0	;set R10 to 0 before load from memory

	;---- Print value from memory after tryte write
	SUBI R1,R1,#3
	LD R10,0(R1)
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;************************************************************
	;***********************     PUSH       *********************
	;************************************************************
	
	; -------------- PUSH Tryte - Tryte - Tryte - Tryte values -------

	LEA R27,str_push_tttt
	JSR println

	ANYI R5,R0,#4
	PUSH.T R5
	INC R5
	PUSH.T R5
	INC R5
	PUSH.T R5
	INC R5
	PUSH.T R5

	;POP values
	ANYI R10,R0,#265720
	POP.W R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line


	;-------------- Push Tryte - Short - Tryte ----------------
	LEA R27,str_push_tst
	JSR println
	ANYI R5,R0,#4
	PUSH.T R5
	INC R5
	PUSH.S R5
	INC R5
	PUSH.T R5
	
	;POP values
	ANYI R10,R0,#265720
	POP.W R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;-------------- Push Tryte - Tryte - Short ----------------
	LEA R27,str_push_tts
	JSR println
	ANYI R5,R0,#4
	PUSH.T R5
	INC R5
	PUSH.T R5
	INC R5
	PUSH.S R5
	
	;POP values
	ANYI R10,R0,#265720
	POP.W R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;-------------- Push Short - Tryte - Tryte ----------------
	LEA R27,str_push_stt
	JSR println
	ANYI R5,R0,#4
	PUSH.S R5
	INC R5
	PUSH.T R5
	INC R5
	PUSH.T R5
	
	;POP values
	ANYI R10,R0,#265720
	POP.W R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	;-------------- Push Short - Short ----------------
	LEA R27,str_push_ss
	JSR println
	ANYI R5,R0,#4
	PUSH.S R5
	INC R5
	PUSH.S R5

	
	;POP values
	ANYI R10,R0,#265720
	POP.W R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line




	;--------


	
	ANYI R1,R0,#4
	PUSH.T R1
	ANYI R1,R0,#3652
	PUSH.S R1
	ANYI R1,R0,#8
	PUSH.T R1

	ANY R10,R0,R0
	


	LEA R27,str_pop_st1
	JSR print
	POP.T R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	LEA R27,str_pop_st2
	JSR print
	POP.T R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line

	LEA R27,str_pop_st3
	JSR print
	POP.T R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line


	LEA R27,str_pop_st4
	JSR print
	POP.T R10
	JSR print_integer_ternary	; Print R10 value in ternary
	JSR new_line





	

	HLT 
	;-----------------------------------------------


	
	;-------------------
	; NEW LINE
	;
	; input:	R7  Serial Port
	;-------------------
	
	new_line:
	;PROLOGUE
	PUSH R4
	;Insert return value on the stack
	PUSH R26

	;new line
	ANYI R4,R0,#10	;<LF>
	OUT 0(R7),R4
	ANYI R4,R0,#13	;<CR>
	OUT 0(R7),R4 

	;EPILOGUE
	POP.W R26
	POP.W R4
	
	JR R26

	;------------------------------ END new_line



	

	;-------------------
	; INTEGER TO STRING
	; input:	R5 24 trit Integer
	;			R6 string buffer
	;-------------------
	
	integer_to_string:
	;PROLOGUE
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R10
	PUSH R11
	PUSH R12
	PUSH R13
	;Insert return value on the stack
	PUSH R26


	ANYI R3,R0,#0 ; Set as positive number
	JBE R5,R0,integer_to_string_start
	ANYI R3,R0,#1 ; Is a negative number
	STI R5,R5

	integer_to_string_start:
	ANYI R4,R0,#0		;contatore cifre

	integer_to_string_loop:
	ANY R10,R0,R5
	ANYI R11,R0,#10	;divisore
	DIV R10,R12,R11,R10	;R10 = R10 rem R11   R12 = R10/R11

	ADDI R10,R10,#48	;aggiungo 48 al resto
	PUSH.W R10

	ADDI R4,R4,#1	;contatore cifre
	ANY R5,R0,R12
	JB R12,R0,integer_to_string_loop


	;is a positive number?
	JEQ R3,R0,integer_to_string_view_cifra
	;is is a negative number, I write '-'
	ANYI R13,R0,#45	; '-' char
	ST 0(R6),R13
	ADDI R6,R6,#4

	integer_to_string_view_cifra:
	POP.W R13
	ST 0(R6),R13
	ADDI R6,R6,#4


	ADDI R4,R4,#-1
	JB R4,R0,integer_to_string_view_cifra
	
	ST 0(R6),R0
		
	;EPILOGUE
	POP.W R26
	POP.W R13
	POP.W R12
	POP.W R11
	POP.W R10
	POP.W R6
	POP.W R5
	POP.W R4
	POP.W R3

	JR R26
	;---------- END INTEGER TO STRING


	





	

	;------------  print_spaces -----------
	; INPUT 
	; R60 numbers of spaces
	print_spaces:
	;PROLOGUE
	PUSH R60
	PUSH R61
	;Insert return value on the stack
	PUSH.W R26

	ANYI R61,R0,#32	;space

	loop_print_spaces:
	JEQ R60,R0,exit_print_spaces
	SUBI R60,R60,#1
	OUT 0(R7),R61
	JMP loop_print_spaces
	
	exit_print_spaces:
	;EPILOGUE
	POP.W R26
	POP.W R61
	POP.W R60
	JR R26

	


	.INCLUDE COMMON/IO_fun.i
	

	
