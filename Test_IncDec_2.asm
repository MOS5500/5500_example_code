; This program tests the INC and DEC instructions, including overflow and saturation behavior. 
; It also tests the ADD and SUB instructions with and without saturation.
; 
; Author: Claudio "CP" La Rosa
; Public version 1.0 - June 2026


.ORG 0
.INCLUDE serial.i
.DATA
	 str_hd		DC4.T "Increment and Decrement Test",0
	 str_ptw	DC4.T "Now increment twice ",0
	 str_dc		DC4.T "now Decrement ",0


	 str_starting			DC4.T "Starting value: ",0
	 str_inc_overflow		DC4.T "Increment with overflow:",0
	 str_inc_sat			DC4.T "Increment with saturation:",0
	 str_dec_underflow		DC4.T "Decrement with underflow:",0
	 str_dec_sat			DC4.T "Decrement with saturation:",0
	 str_add_normal			DC4.T "Increment with Augmentation",0	
	 str_add_sat			DC4.T "Increment with Augmentation with saturation",0	

	 str_end				DC4.T "----- END TEST -----",0

	

.CODE

     DI
	;----------------------
	;Initialize Stack
	ANYI R60,R0,#8000	;R60  stack address
	STSP R60			;Kernel Stack 
	;---------------------------------------
	;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2
	;--------------------------------------

	LEA R27,str_hd
	JSR println

	
	ANYI R3,R0,#3
	ANYI R4,R0,#14

	ANY R5,R0,R4	
	JSR print_integer
	
	
	
	JSR new_line

	LEA R27,str_ptw
	JSR println

	INC R5
	INC R5
	JSR print_integer
	JSR new_line

	LEA R27,str_dc
	JSR println
	DEC R5
	JSR print_integer
	JSR new_line


	ANYI R15,R0,#24	;for print_integer_ternary

	;now fill the register with highest value...
	ANYI R5,R0,#265720
	ASHI R5,R5,#-12
	ANYI R5,R5,#265720

	
	LEA R27,str_starting
	JSR println				;print starting value
	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line

	INC R5
	LEA R27,str_inc_overflow
	JSR println				;print Increment with overflow
	;now R5 is in Overflow!
	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line

	JSR new_line
	;//ok now I use the Saturation INC
	;Fill the register with highest value...
	ANYI R5,R0,#265720
	ASHI R5,R5,#-12
	ANYI R5,R5,#265720

	LEA R27,str_starting
	JSR println				;print starting value
	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line

	INCS R5
	LEA R27,str_inc_sat
	JSR println				;print Inc saturation
	;now R5 is in Overflow but...with saturation check!
	ANY R10,R0,R5
	JSR print_integer_ternary

	JSR new_line
	JSR new_line

	;------------------ UNDERFLOW
	;now fill the register with highest value...
	ANYI R5,R0,#-265720
	ASHI R5,R5,#-12
	ANYI R5,R5,#-265720

	LEA R27,str_starting
	JSR println				;print starting value
	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line


	LEA R27,str_dec_underflow
	JSR println				
	DEC R5
	;now R5 is in underflow!
	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line

	JSR new_line
	;//ok now I use the Saturation INC
	;Fill the register with highest value...
	ANYI R5,R0,#-265720
	ASHI R5,R5,#-12
	ANYI R5,R5,#-265720

	LEA R27,str_starting
	JSR println				;print starting value
	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line

	LEA R27,str_dec_sat
	JSR println				
	DECS R5
	;now R5 is in Overflow but...with saturation check!
	ANY R10,R0,R5
	JSR print_integer_ternary

	JSR new_line
	JSR new_line

	; ---------------------------------------       ADD and SUB
	LEA R27,str_starting
	JSR println				;print starting value

	;Fill the register 
	ANYI R5,R0,#265720
	ASHI R5,R5,#-12
	ANYI R5,R5,#265715

	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line

	LEA R27,str_add_normal
	JSR println				
	ADDI R5,R5,#6
	;now R5 is in Overflow
	ANY R10,R0,R5
	JSR print_integer_ternary

	JSR new_line
	JSR new_line


	LEA R27,str_starting
	JSR println				;print starting value

	;Fill the register 
	ANYI R5,R0,#265720
	ASHI R5,R5,#-12
	ANYI R5,R5,#265715

	ANY R10,R0,R5
	JSR print_integer_ternary
	JSR new_line

	LEA R27,str_add_sat
	JSR println				
	ADDSI R5,R5,#6
	;now R5 is in Overflow
	ANY R10,R0,R5
	JSR print_integer_ternary

	JSR new_line
	JSR new_line



	LEA R27,str_end
	JSR println		



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

	.INCLUDE LEVITAS/IO_fun.i