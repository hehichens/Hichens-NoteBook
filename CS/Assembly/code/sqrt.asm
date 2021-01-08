.486
data segment use16
    num32 dd 99
data ends

code segment use16
assume cs:code, ds:data
    beg:mov ax, data
        mov ds, ax
        mov eax, num32
        mov ecx, 0

    last:mov edx, ecx
        add edx, edx
        inc edx
        sub eax, edx
        jc disp
        inc ecx
        jmp last

    disp:mov dl, cl
        add dl, '0'
        mov ah, 2
        int 21H
        mov ah, 4CH
        int 21H
code ends
end beg