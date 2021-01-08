.486
data segment use16
    alpha db 'd'
    buf 2 dup(?) ''
data ends

code segment use16
assume cs:code, ds:data
    beg:mov ax, data
        mov ds, ax
        mov dl, 'A'-'a'
        mov ah, 2
        int 21H
        mov ah, 4CH
        int 21H
code ends
end beg