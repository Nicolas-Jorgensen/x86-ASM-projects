; Encryption Program   

;Nicolas Jorgensen

; This program demonstrates simple symmetric
; encryption using the XOR instruction.

INCLUDE Irvine32.inc
KEY = 239     		; any value between 1-255
BUFMAX = 128     	; maximum buffer size

.data
sPrompt  BYTE  "Enter the plain text: ",0
ePrompt  BYTE  "Enter encryption key: ",0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0
buffer   BYTE   BUFMAX+1 DUP(0)
keyBuf	 BYTE	BUFMAX+1 DUP(0)
bufSize  DWORD  ?
keySize	 DWORD  ?

.code
main PROC
	call	InputTheString		; input the plain text
	call	InputKey		;asks and store user-defined key
	call	TranslateBuffer	; encrypt the buffer
	mov	edx,OFFSET sEncrypt	; display encrypted message
	call	DisplayMessage
	call	TranslateBuffer  	; decrypt the buffer
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
	mov	ecx,BUFMAX		; maximum character count
	mov	edx,OFFSET buffer   ; point to the buffer
	call	ReadString         	; input the string
	mov	bufSize,eax        	; save the length
	call	Crlf
	popad
	ret
InputTheString ENDP

InputKey PROC
;
; Prompts user for a plaintext string. Saves the string 
; and its length.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	edx,OFFSET ePrompt	; display a prompt
	call	WriteString
	mov	ecx,BUFMAX		; maximum character count
	mov	edx,OFFSET keyBuf   ; point to the buffer
	call	ReadString         	; input the string
	mov	keySize,eax        	; save the length
	call	Crlf
	popad
	ret
InputKey ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Displays the encrypted or decrypted message.
; Receives: EDX points to the message
; Returns:  nothing
;-----------------------------------------------------
	pushad
	call	WriteString
	mov	edx,OFFSET buffer	; display the buffer
	call	WriteString
	call	Crlf
	call	Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each
; byte with the encryption key byte.
; Receives: nothing
; Returns: nothing
;-----------------------------------------------------
	pushad
	mov	esi,0			; index 0 in buffer
	mov	ecx,bufSize; loop counter
L1:
	mov ebx, keySize
	mov	eax, ecx
	cmp eax, ebx
	jl	LastLoop	;finishes XOR-ing with last portion of user string

	push ecx
	mov edi,0
	mov ecx, keySize
L2:
	mov al, keyBuf[edi]
	xor	buffer[esi], al	; translate a byte
	inc	esi				; point to next byte
	inc edi
	loop	L2

	pop ecx
	mov ebx, keySize
	mov	eax, ecx
	cmp eax, ebx

	jge  SubKey		;subtracts keySize from ecx

	;return to L1 after using Subkey
ReLoop:

	loop	L1

;jump over conditionals if L1 ends normally
	jmp Skipper

;subtract L2 runs from ECX
Subkey: 
	sub	ecx,keySize ;accounts for loop 2
	add ecx, 1		;accounts for loop 1 deincrementing ecx
	jmp ReLoop

;if ecx becomes <= keySize
LastLoop:
	cmp esi,bufSize
	jge Skipper
	mov edi, 0
L3:
	mov al, keyBuf[edi]
	xor	buffer[esi], al	; translate a byte
	inc	esi				; point to next byte
	inc edi
	loop L3

Skipper:

	popad
	ret
TranslateBuffer ENDP
END main