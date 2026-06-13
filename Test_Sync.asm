; This program tests atomic synchronization instructions 
; 
; Author: Claudio "CP" La Rosa
; Public version 1.0 - June 2026


.ORG 0
.INCLUDE serial.i

.DATA

MyMem DC.T "q",0


	str_prova DC4.T " == Test atomic synchronization instructions ==",0

	str_original  DC4.T "Original value read from memory: ",0
	str_new_1     DC4.T "new value read from memory: ",0
	str_new_2     DC4.T "last value read from memory: ",0
	str_new_3     DC4.T "Value from memory before FADD IMMEDIATE: ",0
	str_ok_cas	  DC4.T "CAS completed successfully!",0
	str_no_cas	  DC4.T "CAS Failed...",0
	str_final	  DC4.T "New value after CAS: ",0
		

.CODE
	
	;Disable all interrupts
	DI

    ;----------------------
	;Initialize Stack
	ANYI R60,R0,#8000	;R60 indirizzo stack
	STSP R60
	;---------------------------------------

	ANYI R60,R0,#2348
	STITBR R60


	ANYI R36,R0,#SERIAL_PORT_2


	LEA R27,str_prova
	JSR println

	;ANYI R8,R0,#4538
	;ANY R5,R0,R8
	;JSR print_integer		;should be old value (4538)


	;LEA  R10,MyMem
	ANYI R10,R0,#10000	; address in memory

	
	ANYI R6,R0,#65	;'A'
	ST 0(R10),R6


	LEA R27,str_original
	JSR println
	;----------- FAA (Fetch and Add) ---------------
	ANYI R4,R0,#10
	FAA (R10),R5,R4
	JSR print_integer		;65 ('q')
	ANYI r4,r0,#10	;<LF>
	OUT SERIAL_PORT_2(r0),r4
	ANYI r4,r0,#13	;<CR>
	OUT SERIAL_PORT_2(r0),r4 



	
	LEA R27,str_new_1
	JSR println
	ANYI R6,R0,#2
	FAA (R10),R5,R6
	JSR print_integer		;75
	ANYI r4,r0,#10	;<LF>
	OUT SERIAL_PORT_2(r0),r4
	ANYI r4,r0,#13	;<CR>
	OUT SERIAL_PORT_2(r0),r4 



	LEA R27,str_new_2
	JSR println
	FAA (R10),R5,R6
	JSR print_integer		;77 
	ANYI r4,r0,#10	;<LF>
	OUT SERIAL_PORT_2(r0),r4
	ANYI r4,r0,#13	;<CR>
	OUT SERIAL_PORT_2(r0),r4 


	LEA R27,str_new_3
	JSR println
	FAAI (R10),R5,#-23
	JSR print_integer		;79 
	ANYI r4,r0,#10	;<LF>
	OUT SERIAL_PORT_2(r0),r4
	ANYI r4,r0,#13	;<CR>
	OUT SERIAL_PORT_2(r0),r4 





	;now load directly from memory
	LD R5,0(R10)
	JSR print_integer		;56 = 79-23



	; ---------- Compare And Swap
	ANYI R1,R0,#56	;Value for compare with memory
	ANY  R2,R0,R1	;Same value for check CAS successful

	ANYI R6,R0,#34	;new value

	CAS (R10),R1,R6
	JEQ R1,R2,ok_cas

	;----if here, CAS unsucessful
	LEA R27,str_no_cas
	JSR println
	JMP exit
	
	ok_cas:
	LEA R27,str_ok_cas
	JSR println
	; ----------------- CAS end --------------------

	
	exit:
	LEA R27,str_final
	JSR print
	LD R5,0(R10)
	JSR print_integer	






	ANYI r4,r0,#10	;<LF>
	OUT SERIAL_PORT_2(r0),r4
	ANYI r4,r0,#13	;<CR>
	OUT SERIAL_PORT_2(r0),r4 

	HLT



   
   
	.include LEVITAS/IO_fun.i

