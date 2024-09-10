;Nicolas Jorgensen
INCLUDE Irvine32.inc
INCLUDE macros.inc

GDC Proto
.data
mess1 BYTE "Greatest common divisor of ", 0
mess2 BYTE " and ", 0
mess3 BYTE " is: ", 0
.code
main PROC

push 35
push 15
call GCD
call printGCD
push 72
push 18
call GCD
call printGCD
push 31
push 17
call GCD
call printGCD
push 128
push 640
call GCD
call printGCD
push 121
push 0
call GCD 
call printGCD
    exit
main ENDP


;returns the gcd in ebx, a in edi, b in esi
GCD PROC
push ebp            ;doing base pointer process
mov ebp, esp
push edx

mov eax, DWORD PTR [ebp + 12] ;a
mov ebx, DWORD PTR [ebp + 8]  ;b

cmp eax, ebx
jb aBelow           ;if a<b
jmp aBig
aBelow:             ;swap a and b
mov eax, DWORD PTR [ebp + 8]
mov ebx, DWORD PTR [ebp + 12]

aBig:

cmp ebx, 0
je bZero
jmp Euc         ;recursive block
bZero:
mov ebx, eax
jmp Done

Euc:
mov edx, 0
div ebx
cmp edx, 0
je Done
push ebx
push edx
call GCD
Done:

mov edi, DWORD PTR [ebp + 12] ;loading original operand to regs
mov esi, DWORD PTR [ebp + 8]
pop edx
pop ebp
ret 8
GCD ENDP

;printing procedure
printGCD PROC
mov edx, OFFSET mess1
call writestring
mov eax, edi
call writeDec
mov edx, OFFSET mess2
call writestring
mov eax, esi
call writeDec
mov edx, OFFSET mess3
call writestring
mov eax, ebx
call writeDec
call Crlf
ret
printGCD ENDP
END main