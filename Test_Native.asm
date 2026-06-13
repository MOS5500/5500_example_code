;Test of Native ternary Functions
;
;Author: Claudio La Rosa
;
;Public version 1.0 - June 2026


.ORG 0

.INCLUDE list.i
.INCLUDE serial.i
.INCLUDE SDCard.i

.DATA


	str_hd				DC4.T "Ternary Native Functions Test",0
	str_content			DC4.T "Start value:",9,0
	
	str_sti				DC4.T "STI",9,9,0
	str_nti				DC4.T "NTI",9,9,0
	str_pti				DC4.T "PTI",9,9,0
	str_swp				DC4.T "SWP",9,9,0
	str_swn				DC4.T "SWN",9,9,0
	str_rou				DC4.T "ROU",9,9,0
	str_rod				DC4.T "ROD",9,9,0
	str_shu				DC4.T "SHU",9,9,0
	str_shd				DC4.T "SHD",9,9,0
	str_clu				DC4.T "CLU",9,9,0
	str_cld				DC4.T "CLD",9,9,0
	str_epti			DC4.T "EPTI",9,9,0
	str_enti			DC4.T "ENTI",9,9,0
	str_decot			DC4.T "DECOT",9,9,0
	str_decou			DC4.T "DECOU",9,9,0

	str_min				DC4.T "MIN",9,9,0
	str_max				DC4.T "MAX",9,9,0
	str_txor			DC4.T "TXOR",9,9,0
	str_sum				DC4.T "SUM",9,9,0
	str_cons			DC4.T "CONS",9,9,0
	str_equal			DC4.T "EQUAL",9,9,0
	str_any				DC4.T "ANY",9,9,0
	str_impl			DC4.T "IMPL",9,9,0
	
	
	


.CODE

	;--------------------------------------
	
	 ;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2
	;---------------------------------------


	;-------- Stack initializing ----------
	 ANYI R60,R0,#8000	;R60 Stack address
	 STSP R60			;Kernel Stack 
	;--------------------------------------


	
	LEA R27,str_hd
	JSR println

	LEA R27,str_content
	JSR print

	ANYI R1,R0,#8 ; +0-

	;view the start value
	ANYI R15,R0,#3
	ANY R10,R0,R1
	JSR print_integer_ternary
	JSR new_line
	JSR new_line

	;	--- STI ---
	LEA R27,str_sti
	JSR print
	STI R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- PTI ---
	LEA R27,str_pti
	JSR print
	PTI R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- NTI ---
	LEA R27,str_nti
	JSR print
	NTI R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- SWP ---
	LEA R27,str_swp
	JSR print
	SWP R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- SWN ---
	LEA R27,str_swn
	JSR print
	SWN R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- ROU ---
	LEA R27,str_rou
	JSR print
	ROU R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- ROD ---
	LEA R27,str_rod
	JSR print
	ROD R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- SHU ---
	LEA R27,str_shu
	JSR print
	SHU R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- SHD ---
	LEA R27,str_shd
	JSR print
	SHD R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- CLU ---
	LEA R27,str_clu
	JSR print
	CLU R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- CLD ---
	LEA R27,str_cld
	JSR print
	CLD R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- EPTI ---
	LEA R27,str_epti
	JSR print
	EPTI R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- ENTI ---
	LEA R27,str_enti
	JSR print
	ENTI R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- DECOT ---
	LEA R27,str_decot
	JSR print
	DECOT R10,R1
	JSR print_integer_ternary
	JSR new_line

	;	--- DECOU ---
	LEA R27,str_decou
	JSR print
	DECOU R10,R1
	JSR print_integer_ternary
	JSR new_line


	;----------------------------------------------
	JSR new_line
	JSR new_line
	LEA R27,str_content
	JSR print

	ANYI R1,R0,#9464 ; +++000---
	ANYI R2,R0,#6056 ; +0-+0-+0-

	;view the start value
	ANYI R15,R0,#9
	ANY R10,R0,R1
	JSR print_integer_ternary
	JSR new_line
	ANYI R10,R0,#9	;TAB CHAR
	OUT 0(R7),R10
	OUT 0(R7),R10
	ANY R10,R0,R2
	JSR print_integer_ternary
	
	JSR new_line
	JSR new_line

	
	;	--- MIN ---
	LEA R27,str_min
	JSR print
	MIN R10,R1,R2
	JSR print_integer_ternary
	JSR new_line

	;	--- MAX ---
	LEA R27,str_max
	JSR print
	MAX R10,R1,R2
	JSR print_integer_ternary
	JSR new_line

	;	--- TXOR ---
	LEA R27,str_txor
	JSR print
	TXOR R10,R1,R2
	JSR print_integer_ternary
	JSR new_line

	;	--- SUM ---
	LEA R27,str_sum
	JSR print
	SUM R10,R1,R2
	JSR print_integer_ternary
	JSR new_line

	;	--- CONS ---
	LEA R27,str_cons
	JSR print
	CONS R10,R1,R2
	JSR print_integer_ternary
	JSR new_line

	;	--- EQUAL ---
	LEA R27,str_equal
	JSR print
	EQUAL R10,R1,R2
	JSR print_integer_ternary
	JSR new_line

	;	--- ANY ---
	LEA R27,str_any
	JSR print
	ANY R10,R1,R2
	JSR print_integer_ternary
	JSR new_line

	;	--- IMPL ---
	LEA R27,str_impl
	JSR print
	IMPL R10,R1,R2
	JSR print_integer_ternary
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

	



	.include COMMON/IO_fun.i

	

