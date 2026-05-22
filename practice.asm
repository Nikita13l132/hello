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
    mov eax, 5         
    mov ebx, filename
    mov ecx, 0101o     
    mov edx, 0666o     
    int 0x80

    mov [fd], eax

    mov eax, 4          
    mov ebx, [fd]
    mov ecx, message
    mov edx, msgLen
    int 0x80

    mov eax, 6         
    mov ebx, [fd]
    int 0x80

    mov eax, 5          
    mov ebx, filename
    mov ecx, 0         
    int 0x80

    mov [fd], eax

    mov eax, 3          
    mov ebx, [fd]
    mov ecx, buffer
    mov edx, msgLen
    int 0x80

    mov eax, 6         
    mov ebx, [fd]
    int 0x80

    mov eax, 4          
    mov ebx, 1          
    mov ecx, buffer
    mov edx, msgLen
    int 0x80

    mov eax, 1          
    xor ebx, ebx
    int 0x80