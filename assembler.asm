section .bss
    buf resb 256      ; Буфер для ввода (до 256 символов)
    n resq 1          ; Количество строк
    m resq 1          ; Количество столбцов
    x resq 1          ; Текущая координата x
    y resq 1          ; Текущая координата y
    minx resq 1       ; Минимальная X координата
    maxx resq 1       ; Максимальная X координата
    miny resq 1       ; Минимальная Y координата
    maxy resq 1       ; Максимальная Y координата

section .data
    msg_yes db "Yes: (", 0       ; Сообщение при успешном завершении
    msg_no db "No", 10, 0        ; Сообщение при ошибке
    comma db ", ", 0             ; Разделитель координат
    close_br db ")", 10, 0       ; Закрывающая скобка

section .text
    global _start   ; Точка входа программы

; ============================
; Чтение и парсинг ввода
; ============================
_start:
    ; Чтение данных с ввода
    mov rax, 0
    mov rdi, 0
    lea rsi, [buf]
    mov rdx, 255
    syscall

    ; Парсинг чисел (количество строк и столбцов)
    lea rsi, [buf]
    call skip_spaces
    call parse_int
    mov [n], rax

    call skip_spaces
    call parse_int
    mov [m], rax

; ============================
; Инициализация позиции
; ============================
    mov rax, 1
    mov [x], rax
    mov [y], rax

    call skip_spaces

; ============================
; Обработка команд движения
; ============================
.check:
    mov al, [rsi]
    cmp al, 0
    je .valid
    cmp al, 10
    je .valid

    ; Обработка команд 'L', 'R', 'U', 'D'
    cmp al, 'L'
    je .left
    cmp al, 'R'
    je .right
    cmp al, 'U'
    je .up
    cmp al, 'D'
    je .down

    jmp .invalid

; ============================
; Движение влево
; ============================
.left:
    mov rax, [y]
    dec rax
    cmp rax, 1
    jl .invalid
    mov [y], rax
    jmp .next

; ============================
; Движение вправо
; ============================
.right:
    mov rax, [y]
    inc rax
    cmp rax, [m]
    jg .invalid
    mov [y], rax
    jmp .next

; ============================
; Движение вверх
; ============================
.up:
    mov rax, [x]
    dec rax
    cmp rax, 1
    jl .invalid
    mov [x], rax
    jmp .next

; ============================
; Движение вниз
; ============================
.down:
    mov rax, [x]
    inc rax
    cmp rax, [n]
    jg .invalid
    mov [x], rax
    jmp .next

; ============================
; Переход к следующей команде
; ============================
.next:
    inc rsi
    jmp .check

; ============================
; Успешный результат
; ============================
.valid:
    lea rsi, [msg_yes]
    call print_string
    mov rax, [x]
    call print_number
    lea rsi, [comma]
    call print_string
    mov rax, [y]
    call print_number
    lea rsi, [close_br]
    call print_string
    jmp .exit

; ============================
; Ошибка ввода
; ============================
.invalid:
    lea rsi, [msg_no]
    call print_string

; ============================
; Завершение программы
; ============================
.exit:
    mov rax, 60
    xor rdi, rdi
    syscall

; ============================
; Преобразование строки в число
; ============================
parse_int:
    xor rax, rax
    xor rbx, rbx
    mov rcx, 10
.parse_loop:
    mov bl, [rsi]
    cmp bl, '0'
    jb .done
    cmp bl, '9'
    ja .done
    sub bl, '0'
    imul rax, rcx
    add rax, rbx
    inc rsi
    jmp .parse_loop
.done:
    ret

; ============================
; Пропуск пробелов и табуляций
; ============================
skip_spaces:
.skip_loop:
    mov al, [rsi]
    cmp al, ' '
    je .skip
    cmp al, 9
    je .skip
    ret
.skip:
    inc rsi
    jmp .skip_loop

; ============================
; Вывод строки на экран
; ============================
print_string:
    mov rdx, 0
.strlen:
    cmp byte [rsi+rdx], 0
    je .print
    inc rdx
    jmp .strlen
.print:
    mov rax, 1
    mov rdi, 1
    syscall
    ret

; ============================
; Вывод числа на экран
; ============================
print_number:
    mov rcx, 10
    sub rsp, 32
    mov rdi, rsp
    add rdi, 32
    mov rbx, 0
.rev_loop:
    xor rdx, rdx
    div rcx
    dec rdi
    add dl, '0'
    mov [rdi], dl
    inc rbx
    test rax, rax
    jnz .rev_loop
    mov rax, 1
    mov rsi, rdi
    mov rdi, 1
    mov rdx, rbx
    syscall
    add rsp, 32
    ret
