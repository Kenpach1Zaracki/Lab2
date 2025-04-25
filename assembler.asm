section .bss
    buf resb 256      ; Буфер для ввода
    n resq 1          ; Количество строк
    m resq 1          ; Количество столбцов
    x resq 1          ; Текущая X координата
    y resq 1          ; Текущая Y координата
    minx resq 1
    maxx resq 1
    miny resq 1
    maxy resq 1

section .data
    msg_yes db "Yes: (", 0
    msg_no db "No", 10, 0
    comma db ", ", 0
    close_br db ")", 10, 0

section .text
    global _start

; ========== ПРОЦЕДУРЫ ==========
skip_spaces:
.skip:
    mov al, [rsi]
    cmp al, ' '
    je .inc
    cmp al, 9
    je .inc
    ret
.inc:
    inc rsi
    jmp .skip

parse_int:
    xor rax, rax
    xor rbx, rbx
    mov rcx, 10
.next_digit:
    mov bl, [rsi]
    cmp bl, '0'
    jb .done
    cmp bl, '9'
    ja .done
    sub bl, '0'
    imul rax, rcx
    add rax, rbx
    inc rsi
    jmp .next_digit
.done:
    ret

print_string:
    mov rdx, 0
.strlen:
    cmp byte [rsi + rdx], 0
    je .print
    inc rdx
    jmp .strlen
.print:
    mov rax, 1
    mov rdi, 1
    syscall
    ret

print_number:
    mov rcx, 10
    sub rsp, 32
    mov rdi, rsp
    add rdi, 32
    mov rbx, 0
.convert:
    xor rdx, rdx
    div rcx
    dec rdi
    add dl, '0'
    mov [rdi], dl
    inc rbx
    test rax, rax
    jnz .convert
    mov rax, 1
    mov rsi, rdi
    mov rdi, 1
    mov rdx, rbx
    syscall
    add rsp, 32
    ret

; ========== ТОЧКА ВХОДА ==========
_start:
    ; Читаем ввод
    mov rax, 0
    mov rdi, 0
    lea rsi, [buf]
    mov rdx, 255
    syscall

    ; Парсим N и M
    lea rsi, [buf]
    call skip_spaces
    call parse_int
    mov [n], rax

    call skip_spaces
    call parse_int
    mov [m], rax

    ; Инициализация
    xor rax, rax
    mov [x], rax
    mov [y], rax
    mov [minx], rax
    mov [maxx], rax
    mov [miny], rax
    mov [maxy], rax

    call skip_spaces

; ========== ОБРАБОТКА КОМАНД ==========
.loop:
    mov al, [rsi]
    cmp al, 0
    je .check_bounds
    cmp al, 10
    je .check_bounds

    cmp al, 'L'
    je .left
    cmp al, 'R'
    je .right
    cmp al, 'U'
    je .up
    cmp al, 'D'
    je .down
    jmp .invalid

.left:
    dec qword [y]
    jmp .update
.right:
    inc qword [y]
    jmp .update
.up:
    dec qword [x]
    jmp .update
.down:
    inc qword [x]
    jmp .update

.update:
    ; Обновление мин/макс
    mov rax, [x]
    mov rbx, [minx]
    cmp rax, rbx
    jge .no_minx
    mov [minx], rax
.no_minx:
    cmp rax, [maxx]
    jle .no_maxx
    mov [maxx], rax
.no_maxx:

    mov rax, [y]
    cmp rax, [miny]
    jge .no_miny
    mov [miny], rax
.no_miny:
    cmp rax, [maxy]
    jle .no_maxy
    mov [maxy], rax
.no_maxy:

    inc rsi
    jmp .loop

; ========== ПРОВЕРКА ГРАНИЦ ==========
.check_bounds:
    mov rax, [maxx]
    sub rax, [minx]
    inc rax         ; Длина по X
    cmp rax, [n]
    ja .invalid

    mov rax, [maxy]
    sub rax, [miny]
    inc rax         ; Длина по Y
    cmp rax, [m]
    ja .invalid

    ; Вывод Yes: (1 - minx, 1 - miny)
    lea rsi, [msg_yes]
    call print_string

    mov rax, 1
    sub rax, [minx]
    call print_number

    lea rsi, [comma]
    call print_string

    mov rax, 1
    sub rax, [miny]
    call print_number

    lea rsi, [close_br]
    call print_string
    jmp .exit

.invalid:
    lea rsi, [msg_no]
    call print_string

.exit:
    mov rax, 60
    xor rdi, rdi
    syscall
