INCLUDE 'emu8086.inc'   ;MENCAKUP PROSEDUR DAN MAKRO emu8086.inc
#MAKE_COM#              ;MEMBUAT BERKAS COM
ORG 100H                ;MULAI DARI 100H
JMP MULAI               ;MELOMPAT MENUJU MULAI
;VARIABEL
PSN1    DB "MENGKONVERSI NILAI TEMPERATUR",13,10
        DB "DARI SKALA CELSIUS MENJADI FAHRENHEIT, KELVIN, DAN RHEAMUR",13,10
        DB "NILAI JANGKAUAN INPUT CELSIUS ANTARA -18204 SAMPAI 18186",13,10
        DB "BILA NILAI INPUT DI LUAR ITU PROGRAM AKAN CRASH",13,10
        DB "HASIL KONVERSI MERUPAKAN PEMBULATAN INTEGER",13,10,'$'
PSN2    DB 13,10,13,10,'MASUKKAN NILAI SKALA DERAJAT CELSIUS: $'
PSN3    DB "NILAI DALAM SKALA DERAJAT FAHRENHEIT: $"
PSN4    DB "NILAI DALAM SKALA DERAJAT KELVIN: $"
PSN5    DB "NILAI DALAM SKALA DERAJAT RHEAMUR: $"
PSN6    DB 13,10,13,10,"TERIMA KASIH TELAH MENGGUNAKAN PROGRAM"
        DB 13,10,13,10,"TEKAN SEMBARANG UNTUK KELUAR $"
CEL     DW ?
KEL     DW ?
RHE     DW ?
FAH     DW ?

MULAI:
LEA DX,PSN1             ;MEMUAT ALAMAT PSN1 PADA DX
MOV AH,9                ;INTERUPSI MENCETAK STRING PSN1
INT 21H                 ;INT 21H FUNGSI 9

LEA DX,PSN2
MOV AH,9                ;INTERUPSI MENCETAK STRING PSN2
INT 21H

CALL SCAN_NUM           ;MEMANGGIL PROSEDUR SCAN_NUM

MOV CEL,CX              ;MENYIMPAN NILAI SKALA DERAJAT CELSIUS
                        ;DALAM CEL

PUTC 13                 ;BERGANTI BARIS SELANJUTNYA
PUTC 10

LEA DX,PSN3
MOV AH,9                ;INTERUPSI MENCETAK STRING PSN3
INT 21H
MOV AX,CEL              ;FUNGSI SKALA CELCIUS MENJADI FAHRENHEIT
MOV BX,9                ;FAHRENHEIT=CELSIUS*9/5+32
IMUL BX
MOV BX,5
IDIV BX
ADD AX,32

MOV FAH,AX              ;MENYIMPAN NILAI SKALA DERAJAT FAHRENHEIT
                        ;DALAM FAH

CALL PRINT_NUM          ;MEMANGGIL PROSEDUR PRINT_NUM
                        ;MENCETAK NILAI AX
                      
PUTC 13                 ;BERGANTI BARIS SELANJUTNYA
PUTC 10

LEA DX,PSN4
MOV AH,9                ;INTERUPSI MENCETAK STRING PSN3
INT 21H

MOV AX,CEL              ;FUNGSI SKALA CELSIUS MENJADI KELVIN
ADD AX,273              ;KELVIN=CELSIUS+273

MOV KEL,AX              ;MENYIMPAN NILAI SKALA DERAJAT KELVIN
                        ;DALAM KEL

CALL PRINT_NUM          ;MEMANGGIL PROSEDUR PRINT_NUM
                        ;MENCETAK NILAI AX
                  
PUTC 13                 ;BERGANTI BARIS SELANJUTNYA
PUTC 10

LEA DX,PSN5
MOV AH,9                ;INTERUPSI MENCETAK STRING PSN4
INT 21H

MOV AX,CEL              ;FUNGSI SKALA CELSIUS MENJADI RHEAMUR
MOV BX,4                ;RHEAMUR=CELSIUS*4/5
IMUL BX
MOV BX,5
IDIV BX
MOV RHE,AX              ;MENYIMPAN NILAI SKALA DERAJAT RHEAMUR
                        ;DALAM RHE
                      
CALL PRINT_NUM          ;MEMANGGIL PROSEDUR PRINT_NUM
                        ;MENCETAK NILAI AX
                     
LEA DX,PSN6
MOV AH,9                ;INTERUPSI MENCETAK STRING PSN6
INT 21H

MOV AH,0                ;INTERUPSI MENUNGGU
INT 16H

RET                     ;KEMBALI KE SISTEM OPERASI

DEFINE_SCAN_NUM         ;MENDEFINISIKAN PROSEDUR
DEFINE_PRINT_NUM
DEFINE_PRINT_NUM_UNS
END                     ;AKHIR
