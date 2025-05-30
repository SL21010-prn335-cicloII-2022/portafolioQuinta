section .data
    dividendo_32 dd 120
    divisor_32 dd 9
    cociente_32 dd 0
    residuo_32 dd 0

    texto_cociente db "Quotient: ", 0
    tam_cociente equ $ - texto_cociente - 1

    texto_residuo db "Remainder: ", 0
    tam_residuo equ $ - texto_residuo - 1

    salto_linea db 10
    buffer_num times 11 db 0

section .text
    global _start

_start:
    mov eax, [dividendo_32]
    xor edx, edx
    div dword [divisor_32]
    mov [cociente_32], eax
    mov [residuo_32], edx

    mov eax, 4
    mov ebx, 1
    mov ecx, texto_cociente
    mov edx, tam_cociente
    int 0x80

    mov eax, [cociente_32]
    call print_number

    mov eax, 4
    mov ebx, 1
    mov ecx, texto_residuo
    mov edx, tam_residuo
    int 0x80

    mov eax, [residuo_32]
    call print_number

    mov eax, 1
    mov ebx, 0
    int 0x80

print_number:
    mov ebx, buffer_num + 10
    mov byte [ebx], 0
    mov ecx, 10

.conv_loop:
    dec ebx
    xor edx, edx
    div ecx
    add dl, '0'
    mov [ebx], dl
    test eax, eax
    jnz .conv_loop

    mov eax, buffer_num + 11
    sub eax, ebx

    mov edx, eax
    mov ecx, ebx
    mov eax, 4
    mov ebx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, salto_linea
    mov edx, 1
    int 0x80

    ret
