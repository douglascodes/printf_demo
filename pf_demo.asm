%include "amd64_abi.mac"
[SECTION .data]
    First_string:   db "First string.",10,"%s", "%d is an integer. So is %d",10
                    db "Floats XMM0:%5.7f  XMM1:%.6le  XMM2:%lg",10,0         ; FORMATTED string
    Second_String:  db "This is the second string... %s's are not interpreted here.",10
                    db " Neither are %d's nor %f's. 'Cause it is a passed value.", 10, 0    ; Just a regular string for insert.
[SECTION .bss]
[SECTION .text]
    EXTERN printf
    GLOBAL main
main:
    _preserve_64AMD_ABI_regs ; Saves RBP, RBX, R12-R15
    mov rdi, First_string   ; Start of string to be formatted. Null terminated
    mov rsi, Second_String  ; String addy of first %s in main string. Not interpretted
    mov rcx, 0456           ; Second Integer (Each register is specific for ordered arguments.)
    mov rdx, 0123           ; First integer (Order of assignment does not matter.)
                            ; Order of Integer/Pointer Registers:
                            ; $1:RDI   $2:RSI   $3:RDX   $4:RCX   $5:R8   $6:R9

    mov rax,0AABBCCh         ; Test value to be stored in xmm0
    cvtsi2sd xmm0, rax      ; Convert quad to scalar double
    mov rax,003333h         ; Test value to be stored in xmm1
    cvtsi2sd xmm1, rax      ; Convert quad to scalar double
    cvtsi2sd xmm2, rax      ; Convert quad to scalar double
    divsd xmm2, xmm0        ; Divide scalar double

;    sub rsp, 16             ; Allocates 16 byte shadow memory
;    _prealign_stack_to16    ; Move to the lower end 16byte boundry (Seg-Fault otherwise)
    mov rax, 2             ; Count of xmm registers used for floats. ?!needed?!
Before_Call:
    call printf             ; Send the formatted string to C-printf
;    add rsp, 16             ; reallocate shadow memory

    _restore_64AMD_ABI_regs_RET