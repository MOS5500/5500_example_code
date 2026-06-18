;Test for MULtiplication instruction
;Author Claudio "CP" La Rosa
;Public release: June 2026

.ORG 0
.INCLUDE serial.i
.DATA

	 str_mult			DC4.T "Multiplication (MUL) Test",0
	 str_mult_test_1		DC4.T "243*79 = ",0
	 str_mult_test_2		DC4.T "243*-79 = ",0
	 str_mult_test_3		DC4.T "-243*79 = ",0
	 str_mult_test_4		DC4.T "-243*-79 = ",0
	 str_mult_test_5		DC4.T "243*0 = ",0
	 str_mult_test_6		DC4.T "-243*0 = ",0
	 str_mult_test_7		DC4.T "0*79 = ",0
	 str_mult_test_8		DC4.T "0*-79 = ",0
	 str_mult_test_9		DC4.T "0*0 = ",0
	 str_newline		DC4.T " ",10,13,0
	

.CODE

	;----------------------
	;Initialize Stack
	ANYI R60,R0,#8000	;R60  stack address
	STSP R60			;Kernel Stack 
	;---------------------------------------
	;Set Serial Port (R36)
	 ANYI R36,R0,#SERIAL_PORT_2
	;--------------------------------------



	;--- Multiply hardware test
	LEA R27,str_mult
	JSR println

	;-----------------------
	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_1
	JSR print
	ANYI R53,R0,#243
	ANYI R54,R0,#79
	MUL R1,R2,R53,R54

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	;ANY R10,R0,R1
	;ANYI R15,R0,#24
	;JSR print_integer_ternary
	

	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_2
	JSR print
	ANYI R53,R0,#243
	ANYI R54,R0,#-79
	MUL R1,R2,R53,R54

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	
	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_3
	JSR print
	ANYI R53,R0,#-243
	ANYI R54,R0,#79
	MUL R1,R2,R53,R54

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	
	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_4
	JSR print
	ANYI R53,R0,#-243
	ANYI R54,R0,#-79
	MUL R1,R2,R53,R54

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	
	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_5
	JSR print
	ANYI R53,R0,#243
	MUL R1,R2,R53,R0

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_6
	JSR print
	ANYI R53,R0,#-243
	MUL R1,R2,R53,R0

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_7
	JSR print
	ANYI R54,R0,#79
	MUL R1,R2,R0,R54

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_8
	JSR print
	ANYI R54,R0,#-79
	MUL R1,R2,R0,R54

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	;-----------------------

	LEA R27,str_newline
	JSR println

	LEA R27,str_mult_test_9
	JSR print
	MUL R1,R2,R0,R0

	ANY R5,R0,R1	;R5 = R1
	JSR print_integer









	HLT
	

.INCLUDE COMMON/IO_fun.i
