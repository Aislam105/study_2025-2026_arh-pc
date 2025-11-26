%include "in_out.asm"

SECTION .data
    msg1 db 'Введите B: ', 0
    msg2 db 'Наибольшее число: ', 0

    A   dd 32
    C   dd 54

SECTION .bss
    max resd 1     ; максимум хранится тут (4 байта)
    B   resd 1     ; тут число из ввода

SECTION .text
    global _start

_start:
    ; вывод приглашения и ввод B (как строка)
    mov eax, msg1
    call sprint

    mov ecx, B         ; адрес B для строки
    mov edx, 10        ; максимум 10 символов
    call sread

    ; перевод строки в число
    mov eax, B
    call atoi
    mov [B], eax

    ; max = A
    mov eax, [A]
    mov [max], eax

    ; сравниваем max и C
    mov eax, [max]
    cmp eax, [C]
    jge check_B        ; если max >= C, остаётся как есть
    mov eax, [C]       ; иначе max = C
    mov [max], eax

check_B:
    ; сравниваем max и B
    mov eax, [max]
    cmp eax, [B]
    jge fin            ; если max >= B, оставляем
    mov eax, [B]       ; иначе max = B
    mov [max], eax

fin:
    mov eax, msg2
    call sprint

    mov eax, [max]
    call iprintLF

    call quit

