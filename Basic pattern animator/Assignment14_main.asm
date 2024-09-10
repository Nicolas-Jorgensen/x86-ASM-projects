;Assignment14 Main proc
;Nicolas Jorgensen
INCLUDE Chess.inc

.code

main PROC

mov ecx,16 ;for 16 colors
mov bl, 0
L1:		
	INVOKE PrintBoard, bl
	inc bl						;change color
	mov eax, 500				;delay for 500 milliseconds
	call Delay		
loop L1
	exit
main ENDP

END main