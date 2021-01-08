.486
data segment use16
bnum DW 0001001000110100B ;1234H
    DW 0101011001111000B ;5678H
    DW 0001101000101011B ;1A2BH
    DW 0011110001001101B ;3C4DH
buf db 4 dup(?), 'H $'
count db 4
data ends

code segment use16
	assume cs:code, ds:data
	beg:mov ax, data
		mov ds, ax
		mov cx, 4
		mov bx, offset bnum
	again:mov dx, [bx]
		sal edx, 16; 高16位与低16位互换，否则后面4位4位
								;隔离的时会破坏数据
		call N2_16
		mov ah, 9
		mov dx, offset buf
		int 21H
		add bx, 2
		loop again
		mov ah, 4CH
		int 21H
			
	;-----------------------
	N2_16 proc
		mov si, offset buf
		mov count, 4
	last:rol edx, 4
		and dl, 0FH ; mask operate 
		cmp dl, 10
		jc next
		add dl, 7
	next:add dl, 30H
		mov [si], dl
		inc si
		dec count
		jnz last
		ret
	N2_16 endp
	;-----------------------
	
code ends
end beg	