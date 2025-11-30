%include "in_out.asm"

SECTION .data
msg_func   db "Функция: f(x) = 6x + 13", 0
msg_result db "Результат: ", 0

SECTION .text
GLOBAL _start

_start:
    ; печать описания функции
    mov eax, msg_func
    call sprintLF

    ; ecx = количество аргументов (без имени программы)
    pop ecx
    pop edx
    sub ecx, 1
    mov esi, 0          ; сумма значений f(x)

next:
    cmp ecx, 0
    jz _end

    pop eax             ; взять аргумент
    call atoi           ; перевести строку в число, результат в eax

    mov ebx, 6
    mul ebx             ; eax = 6 * x
    add eax, 13         ; eax = 6 * x + 13

    add esi, eax        ; добавить к сумме

    loop next

_end:
    mov eax, msg_result
    call sprint
    mov eax, esi
    call iprintLF
    call quit
