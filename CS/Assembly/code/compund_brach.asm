.486
data segment use16
	msg1 db 'N1 <= X <= N2 $'
	msg2 db 'X < N1 $'
	msg3 db 'X > N2 $'
	
	number db 199
	n1 equ 22
	n2 equ 88
data ends

code segment use16
        assume cs:code, ds:data
	beg:mov ax, data
        mov ds, ax
        mov dx, offset msg1 ; n1 < X < n2
        cmp number, n1
        jnc next
        mov dx, offset msg2 ; X < n1
        jmp disp
			
	next:cmp number, n2
        jc disp
        mov dx, offset msg3 ; X > n2
			
	disp:mov ah, 9
        int 21H
        mov ah, 4CH
        int 21H
code ends
end beg