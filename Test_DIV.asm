;Test_DIV.asm
;
; Simple test for DIV instruction
; Author: Claudio "CP" La Rosa
; Public releae: June 2026



.ORG 0
.INCLUDE serial.i
.DATA

	 str_div			DC4.T "DIVISION (DIV) Test",0
	 str_div_test_1		DC4.T "243/79 = ",0
	 str_div_test_2		DC4.T "243/-79 = ",0
	 str_div_test_3		DC4.T "-243/79 = ",0
	 str_div_test_4		DC4.T "-243/-79 = ",0
	 str_div_test_5		DC4.T "0/79 = ",0
	 str_div_test_6		DC4.T "0/-79 = ",0
	
	 str_div_test_7		DC4.T "4/17 = ",0
	 str_div_test_8		DC4.T "-4/17 = ",0
	 str_div_test_9		DC4.T "4/-17 = ",0
	 str_div_test_10	DC4.T "-4/-17 = ",0

	 str_div_test_11	DC4.T "235/235 = ",0
	 str_div_test_12	DC4.T "-235/235 = ",0
	 str_div_test_13	DC4.T "235/-235 = ",0
	 str_div_test_14	DC4.T "-235/-235 = ",0

	 str_div_test_15	DC4.T "265720/1 = ",0
	 str_div_test_16	DC4.T "265720/2 = ",0
	 str_div_test_17	DC4.T "265720/3 = ",0
	 str_div_test_18	DC4.T "265719/265720 = ",0

	 str_div_test_19	DC4.T "100/10 = ",0
	 str_div_test_20	DC4.T "81/27 = ",0

	 str_div_test_21	DC4.T "80/79 = ",0

	 str_div_test_22	DC4.T "-265720/3 = ",0
	 str_div_test_23	DC4.T "265720/-3 = ",0
	 str_div_test_24	DC4.T "max_pos_24/1 = ",0
	 str_div_test_25	DC4.T "min_neg_24/1 = ",0
	 str_div_test_26	DC4.T "max_pos_24/max_pos_24 = ",0
	 str_div_test_27	DC4.T "min_neg_24/min_neg_24 = ",0
	 



	 str_rem				DC4.T " Remainder = ",0

	 str_end			DC4.T 10,13," *** END TEST ***",10,13,0

	 str_newline		    DC4.T " ",10,13,0
	 

.CODE

	;Disable Interrupts
	DI


	;----------------------
	;Initialize Stack
	ANYI R60,R0,#8000	;R60  stack address
	STSP R60			;Kernel Stack 
	;---------------------------------------
	;Set Serial Port (R36)
	 ANYI R36,R0,#SERIAL_PORT_2
	;--------------------------------------


	;--- DIVISION hardware test
	LEA R27,str_div
	JSR println


	;----------------------- 243/79
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_1
	JSR print
	ANYI R54,R0,#243
	ANYI R53,R0,#79
	DIV R1,R2,R53,R54


	ANY R5,R0,R2	;R5 = R2
	JSR print_integer



	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	;----------------------- 243/-79
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_2
	JSR print
	ANYI R54,R0,#243
	ANYI R53,R0,#-79
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	;Original value
	;LEA R27,str_original
	;JSR print
	;ANY R5,R0,R54	;R5 = R54
	;JSR print_integer
	;ANY R5,R0,R53	;R5 = R53
	;JSR print_integer



	;----------------------- -243/79
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_3
	JSR print
	ANYI R54,R0,#-243
	ANYI R53,R0,#79
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


		;Original value
	;LEA R27,str_original
	;JSR print
	;ANY R5,R0,R54	;R5 = R54
	;JSR print_integer
	;ANY R5,R0,R53	;R5 = R53
	;JSR print_integer

	;----------------------- -243/-79
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_4
	JSR print
	ANYI R54,R0,#-243
	ANYI R53,R0,#-79
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer



	;----------------------- 0/79
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_5
	JSR print
	ANY R54,R0,R0
	ANYI R53,R0,#79
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


	;----------------------- 0/-79
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_6
	JSR print
	ANY R54,R0,R0
	ANYI R53,R0,#-79
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


	;----------------------- 4/17
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_7
	JSR print
	ANYI R54,R0,#4
	ANYI R53,R0,#17
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


    ;----------------------- -4/17
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_8
	JSR print
	ANYI R54,R0,#-4
	ANYI R53,R0,#17
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


	;----------------------- 4/-17
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_9
	JSR print
	ANYI R54,R0,#4
	ANYI R53,R0,#-17
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


	;----------------------- -4/-17
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_10
	JSR print
	ANYI R54,R0,#-4
	ANYI R53,R0,#-17
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


	;----------------------- 235/235
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_11
	JSR print
	ANYI R54,R0,#235
	ANYI R53,R0,#235
	
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	
	;----------------------- -235/235
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_12
	JSR print
	ANYI R54,R0,#-235
	ANYI R53,R0,#235
	
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	
	;----------------------- 235/-235
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_13
	JSR print
	ANYI R54,R0,#235
	ANYI R53,R0,#-235
	
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer


	;----------------------- -235/-235
	LEA R27,str_newline
	JSR println

	LEA R27,str_div_test_14
	JSR print
	ANYI R54,R0,#-235
	ANYI R53,R0,#-235
	
	DIV R1,R2,R53,R54

	ANY R5,R0,R2	;R5 = R2
	JSR print_integer

	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = R1
	JSR print_integer

	;----------------------- 265720/1
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_15
	JSR print
	ANYI R54,R0,#265720
	ANYI R53,R0,#1
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- 265720/2
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_16
	JSR print
	ANYI R54,R0,#265720
	ANYI R53,R0,#2
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- 265720/3
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_17
	JSR print
	ANYI R54,R0,#265720
	ANYI R53,R0,#3
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- 265719/265720
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_18
	JSR print
	ANYI R54,R0,#265719
	ANYI R53,R0,#265720
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- 100/10
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_19
	JSR print
	ANYI R54,R0,#100
	ANYI R53,R0,#10
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- 81/27
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_20
	JSR print
	ANYI R54,R0,#81
	ANYI R53,R0,#27
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- 80/79
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_21
	JSR print
	ANYI R54,R0,#80
	ANYI R53,R0,#79
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- -265720/3
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_22
	JSR print
	ANYI R54,R0,#-265720
	ANYI R53,R0,#3
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer

