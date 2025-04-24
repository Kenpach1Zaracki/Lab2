section .bss
    buf resb 256
    n resq 1
    m resq 1
    x resq 1
    y resq 1

section .data
    msg_yes db "Yes: (", 0
    msg_no db "No", 10, 0
    comma db ", ", 0
    close_br db ")", 10, 0

section .text
    global _start

_start:
    ; читаем строку
    mov rax, 0
    mov rdi, 0
    lea rsi, [buf]
    mov rdx, 255
    syscall

    ; парсим n
    lea rsi, [buf]
    call skip_spaces
    call parse_int
    mov [n], rax

    ; парсим m
    call skip_spaces
    call parse_int
    mov [m], rax

    ; устанавливаем начальную позицию
    mov rax, 1
    mov [x], rax
    mov [y], rax

    ; пропускаем пробелы до команд
    call skip_spaces

.check:
    mov al, [rsi]
    cmp al, 0
    je .valid

    cmp al, 10       ; \n — конец строки
    je .valid

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
    mov rax, [y]
    dec rax
    cmp rax, 1
    jl .invalid
    mov [y], rax
    jmp .next

.right:
    mov rax, [y]
    inc rax
    cmp rax, [m]
    jg .invalid
    mov [y], rax
    jmp .next

.up:
    mov rax, [x]
    dec rax
    cmp rax, 1
    jl .invalid
    mov [x], rax
    jmp .next

.down:
    mov rax, [x]
    inc rax
    cmp rax, [n]
    jg .invalid
    mov [x], rax
    jmp .next

.next:
    inc rsi
    jmp .check

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

.invalid:
    lea rsi, [msg_no]
    call print_string

.exit:
    mov rax, 60
    xor rdi, rdi
    syscall

; === parse_int ===
; rsi → строка
; rax ← число
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

; === skip_spaces ===
skip_spaces:
.skip_loop:
    mov al, [rsi]
    cmp al, ' '
    je .skip
    cmp al, 9          ; tab
    je .skip
    ret
.skip:
    inc rsi
    jmp .skip_loop

; === print_string ===
; rsi → null-terminated
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

; === print_number ===
; rax = число
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
