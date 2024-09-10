;Nicolas Jorgensen
;Write Color Block procedure

INCLUDE Chess.inc
.code
PrintRow PROC,
	color1:BYTE, 
	color2:BYTE
pushad
mov ecx, 4
L1:
	INVOKE WriteColorBlock, " ", color1
	INVOKE WriteColorBlock, " ", color2
loop L1
call crlf
popad
ret
PrintRow ENDP
END