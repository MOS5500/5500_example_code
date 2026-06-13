; This program prints the first 55 Fibonacci numbers on serial port 2
; Author: Claudio "CP" La Rosa
; Public version 1.0 - June 2026


.ORG 0
.INCLUDE serial.i
.DATA
	 str_hd			DC.T "====== Fibonacci sequence test ======",0
	 	
		

.CODE

	;----------------------
	;Initialize Stack
	ANYI R60,R0,#8000	;R60  stack address
	STSP R60			;Kernel Stack 
	;---------------------------------------
	;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2
	;--------------------------------------

	JSR new_line
	LEA R27,str_hd
	JSR println

	;main loop
	ANYI R20,R0,#0		;R20 = loop counter		
	ANYI R21,R0,#56		;R21 = max loop iterations
	
	main_loop:
		;Print the iteration ID
		ANY R5,R0,R20
    	JSR print_integer

		;Print a tab
		ANYI R6,R0,#9	;TAB
		OUT 0(R7),R6

		;Now calculate the Fibonacci number
		JSR calculate_fibo

		;Print the Fibonacci number
		;in R3 I have the Fibonacci number
		ANY R5,R0,R3
		JSR print_integer
	
		JSR new_line



	INC R20
	JBE R21,R20,main_loop
	
	HLT




	
	
	
	;------------------------------------
	; CALCULATE FIBONACCI NUMBER
	; input:	R20  iteration number
	; output:	R3   Fibonacci number
	;------------------------------------
	calculate_fibo:
	;PROLOGUE
	PUSH R1
	PUSH R2
	PUSH R15
	;Insert return value on the stack
	PUSH R26

	ANY R1,R0,R0	;R1 = 0
	ANYI R2,R0,#1	;R2 = 1
	ANY R3,R0,R0	;R3 = 0

	JEQ R20,R0,exit_calculate_fibo	;if n == 0 return 0
	INC R3	;R3						;R3 = 1
	JEQ R20,R2,exit_calculate_fibo	;if n == 1 return 1



	;internal loop
	ANYI R15,R0,#2		
	internal_loop:

		;Update values
	
		ADD R3,R2,R1	;R3 = R1 + R2

		ANY R1,R0,R2	;R1 = R2
		ANY R2,R0,R3	;R2 = R3

		

    INC R15
	JBE R20,R15,internal_loop

	;Return value in R3

	exit_calculate_fibo:
	

	;EPILOGUE
	POP.W R26
	POP.W R15
	POP.W R2
	POP.W R1
	
	JR R26
	;-------------------------- END calculate_fibo



	.INCLUDE COMMON/IO_fun.i
	

	
	
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
