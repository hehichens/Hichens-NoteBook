data segment use16
    msg db 'hello, world! $'
data ends

code segment use16
assume cs:code, ds:data
    beg:mov ax, data
        mov ds, ax
        lea dx, msg
        mov ah, 9H
        int 21H
        mov ah, 4CH
        int 21H
code ends
end beg
