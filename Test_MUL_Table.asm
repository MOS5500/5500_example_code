; This program prints the multiplication table from 1 to 9 on the serial port 2
; Author: Claudio "CP" La Rosa
; Public version 1.0 - June 2026

ORG 0
.INCLUDE serial.i
.DATA


.CODE

	
	;----------------------
	;Initialize Stack
	ANYI R60,R0,#8000	;R60  stack address
	STSP R60			;Kernel Stack 
	;---------------------------------------
	;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2
	;--------------------------------------

			
	ANYI R6,R0,#9	;TAB

	ANYI R1,R0,#1
	loop_1:

		;internal loop
		ANYI R2,R0,#1
		internal_loop:

			MUL R10,R11,R1,R2

			;view number
			ANY R5,R0,R10
			JSR print_integer

			;View a tab
			OUT SERIAL_PORT_2(r0),r6


		INC R2
		JBEI R2,#10,internal_loop

		
		;new line
		ANYI R8,R0,#10	;<LF>
		OUT SERIAL_PORT_2(r0),R8
		ANYI R8,R0,#13	;<CR>
		OUT SERIAL_PORT_2(r0),R8 


	ADDI R1,R1,#1
	JBEI R1,#10,loop_1

	;new line
	ANYI R8,R0,#10	;<LF>
	OUT SERIAL_PORT_2(r0),R8
	ANYI R8,R0,#13	;<CR>
	OUT SERIAL_PORT_2(r0),R8 


	HLT


	.INCLUDE LEVITAS/IO_fun.i
  
