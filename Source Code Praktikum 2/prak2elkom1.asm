; Program Menghitung Luas Persegi Panjang
; Dengan dua input variabel bebas untuk panjang dan lebar yang bisa bernilai (+) atau (-)
; Output luas sebagai variabel yang terikat

INCLUDE 'emu8086.inc'
#MAKE_COM#
ORG 100H
JMP MULAI
PSN1	DB "Hitung Luas Persegi Panjang Dengan Input Variabel Panjang dan Lebar",13,10
	DB "Output Luas Hasil Kali Variabel Alas Dengan Tinggi",13,10,13,10,'$'
PSN2	DB "Input Nilai Panjang Persegi Panjang: $"
PSN3	DB "Input Nilai Lebar Persegi Panjang: $"
PSN4	DB "Luas Persegi Panjang adalah: $"
PSN5	DB 13,10,13,10,"Terima Kasih Telah Menggunakan Program Ini! Agfan Herru Pratama - 064002100043"
	DB 13,10,13,10,"Tekan Sembarang Untuk Keluar. $"
PANJANG	DW ?
LEBAR	DW ?
ARE	DW ?
MULAI:
LEA DX,PSN1
MOV AH,9
INT 21H

LEA DX,PSN2
MOV AH,9
INT 21H

CALL SCAN_NUM

MOV PANJANG,CX

PUTC 13
PUTC 10

LEA DX,PSN3
MOV AH,9
INT 21H

CALL SCAN_NUM

MOV LEBAR,CX

MOV AX,LEBAR
MOV BX,PANJANG
IMUL BX
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
