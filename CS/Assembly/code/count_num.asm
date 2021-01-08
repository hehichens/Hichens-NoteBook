.486
data segment use16
    dnum dw -10, 10, -20, 20, 5, 2, 1 ; 7 numebrs
    count_neg db 0
    count_pos db 0
data ends

code segment use16
assume cs:code, ds:data
    beg:mov ax, data
        mov ds, ax
        mov cx, 7
        mov dx, 0
        mov bx, offset dnum

    aga:mov ax, [bx]
        cmp ax, 0
        jl isneg
        inc count_pos
        jmp next
    isneg:inc count_neg

    next:add bx, 2
        loop aga

        mov dl, count_pos
        call disp
        mov dl, count_neg
        call disp
        mov ah, 4CH
        int 21H

    ;---------------------------
    disp proc
        mov ah, 2
        add dl, 30H
        int 21H
        mov dl, 0AH
        int 21H
        ret
    disp endp
    ;---------------------------

    
code ends
end beg