; Program menghitung luas segitiga
; Input variabel bebas alas dan tinggi bernilai positif
; Output luas sebagai variabel terikat

INCLUDE 'emu8086.inc'
#MAKE_COM#
ORG 100H
JMP START
PSN1    DB "Menghitung Luas Segitiga Dengan Input Variabel Alas dan Tinggi",13,10
        DB "Output Luas Hasil Kali Variabel Alas Dengan Tinggi Dibagi 2",13,10,13,10,'$'
PSN2    DB "Input Nilai Alas Segitiga: $"
PSN3    DB "Input Nilai Tinggi Segitiga: $"
PSN4    DB "Luas Segitiga Tersebut Adalah: $"
PSN5    DB 13,10,13,10,"Thank You!"
        DB 13,10,13,01,"Tekan Enter $"
ALAS    DW ?
TINGGI  DW ?
BG      DW 2
ARE     DW ?
START:
LEA DX,PSN1
MOV AH,9
INT 21H
LEA DX,PSN2
MOV AH,9
INT 21H

CALL SCAN_NUM

MOV ALAS,CX

PUTC 13
PUTC 10

LEA DX,PSN3
MOV AH,9
INT 21H

CALL SCAN_NUM

MOV TINGGI,CX

MOV AX,ALAS
MOV BX,TINGGI
IMUL BX
DIV BG
PUSH AX

PUTC 13
PUTC 10

LEA DX,PSN4
MOV AH,9
INT 21H

POP AX
MOV ARE,AX

CALL PRINT_NUM

PUTC 13
PUTC 10

LEA DX,PSN5
MOV AH,9
INT 21H

MOV AH,0
INT 16H

RET

DEFINE_SCAN_NUM
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
END
