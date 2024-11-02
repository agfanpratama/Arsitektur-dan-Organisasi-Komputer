; Program Menghitung Bilangan Pangkat 3
; Dengan Satu Input Value < 30
; Output Sebagai Hasil Akhir

INCLUDE 'emu8086.inc'
#MAKE_COM#
ORG 100H
JMP MULAI
PSN1    DB "Menghitung Bilangan Pangkat Tiga",13,10
        DB " ",13,10,13,10,'$'
PSN2    DB "Input Nilai: $"
PSN3    DB " "
PSN4    DB "HASIL: $"
PSN5    DB 13,10,13,10,"Terima Kasih Telah Menggunakan Program Ini, -Agfan Herru Pratama_064002100043"
        DB 13,10,13,10,"Tekan Sembarang Untuk Keluar $"
ANGKA   DW ?
ARE     DW ?

MULAI:
LEA DX,PSN1
MOV AH,9
INT 21H

LEA DX,PSN2
MOV AH,9
INT 21H

CALL SCAN_NUM

MOV ANGKA,CX

PUTC 13
PUTC 10

MOV AX,ANGKA
IMUL AX
IMUL AX
DIV ANGKA
PUSH AX

PUTC 13
PUTC 10
LEA DX,PSN4
MOV AH,9
INT 21H

POP AX     
MOV ARE, AX

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
