section .data
    prompt db 'Masukkan sebuah angka: ', 0      ; pesan input
    not_prime_msg db ' bukan bilangan prima.', 0xA  ; pesan jika bukan bilangan prima
    prime_msg db ' adalah bilangan prima.', 0xA     ; pesan jika bilangan prima
    newline db 0xA, 0                             ; newline

section .bss
    num resb 10      ; buffer untuk menyimpan input angka (maksimal 10 digit)
    len resd 1       ; panjang string input

section .text
    global _start

_start:
    ; Mencetak prompt
    mov eax, 4              ; syscall number untuk sys_write
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, prompt         ; pesan input
    mov edx, 24             ; panjang pesan
    int 0x80

    ; Membaca input dari user
    mov eax, 3              ; syscall number untuk sys_read
    mov ebx, 0              ; file descriptor (stdin)
    mov ecx, num            ; buffer untuk menyimpan input
    mov edx, 10             ; baca maksimal 10 karakter
    int 0x80
    mov [len], eax          ; simpan panjang input

    ; Konversi string ke integer
    xor eax, eax            ; clear eax (untuk hasil akhir)
    xor ebx, ebx            ; clear ebx (untuk posisi dalam string)
    mov ecx, [len]          ; ambil panjang input
    dec ecx                 ; kurangi satu (karena termasuk newline)
konversi_loop:
    movzx edx, byte [num+ebx] ; ambil karakter dari buffer input
    cmp edx, 0xA            ; cek apakah karakter adalah newline
    je selesai_konversi      ; jika iya, selesai
    sub edx, '0'            ; konversi ASCII ke angka
    imul eax, eax, 10        ; kalikan hasil sebelumnya dengan 10
    add eax, edx            ; tambahkan digit saat ini
    inc ebx                 ; lanjut ke karakter berikutnya
    cmp ebx, ecx            ; cek apakah sudah mencapai akhir string
    jl konversi_loop

selesai_konversi:
    mov ebx, eax            ; simpan angka ke ebx untuk pemeriksaan

    ; Cek apakah angka <= 1 (bukan bilangan prima)
    cmp ebx, 1
    jle bukan_prima

    ; Inisialisasi loop untuk memeriksa apakah angka prima
    mov ecx, 2              ; divisor mulai dari 2
cek_loop:
    cmp ecx, ebx            ; jika divisor >= angka, keluar loop
    jge prima

    ; Cek apakah angka habis dibagi ecx
    mov eax, ebx            ; copy angka ke eax
    xor edx, edx            ; clear edx untuk operasi divisi
    div ecx                 ; eax = eax / ecx, hasil di eax, sisa di edx
    cmp edx, 0              ; jika tidak ada sisa (mod 0)
    je bukan_prima          ; angka bukan prima jika habis dibagi

    inc ecx                 ; increment divisor
    jmp cek_loop            ; ulangi loop

prima:
    ; Angka adalah bilangan prima, cetak pesan
    mov eax, 4              ; syscall number untuk sys_write
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, num            ; cetak input
    mov edx, [len]          ; panjang input (dengan newline)
    dec edx                 ; hapus newline
    int 0x80

    mov eax, 4              ; syscall number untuk sys_write
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, prime_msg      ; pesan bilangan prima
    mov edx, 23             ; panjang pesan
    int 0x80
    jmp keluar

bukan_prima:
    ; Angka bukan bilangan prima, cetak pesan
    mov eax, 4              ; syscall number untuk sys_write
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, num            ; cetak input
    mov edx, [len]          ; panjang input (dengan newline)
    dec edx                 ; hapus newline
    int 0x80

    mov eax, 4              ; syscall number untuk sys_write
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, not_prime_msg  ; pesan bukan bilangan prima
    mov edx, 24             ; panjang pesan
    int 0x80

keluar:
    ; Keluar dari program
    mov eax, 1              ; syscall number untuk sys_exit
    xor ebx, ebx            ; status exit 0
    int 0x80
