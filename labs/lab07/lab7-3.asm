%include "in_out.asm"

SECTION .data
msg_x:  db "Vvedite znachenie peremennoj x: ",0
msg_a:  db "Vvedite znachenie peremennoj a: ",0
msg_res: db "Rezultat: ",0

SECTION .bss
x:  resb 80
a:  resb 80

SECTION .text
global _start

_start:
    ; ввод x
    mov eax, msg_x
    call sprint
    mov ecx, x
    mov edx, 80
    call sread
    mov eax, x
    call atoi
    mov ebx, eax        ; ebx = x

    ; ввод a
    mov eax, msg_a
    call sprint
    mov ecx, a
    mov edx, 80
    call sread
    mov eax, a
    call atoi
    mov ecx, eax        ; ecx = a

    ; if x < a: f = a + 10
    ; else:     f = x + 10

    mov eax, ebx        ; eax = x
    cmp eax, ecx        ; сравниваем x и a
    jl  calc_a_plus_10  ; если x < a

    ; ветка x >= a: f = x + 10
    add eax, 10
    jmp print_res

calc_a_plus_10:
    mov eax, ecx        ; eax = a
    add eax, 10

print_res:
    mov ebx, eax        ; ebx = f(x)

    mov eax, msg_res
    call sprint
    mov eax, ebx
    call iprintLF

    call quit
