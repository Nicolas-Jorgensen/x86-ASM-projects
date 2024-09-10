;Nicolas Jorgensen
;PrintBoard procedure

INCLUDE Chess.inc
.code
PrintBoard PROC,
	color:BYTE
pushad
mov edx, 0		;to locate the cursor at the origin
call GoToXY

mov ecx, 4		;4 loop counter, n loop = n*2 rows
L1:
	INVOKE PrintRow, color, white
	INVOKE PrintRow, white, color
loop L1

popad
ret
PrintBoard ENDP
END