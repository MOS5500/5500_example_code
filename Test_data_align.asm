;Test for data alignment in memory 
;Author Claudio "CP" La Rosa
;Public release: June 2026



.ORG 0

.INCLUDE serial.i
.INCLUDE SDCard.i

.DATA
	
	str_hello			DC4.T "Hello!",0
	str_word			DC4.T "Word value:",0
	data_1				DC4.W 9123456
	str_short			DC4.T "Short value:",0

	data_2				DC4.S 265021
	data_3 				DC.S 123031		;!! Not Aligned to 4!

	data_4 				DC.T -360 		;!! Not Aligned to 4! (new memory word)
	data_5 				DC4.S -85745	; on SD, thist MUST be aligned to 4!!
	data_6 				DC4.T 69		;also this MUST be aligned to 4 on SDCard!!

	str_tst				DC4.T "Trit/Short/Trit value:",0
	


.CODE

	
	 ;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2
	;---------------------------------------


	;-------- Stack initializing ----------
	 ANYI R60,R0,#8000	;R60 Stack address
	 STSP R60			;Kernel Stack 
	;--------------------------------------


	
	;load and view string
	LEA R27,str_hello
	JSR println
	JSR new_line

	;load and view word integer
	LEA R27,str_word
	JSR println
	ANYI R15,R0,#24
	LEA R27,data_1
	LD.W R10,0(R27)
	JSR print_integer_ternary
	JSR new_line

	ANY R5,R0,R10
	JSR print_integer
	JSR new_line
	JSR new_line


	;-----------SHORT VALUE----------------
	LEA R27,str_short
	JSR println
	LEA R27,data_2
	LD.S R10,0(R27)
	JSR print_integer_ternary
	JSR new_line
	ANY R5,R0,R10
	JSR print_integer
	JSR new_line
	;New short value
	LEA R27,data_3
	LD.S R10,0(R27)
	JSR print_integer_ternary
	JSR new_line
	ANY R5,R0,R10
	JSR print_integer
	JSR new_line

	;-----------Trit/Short/Trit VALUE----------------
	LEA R27,str_tst
	JSR println

	LEA R27,data_4
	LD.T R10,0(R27)
	JSR print_integer_ternary
	JSR new_line
	ANY R5,R0,R10
	JSR print_integer
	JSR new_line
	;New short value
	LEA R27,data_5
	LD.S R10,0(R27)
	JSR print_integer_ternary
	JSR new_line
	ANY R5,R0,R10
	JSR print_integer
	JSR new_line
	;New trit value
	LEA R27,data_6
	LD.T R10,0(R27)
	JSR print_integer_ternary
	JSR new_line
	ANY R5,R0,R10
	JSR print_integer
	JSR new_line


	HLT 
	


	

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


	
	.include COMMON/IO_fun.i
