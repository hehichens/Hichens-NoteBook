.486 
code segment use16
    assume cs:code
    num32 dd 3456789000
    beg:mov eax, num32
        mov ebx, 10
        mov cx, 0
    last:mov edx, 0
        div ebx
        push dx
        inc cx
        cmp eax, 0
        jnz last
    aga:pop dx
        add dl, 30H
        mov ah, 2
        int 21H
        loop aga
        mov ah, 4CH; return 
        int 21H
code ends
end beg