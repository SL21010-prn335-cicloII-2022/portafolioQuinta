section .data
    a dw 75
    b dw 15
    c dw 10
    r dw 0

    texto db "Resultado final: "
    tam_texto equ $ - texto

    salida db "00", 10
    tam_salida equ $ - salida

section .text
    global _start

_start:
    mov ax, [a]
    sub ax, [b]
    sub ax, [c]
    mov [r], ax

    mov bl, 10
    xor dx, dx
    div bl
    add al, '0'
    add ah, '0'
    mov [salida], al
    mov [salida+1], ah

    mov eax, 4
    mov ebx, 1
    mov ecx, texto
    mov edx, tam_texto
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, salida
    mov edx, tam_salida
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
