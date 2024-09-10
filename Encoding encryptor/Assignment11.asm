; Encryption Program   

;Nicolas Jorgensen


INCLUDE Irvine32.inc
BUFMAX = 128     	; maximum buffer size

.data
sPrompt  BYTE  "Enter the plain text (128 char max): ",0
sEncrypt BYTE "The plain text after encoding:",0
sDecrypt BYTE  "The plain text after decoding:",0
buffer   BYTE   BUFMAX+1 DUP(0)
key		 BYTE -5, 3, 2, -3, 0, 5, 2, -4, 7, 9
bufSize  DWORD  ?
keySize	 DWORD  LENGTHOF key

.code
main PROC
	call	InputTheString		; input the plain text
	mov	edx,OFFSET sEncrypt	; display encrypted message
	call	EncodeBuffer
	call	DisplayMessage
	call	DecodeBuffer
	mov	edx,OFFSET sDecrypt	; display decrypted message
	call	DisplayMessage

	exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	edx,OFFSET sPrompt	; display a prompt
	call	WriteString
	call	Crlf
	mov	ecx,BUFMAX		; maximum character count
	mov	edx,OFFSET buffer   ; point to the buffer
	call	ReadString         	; input the string
	mov	bufSize,eax        	; save the length
	call	Crlf
	popad
	ret
InputTheString ENDP


;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call	WriteString
	call	Crlf
	mov	edx,OFFSET buffer	; display the buffer
	call	WriteString
	call	Crlf
	call	Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
EncodeBuffer PROC
	pushad
	mov esi, 0							; position in key array
	mov edi, 0							;position in buffer array
	mov	ecx, bufSize					;loop length
	L1: 
		push ecx						;save loop counter in stack
		mov  cl, key[esi]				;move rotate amount in cl
		rol BYTE PTR buffer[edi], cl	;rotate byte by cl
		pop ecx							;return saved loop counter
		inc edi							; move over byte in buffer
		cmp esi,keySize					;if key reaches end
		je Reset						;reset esi to beginning of key
		inc esi							;else inc esi
	loop L1
		jmp Ending						;skip reset
	Reset:
		mov esi, 0						;reset key index
		loop L1
	Ending:
	popad	
	ret
EncodeBuffer ENDP

;-----------------------------------------------------
DecodeBuffer PROC
	pushad
	mov esi, 0							; position in key array
	mov edi, 0							;position in buffer array
	mov	ecx, bufSize					;loop length
	L1: 
		push ecx						;save loop counter in stack
		mov  cl, key[esi]				;move rotate amount in cl
		ror BYTE PTR buffer[edi], cl	;rotate byte by cl
		pop ecx							;return saved loop counter
		inc edi							; move over byte in buffer
		cmp esi,keySize					;if key reaches end
		je Reset						;reset esi to beginning of key
		inc esi							;else inc esi
	loop L1
		jmp Ending						;skip reset
	Reset:
		mov esi, 0						;reset key index
		loop L1
	Ending:
	popad	
	ret
DecodeBuffer ENDP

END main
