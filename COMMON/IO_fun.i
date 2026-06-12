;======================= I/O PROCEDURES =======================


     ; ---   PRINT 1.3 ------------------------------------
	; Print string on serial port
	; Each character is packed in 6 trits
	; load an "packaging" string (4 char in one word)
	; and in memory test for 0 (end of string) any chars
	; input:	R27 Address of first character of the string
	;			R36 Serial Port
	;------------------------------------------------------
	print:
	PUSH.W R3
	PUSH.W R2
	PUSH.W R9
	PUSH.W R22
	;Insert return value on the stack
	PUSH.W R26

	ANYI R22,R0,#364	; MASK ++++++
		
	loop_print:
	LD.W R2,0(R27)	

	MSKP R9,R22,R2
	JEQ R9,R0,exit_print
	OUT 0(R36),R9

	ROTI R2,R2,#6
	MSKP R9,R22,R2
	JEQ R9,R0,exit_print
	OUT 0(R36),R9

	ROTI R2,R2,#6
	MSKP R9,R22,R2
	JEQ R9,R0,exit_print
	OUT 0(R36),R9

	ROTI R2,R2,#6
	MSKP R9,R22,R2
	JEQ R9,R0,exit_print
	OUT 0(R36),R9

	;next word
	ADDI R27,R27,#4
	JMP loop_print

	exit_print:
	POP.W R26
	POP.W R22
	POP.W R9
	POP.W R2
	POP.W R3
	JR R26	;rts


	; ---   PRINTLN  1.2 ----------------------------------
	; input:	R27 Address of first character of the string
	;			R36 Serial Port
	;---------------------------------------------------
	println:
	;save registers on stack
	PUSH R47
	PUSH R26

	JSR print	

	ANYI R47,R0,#10	;<LF>
	OUT 0(R36),R47
	ANYI R47,r0,#13	;<CR>
	OUT 0(R36),R47 

	POP R26
	POP R47
	JR R26	;rts


	;-------------------
	; PRINT INTEGER TERNARY
	; input:	R10 24 trit Integer
	;			R15 numbers of trit to view
	;			R36  Serial Port
	;-------------------
	
	print_integer_ternary:
	;PROLOGUE
	PUSH R10
	PUSH R11
	PUSH R12
	PUSH R14
	PUSH R15
	;Insert return value on the stack
	PUSH R26

	ANYI R14,R0,#1	;R14 = loop counter

	ANYI R11,R0,#1	; Positive Mask

	pit_loop:
	MSKP R12,R11,R10
	JEQI R12,#1,pit_sign_plus
	JEQI R12,#-1,pit_sign_minus
	ANYI R12,R0,#48	;'0'
	JMP pit_exit
	pit_sign_plus:
	ANYI R12,R0,#43	;'+'
	JMP pit_exit
	pit_sign_minus:
	ANYI R12,R0,#45	;'-'
		
	pit_exit:

	PUSH R12

	ASHI R10,R10,#1

	ADDI R14,R14,#1
	JBE R15,R14,pit_loop

	;view from stack
	ANYI R14,R0,#1	;R14 = loop counter
	pit_l_stack:
	POP R12
	OUT SERIAL_PORT_2(r0),R12
	ADDI R14,R14,#1
	JBE R15,R14,pit_l_stack

	;EPILOGUE
	POP.W R26
	POP.W R15
	POP.W R14
	POP.W R12
	POP.W R11
	POP.W R10
	
	JR R26
	;-------------------------- END print_integer_ternary



	;-------------------
	; PRINT INTEGER 1.2 (no divide procedure but DIV instruction)
	; input:	R5 24 trit Integer
	;			R36 Serial Port
	;-------------------
	
	print_integer:
	;PROLOGUE
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R10
	PUSH R11
	PUSH R12
	;Insert return value on the stack
	PUSH R26


	ANYI R3,R0,#0 ; Set as positive number
	JBE R5,R0,print_integer_start
	ANYI R3,R0,#1 ; Is a negative number
	STI R5,R5



	print_integer_start:
	ANYI R4,R0,#0		;contatore cifre

	print_integer_loop:
	ANY R10,R0,R5
	ANYI R11,R0,#10	;divisore
	DIV  R10,R12,R11,R10

	
	ADDI R10,R10,#48	;aggiungo 48 al resto
	PUSH.W R10

	ADDI R4,R4,#1	;contatore cifre
	ANY R5,R0,R12
	JB R12,R0,print_integer_loop

	;is a positive number?
	JEQ R3,R0,view_cifra
	;is is a negative number, I write '-'
	ANYI R6,R0,#45	; '-' char
	OUT 0(R36),R6

	view_cifra:
	POP.W R6
	OUT 0(R36),R6


	ADDI R4,R4,#-1
	JB R4,R0,view_cifra
	
	;EPILOGUE
	POP.W R26
	POP.W R12
	POP.W R11
	POP.W R10
	POP.W R6
	POP.W R5
	POP.W R4
	POP.W R3

	JR R26
	;---------- END PRINT INTEGER
	;======================================================================================
