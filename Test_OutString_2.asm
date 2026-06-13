;OutString_2.asm
;
; Author: Claudio "CP" La Rosa
;
; Simple test for string serial port output
; This program send in the serial port 2 (Graganturam 1.3 - 1.4 - 1.5)
; two strings
;The version use the "packaging" strings: 4 char in one word.
; 

.ORG 0

.INCLUDE serial.i


.DATA
	str_1 DC4.T 10,13,"Hello ",0
	str_2 DC4.T  "World!",0
	str_3 DC4.T 10,13,"This is test of new packaging strings!",0
.CODE


	;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2



	LEA R27,str_1	;address of string in R3
	JSR print
	LEA R27,str_2	;address of string in R3
	JSR print
	LEA R27,str_3	;address of string in R3
	JSR print
	HLT ;Fermo esecuzione programma
	;INT #40
	
	
	
	.INCLUDE LEVITAS/IO_fun.i





