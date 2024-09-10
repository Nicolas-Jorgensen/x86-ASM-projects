;Nicolas Jorgensen
;Write Color Block procedure

INCLUDE Chess.inc
.code
WriteColorBlock PROC,
	char:BYTE, 
	backcolor:BYTE
pushad
movzx eax, backcolor
mov	ebx, 16
mul ebx
call setTextColor
mov	al, char
call WriteChar
call WriteChar
mov eax, white +(black*16)
call setTextColor
popad
ret
WriteColorBlock ENDP
END