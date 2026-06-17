
;Test for load data from memory
;Author Claudio "CP" La Rosa
;Public release: June 2026

.ORG 0
.INCLUDE serial.i

.DATA
	
	str_head DC4.T " == Test for Data Size Transfer Instructions ==",0
	str_mem   DC4.T "Memory value             : ",0
	str_reg   DC4.T "Register value           : ",0
	str_sizet DC4.T "Register after load TRYTE: ",0
	str_sizes DC4.T "Register after load SHORT: ",0
	str_sizew DC4.T "Register after load WORD : ",0

	str_trypp DC4.T "*******   Try with Stack functions (no registers)   *******",0
    str_sp    DC4.T "Value of stack pointer: ",0

	str_tryppr DC4.T "*******   Try with Stack functions with explicit register   *******",0


	


		

.CODE
	
	;Disable all interrupts
	DI
	
    ;----------------------
	;Initialize Stack
	ANYI R60,R0,#8000	;R60 indirizzo stack
	STSP R60
	;---------------------------------------


	ANYI R7,R0,#SERIAL_PORT_2


	LEA R27,str_head
	JSR println

		

	;--- Fill memory ---
	ANYI R20,R0,#-265720
	ASHI R20,R20,#-12
	ANYI R20,R20,#-265720

	ANYI R22,R0,#19000	;memory location
	ST 0(R22),R20	    ;store in memory at (R22)
	
	;view the value
	LEA R27,str_mem
	JSR print

	
	ANYI R15,R0,#24
	;ANY R10,R0,R20
	LD R10,0(R22)
	JSR print_integer_ternary
    JSR new_line



	;--- Fill a register --------------
	ANYI R8,R0,#210240  ; ++--00++--00
	ASHI R8,R8,#-12
	ANYI R8,R8,#210240  ; ++--00++--00

	LEA R27,str_reg
	JSR print
	ANYI R15,R0,#24
	ANY R10,R0,R8
	JSR print_integer_ternary
    JSR new_line

	;---- Load from memory TRYTE
	LEA R27,str_sizet
	JSR print

	ANY R9,R0,R8	; in R9 the register value

	LD.T R9,0(R22)	    ;Load from memory at (R22)
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line


	;---- Load from memory SHORT
	LEA R27,str_sizes
	JSR print

	ANY R9,R0,R8	; in R9 the register value

	LD.S R9,0(R22)	    ;Load from memory at (R22)
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line

	;---- Load from memory WORD
	LEA R27,str_sizew
	JSR print
	
	ANY R9,R0,R8	; in R9 the register value

	LD.W R9,0(R22)	    ;Load from memory at (R22)
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line

	; ********************************************************
	; **************** Try with PUSH/POP *********************
	; ********************************************************
		
	LEA R27,str_trypp
	JSR println

	;--- Fill memory ---
	ANYI R1,R0,#-265720
	ASHI R1,R1,#-12
	ANYI R1,R1,#-265720
	PUSH R1
	
	;view the value
	LEA R27,str_mem
	JSR print

	ANYI R15,R0,#24
	ANY R10,R0,R1
	JSR print_integer_ternary
    JSR new_line

	

	;--- Fill a register --------------
	ANYI R8,R0,#210240 ;
	ASHI R8,R8,#-12
	ANYI R8,R8,#210240  ;

	LEA R27,str_reg
	JSR print
	ANYI R15,R0,#24
	ANY R10,R0,R8
	JSR print_integer_ternary
    JSR new_line

	;---- Load from memory TRYTE
	LEA R27,str_sizet
	JSR print

	ANY R9,R0,R8	; in R9 the register value

	POP.T R9		;Load from stack
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line


	;---- Load from memory SHORT
	PUSH R1
	LEA R27,str_sizes
	JSR print

	ANY R9,R0,R8	; in R9 the register value
	
	POP.S R9
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line

	;---- Load from memory WORD
	PUSH R1
	LEA R27,str_sizew
	JSR print
	
	ANY R9,R0,R8	; in R9 the register value

	POP.W R9
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line

	; ********************************************************
	; **************** Try with PUSH/POPR *********************
	; ********************************************************
	
	ANYI R60,R0,#9800 ; new stack base

	LEA R27,str_tryppr
	JSR println

	;--- Fill memory ---
	ANYI R1,R0,#265720
	ASHI R1,R1,#-12
	ANYI R1,R1,#265720
	PUSHR (R60),R1
	
	;view the value
	LEA R27,str_mem
	JSR print

	ANYI R15,R0,#24
	ANY R10,R0,R1
	JSR print_integer_ternary
    JSR new_line

	

	;--- Fill a register --------------
	LEA R27,str_reg
	JSR print
	ANYI R15,R0,#24
	ANY R10,R0,R8
	JSR print_integer_ternary
    JSR new_line

	;---- Load from memory TRYTE
	LEA R27,str_sizet
	JSR print

	ANY R9,R0,R8	; in R9 the register value

	POPR.T R9,(R60)		;Load from stack
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line


	;---- Load from memory SHORT
	PUSHR (R60),R1
	LEA R27,str_sizes
	JSR print

	ANY R9,R0,R8	; in R9 the register value
	
	POPR.S R9,(R60)
	ANY R10,R0,R9
	JSR print_integer_ternary
    JSR new_line

	;---- Load from memory WORD
	PUSHR (R60),R1
	LEA R27,str_sizew
	JSR print
	
	ANY R9,R0,R8	; in R9 the register value

	POPR.W R9,(R60)
	ANY R10,R0,R9
	JSR print_integer_ternary
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
	POP R26
	POP R4
	
	JR R26

	;------------------------------ END new_line

	.INCLUDE LEVITAS/IO_fun.i


 





	
	

	