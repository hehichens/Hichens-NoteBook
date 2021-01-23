.486
data segment use 16
    msg db 'Hello, World! $'
data ends

code segment use 16
assume cs:code, ds:data
    beg:mov ax, data
        mov ds, ax
        lea dx, msg
        mov al 9
        int 21H
code ends
end beg