section .data
    x db 12
    y db 7
    mensaje db "Valor final: "
    tam_mensaje equ $ - mensaje
    buffer db "   ", 10
    tam_buffer equ $ - buffer

section .text
    global _start

_start:
    mov al, [x]
    mov bl, [y]
    mul bl

    mov bx, 10
    mov cx, 3
    mov edi, buffer + 2

conv_loop:
    xor dx, dx
    div bx
    add dl, '0'
    mov [edi], dl
    dec edi
    test ax, ax
    jz fin_conv
    loop conv_loop

fin_conv:
    mov esi, edi
    inc esi
    mov edi, buffer
    mov ecx, tam_buffer
    rep movsb

    mov eax, 4
    mov ebx, 1
    mov ecx, mensaje
    mov edx, tam_mensaje
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, tam_buffer
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
