;Nicolas Jorgensen

; //include Irvine32.inc

INCLUDE Irvine32.inc

.data
CaseTable  BYTE   '1'			; lookup value
           DWORD   	AND_op	; address of procedure
		   EntrySize = ( $ - CaseTable) ; size of 1 entry
           BYTE   '2'
           DWORD   OR_op
           BYTE   '3'
           DWORD   NOT_op
           BYTE   '4'
           DWORD   XOR_op
NumberOfEntries = ( $ - caseTable) / EntrySize
errMsg byte "Invalid input! Enter 1 ~ 5 only",0
message1 byte "Input the first 32-bit hexadecimal operand:",0
message2 byte "Input the second 32-bit hexadecimal operand:",0
messageResult byte "The 32-bit hexadecimal result is:",0
messageAND byte"Boolean AND",0
messageOR byte"Boolean OR",0
messageNOT byte"Boolean NOT",0
messageXOR byte"Boolean XOR",0
headerMsg byte "---- Boolean Calculator ----------",0
xAndYMsg byte "1. x AND y",0
xOrYMsg byte "2. x OR y",0
notXMsg byte "3. NOT x",0
xXorYMsg byte "4. x XOR y",0
exitMsg byte "5. Exit program",0
entryMsg byte "Enter integer> ",0
exitNum byte "5",0


.code
;----------------------
;ANDs EAX and EBX
;----------------------
AND_op PROC USES EAX EBX EDX ECX
	;Boolean AND msg
	mov		EDX, OFFSET messageAND
	call	WriteString
	call	crlf
	call	crlf 

	;takes user Input for first hex
	mov		EDX, OFFSET message1
	call	WriteString
	call	ReadHex
	mov		ECX, EAX ;using ECX as temp storage for first hex

	;Input for second hex
	mov		EDX, OFFSET message2
	call	WriteString
	call	ReadHex
	mov		EBX, EAX
	mov		EAX, ECX ;moving 1st hex back to EAX

	mov		EDX,OFFSET	messageResult
	call	WriteString
	and		EAX,EBX
	call	WriteHex
	call	crlf
	ret
AND_op ENDP

;----------------------
;ORs EAX and EBX
;----------------------
OR_op PROC USES EAX EBX EDX

	;Boolean OR msg
	mov		EDX, OFFSET messageOR
	call	WriteString
	call	crlf
	call	crlf 

	;takes user Input for first hex
	mov		EDX, OFFSET message1
	call	WriteString
	call	ReadHex
	mov		ECX, EAX ;using ECX as temp storage for first hex

	;Input for second hex
	mov		EDX, OFFSET message2
	call	WriteString
	call	ReadHex
	mov		EBX, EAX
	mov		EAX, ECX ;moving 1st hex back to EAX

	;print + OR
	mov		EDX,OFFSET	messageResult
	call	WriteString
	or		EAX,EBX
	call	WriteHex
	call	crlf
	ret
OR_op ENDP

;----------------------
;NOTs EAX
;----------------------
NOT_op PROC USES EAX EDX
	;Boolean NOT msg
	mov		EDX, OFFSET messageNOT
	call	WriteString
	call	crlf
	call	crlf 

	;takes user Input
	mov		EDX, OFFSET message1
	call	WriteString
	call	ReadHex

	;print + NOT operation
	mov		EDX,OFFSET	messageResult
	call	WriteString
	not		EAX
	call	WriteHex
	call	crlf
	ret
NOT_op ENDP
;----------------------
;XORs EAX and EBX
;----------------------
XOR_op PROC USES EAX EBX EDX

;XOR msg
	mov		EDX, OFFSET messageXOR
	call	WriteString
	call	crlf
	call	crlf 

;takes user Input for first hex
	mov		EDX, OFFSET message1
	call	WriteString
	call	ReadHex
	mov		ECX, EAX ;using ECX as temp storage for first hex

;Input for second hex
	mov		EDX, OFFSET message2
	call	WriteString
	call	ReadHex
	mov		EBX, EAX
	mov		EAX, ECX ;moving 1st hex back to EAX

;print + XOR
	mov		EDX,OFFSET	messageResult
	call	WriteString
	xor		EAX,EBX
	call	WriteHex
	call	crlf
	ret
XOR_op ENDP

Print_Menu PROC USES EDX
	mov		EDX,OFFSET  headerMsg
	call	WriteString
	call	crlf
	call    crlf

	mov		EDX,OFFSET	xAndYMsg
	call	WriteString
	call	crlf
	mov		EDX,OFFSET	xOrYMsg
	call	WriteString
	call	crlf
	mov		EDX,OFFSET	notXMsg
	call	WriteString
	call	crlf
	mov		EDX,OFFSET	xXorYMsg
	call	WriteString
	call	crlf
	mov		EDX,OFFSET	exitMsg
	call	WriteString
	call	crlf
	call	crlf
	mov		EDX,OFFSET  entryMsg
	call	WriteString
	ret
Print_Menu ENDP

main PROC
L4:
	call	Print_Menu
	call	ReadChar				; read one character
	call	WriteChar
	call	crlf
	mov  ebx,OFFSET CaseTable	; point EBX to the table
	mov  ecx,NumberOfEntries 	; loop counter
L1:
	cmp  al,[ebx]				; match found?
	jne  L2					; no: continue
	call NEAR PTR [ebx + 1]		; yes: call the procedure
	call Crlf
	jmp  L4					; succesful process, repeat
L2:
	add  ebx, EntrySize				; point to the next entry
	loop L1					; repeat until ECX = 0
	cmp	al,exitNum
	je   L3					;exit
	mov		edx, OFFSET errMsg ;input was not 1~5, repeat
	call	WriteString
	call	crlf
	jmp  L4

L3:

	exit
main ENDP

END main