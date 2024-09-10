;Nicolas Jorgensen
; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
messageFirst byte "Enter the first integer:", 0
messageSecond byte "Enter the second integer:", 0
messageSum byte "The sum is:",0
location word 0a2ch		; screen center coordinates

.code
main PROC
mov		EAX, 0A8h	;using to setcolor
mov		ECX, 3		;sets loop amount
L1:
	add		EAX, 17d		;sets colors change each loop
	call	SetTextColor
	call	Clrscr
	push	EAX				;saving color info to stack
	mov		DX, location	;text location
	call	Gotoxy				;centering text
	mov		EDX, Offset messageFirst
	call	WriteString
	call	ReadInt			;reading user input
	mov		EBX, EAX
	movzx	EDX, location	;text location
	add		DH, 2			;moving down 2 rows
	call	Gotoxy
	mov		EDX, Offset messageSecond
	call	WriteString
	call	ReadInt
	add		EBX, EAX
	movzx	EDX, location	;text location
	add		DH, 4			;moving 2 more rows
	call	Gotoxy
	mov		EDX, Offset messageSum
	call	WriteString
	mov		EAX, EBX
	call	WriteInt
	call	Crlf
	call	Waitmsg
	pop		EAX				;recovering color info from stack
loop L1

main ENDP

END main