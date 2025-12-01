%include "in_out.asm"

SECTION .data
msg_func   db "Функция: f(x) = 6x + 13", 0
msg_result db "Результат: ", 0

SECTION .bss
res: RESB 80           ; резервируем память для временного результата

SECTION .text
GLOBAL _start

_start:
    ; печать описания функции
    mov eax, msg_func
    call sprintLF

    ; ecx = количество аргументов (без имени программы)
    pop ecx            ; получаем argc
    pop edx            ; получаем argv[0] (имя программы)
    sub ecx, 1         ; уменьшаем счетчик на 1 (убираем имя программы)
    
    cmp ecx, 0         ; проверяем, есть ли аргументы
    jz no_args         ; если нет аргументов, выходим
    
    mov esi, 0          ; сумма значений f(x)

process_args:
    pop eax             ; взять аргумент (строку)
    call atoi           ; перевести строку в число, результат в eax
    
    ; Вызов подпрограммы для вычисления f(x) = 6x + 13
    call _calcul
    
    ; Результат в eax, добавляем к сумме
    add esi, eax
    
    ; Уменьшаем счетчик и проверяем на конец
    dec ecx
    jnz process_args
    
    ; Вывод результата
    mov eax, msg_result
    call sprint
    mov eax, esi
    call iprintLF
    
    call quit

no_args:
    mov eax, msg_result
    call sprint
    mov eax, 0          ; если нет аргументов, результат 0
    call iprintLF
    call quit

; Подпрограмма для вычисления f(x) = 6x + 13
; Вход:  eax = x
; Выход: eax = 6x + 13
_calcul:
    ; Сохраняем регистры, которые будем использовать
    push ebx
    
    ; Вычисляем 6x
    mov ebx, 6
    mul ebx             ; eax = 6 * x
    
    ; Добавляем 13
    add eax, 13         ; eax = 6x + 13
    
    ; Восстанавливаем регистры
    pop ebx
    
    ret                 ; возврат из подпрограммы
