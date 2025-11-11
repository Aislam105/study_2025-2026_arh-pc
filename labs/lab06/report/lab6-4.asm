%include 'in_out.asm'

  SECTION .data
  msg: DB 'Введите значение переменной x: ',0
  rem: DB 'Результат: ',0

  SECTION .bss
  x: RESB 80

  SECTION .text
  GLOBAL _start
   _start:
    
    mov eax, msg
    call sprint
    
    
    mov ecx, x
    mov edx, 80
    call sread
    
   
    mov eax, x
    call atoi
    mov ebx, eax    
    
    
    add ebx, 5      
    
   
    mov eax, ebx    
    mul eax         
    
    
    sub eax, 3     
    
  
    mov edi, eax   
    
    mov eax, rem    
    call sprint
    
    mov eax, edi  
    call iprintLF   
    
    call quit       
