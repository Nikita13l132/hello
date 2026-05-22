format ELF executable 3
entry Start

segment readable writeable

filename db 'test.txt',0

message db 'Hello from ASM!', 0xA
msgLen = $ - message

buffer rb 32

fd dd 0

segment readable executable

Start:

; =========================
; open("test.txt", O_CREAT | O_WRONLY, 0666)
; =========================

    mov eax, 5          ; sys_open
    mov ebx, filename
    mov ecx, 0101o      ; O_CREAT | O_WRONLY
    mov edx, 0666o      ; права доступа
    int 0x80

    mov [fd], eax

; =========================
; write(fd, message, msgLen)
; =========================

    mov eax, 4          ; sys_write
    mov ebx, [fd]
    mov ecx, message
    mov edx, msgLen
    int 0x80

; =========================
; close(fd)
; =========================

    mov eax, 6          ; sys_close
    mov ebx, [fd]
    int 0x80

; =========================
; open("test.txt", O_RDONLY)
; =========================

    mov eax, 5          ; sys_open
    mov ebx, filename
    mov ecx, 0          ; O_RDONLY
    int 0x80

    mov [fd], eax

; =========================
; read(fd, buffer, msgLen)
; =========================

    mov eax, 3          ; sys_read
    mov ebx, [fd]
    mov ecx, buffer
    mov edx, msgLen
    int 0x80

; =========================
; close(fd)
; =========================

    mov eax, 6          ; sys_close
    mov ebx, [fd]
    int 0x80

; =========================
; write(stdout, buffer, msgLen)
; =========================

    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, buffer
    mov edx, msgLen
    int 0x80

; =========================
; exit(0)
; =========================

    mov eax, 1          ; sys_exit
    xor ebx, ebx
    int 0x80