;----------------------- 265720/-3
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_23
	JSR print
	ANYI R54,R0,#265720
	ANYI R53,R0,#-3
	DIV R1,R2,R53,R54
	ANY R5,R0,R2	;R5 = quoziente
	JSR print_integer
	;print remainder
	LEA R27,str_rem
	JSR print
	ANY R5,R0,R1	;R5 = resto
	JSR print_integer


	;----------------------- max_pos_24/1
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_24
	JSR print
	ANYI R45,R0,#265720         ; R45 = +max_pos_12 (trit 11..0 = +1)
    ROTI R45,R45,#-12           ; R45 = trit 23..12 = +1, trit 11..0 = 0
    ANYI R45,R45,#265720        ; R45 = max_pos_24 (tutti i trit a +1)
    ANYI R46,R0,#1              ; R46 = 1
    DIV  R6,R5,R46,R45         ; R5 = R45 / R46 = max_pos_24 / 1
    JSR  print_integer            ; stampa quoziente (atteso: max_pos_24)
    LEA R27,str_rem
	JSR print
    ANY R5,R0,R6               ; R5 = R6 (resto), atteso 0
    JSR  print_integer

	;----------------------- min_neg_24/1
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_25
	JSR print
	ANYI R45,R0,#-265720        ; R45 = -min_neg_12 (trit 11..0 = -1)
    ROTI R45,R45,#-12           ; R45 = trit 23..12 = -1, trit 11..0 = 0
    ANYI R45,R45,#-265720        ; R45 = min_neg_24 (tutti i trit a -1)
    ANYI R46,R0,#1              ; R46 = 1
    DIV  R6,R5,R46,R45         ; R5 = R45 / R46 = min_neg_24 / 1
    JSR  print_integer            ; stampa quoziente (atteso: min_neg_24)
    LEA R27,str_rem
	JSR print
    ANY R5,R0,R6               ; R5 = R6 (resto), atteso 0
    JSR  print_integer


	;------------------ max_pos_24/max_pos_24
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_26
	JSR print
	ANYI R45, 	R0,  #265720
    ROTI R45,R45,#-12
    ANYI R45,R45,#265720        ; R45 = max_pos_24
    ANY R46,R0,R45              ; R46 = max_pos_24
    DIV  R6,R5,R46,R45         ; R5 = max_pos_24 / max_pos_24
    JSR  print_integer            ; atteso: 1
    LEA R27,str_rem
	JSR print
	ANY R5,R0,R6
    JSR  print_integer            ; atteso: 0


	;------------------ min_neg_24/min_neg_24
	LEA R27,str_newline
	JSR println
	LEA R27,str_div_test_27
	JSR print
	ANYI R45,R0,#-265720
    ROTI R45,R45,#12
    ANYI R45,R45,#-265720        ; R45 = min_neg_24
    ANY R46,R0,R45              ; R46 = min_neg_24
    DIV  R6,R5,R46,R45         ; R5 = min_neg_24 / min_neg_24
    JSR  print_integer           
    LEA R27,str_rem
	JSR print
	ANY R5,R0,R6
    JSR  print_integer            ; atteso: 0
	
	
	LEA R27,str_end
	JSR println
	
	HLT
	

	


	.INCLUDE LEVITAS/IO_fun.i