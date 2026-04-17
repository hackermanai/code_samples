
; Hackerman Text ASM lexer test file

.global _start
.section .text

_start:
    mov     rax, 1
    lea     rdi, [message]
    add     rsi, 4
    cmp     rax, rbx
    jne     fail
    call    helper
    jmp     done

helper:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    xor     eax, eax
    test    rdi, rdi
    je      .Lzero
    inc     eax
    shr     eax, 1
    pop     rbp
    ret

.Lzero:
    nop
    ret

fail:
    mov     r0, #0
    add     r1, r1, r2
    ldr     r3, [r4]
    str     r5, [r6]
    b       done

done:
    addi    a0, a0, 1
    jal     ra, finish
    br      finish

finish:
    ld      x1, 0(sp)
    st      x2, 8(sp)
    jr      ra

message:
    .ascii  "hello world\n"
    .byte   10
    .word   1234
    .long   0x12345678
    .quad   0x1122334455667788

.section .data
buffer:
    .byte   0, 1, 2, 3
    .asciz  "data string"

.section .bss
temp:
    .long   0

macro demo_macro
label_inside_macro:
    mov     ax, bx
    add     eax, 10
    cmp     eax, 20
    jmp     end_label
endm

proc demo_proc
local_label:
    mov     t0, t1
    and     t2, t3
    or      s0, s1
    xor     a0, a1
    ret
endp

segment extra
extra_label:
    mov     x0, x1
    sub     x2, x3
    ret

numbers:
    mov     eax, 123
    mov     ebx, 0xff
    mov     ecx, $ff
    mov     edx, %10101010
    mov     esi, 1.5
    mov     edi, 10h

strings:
    .ascii  "plain string"
    .asciz  "escaped \"quote\" and \\ slash"
    .byte   'A'

conditions:
    cmp     eax, ebx
    je      equal_case
    jne     notequal_case
    jl      less_case
    jg      greater_case

equal_case:
    nop
notequal_case:
    nop
less_case:
    nop
greater_case:
    nop

# hash comment style test
// slash comment style test (only if enabled)

final_label:
    ret

