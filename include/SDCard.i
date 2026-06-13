;
;	$Filename: SDCard.i $
;	$Release: 1.0 Includes $
;	$Revision: 1.0 $
;	$VER: SDCard.i 1.0 (30.01.2025)
;	$Date: 30.01.2025 $
;
;	Constant definitions for base address 
;	and command of SD Card reader in August Rain board
;	Garganturam1.3 - 1.4
;
;	(C) Copyright 2025 Claudio "CP" La Rosa
;	    All Rights Reserved
;



SDC_CMD_READ		EQU 1	;Command READ
SDC_CMD_WRITE		EQU 2	;Command WRITE


SDC0_SECTOR_ADDRESS	EQU 80	;Register for insert Sector Address of SDCard 0 read	
SDC0_OFFSET_ADDRESS	EQU 81	;Register for insert Offset from base sector of SDCard 0 read	
SDC0_COMMAND		EQU	82	;Command register
SDC0_WORD_WRITE		EQU	83	;Register for word write to SDCard 0
SDC0_WORD_READ		EQU	84	;Register for word read from SDCard 0	
