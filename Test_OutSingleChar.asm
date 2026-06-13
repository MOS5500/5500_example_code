;OutSingleChar.asm
;June 2025
;
;Author: Claudio "CP" La Rosa
;
; Simple test for serial port output
; This program send in the serial port 2 (Graganturam 1.3 and 1.4)
; two single char: 'A' and 'B'
; 

.ORG 0

.INCLUDE serial.i

.DATA

	
.CODE

	
	;--------------------------------------
	
	 ;Set Serial Port (R7)
	 ANYI R7,R0,#SERIAL_PORT_2
	;---------------------------------------


	ANYI R22,R0,#65 ;'A'
	OUT 0(R7),R22

	ADDI R22,R22,#1
	OUT 0(R7),R22	;'B'


	;Stop
	HLT
	;INT #3