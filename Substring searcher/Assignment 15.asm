;Nicolas Jorgensen
INCLUDE Irvine32.inc

Str_find PROTO, 
pTarget: PTR BYTE, 
pSource:PTR BYTE

.data
mess1 BYTE "The target string is: ", 0
mess2 BYTE "The source string is: ", 0
mess3 BYTE "Source string found at position ", 0
mess4 BYTE " in Target string (counting from zero).", 0
source1 Byte "AAABA", 0
target1 BYTE "01ABAAAAAABABCC45ABC9012", 0
target BYTE "123ABC342432",0
source BYTE "ABC",0
.code
main PROC
INVOKE Str_find, ADDR target1, ADDR source1                                 
mov edx, OFFSET mess1
call Writestring
mov edx, OFFSET target1
call WriteString
call Crlf
mov edx, OFFSET mess2
call Writestring
mov edx, OFFSET source1
call Writestring
call crlf
call crlf
mov edx, Offset mess3
call Writestring
call writeDec
mov edx, OFFSET mess4
call writestring
call crlf
call crlf
call waitmsg


    exit
main ENDP

Str_find PROC USES ebx ecx esi edi,
pTarget: PTR BYTE, 
pSource:PTR BYTE
LOCAL Sor_len:DWORD, Tar_len:DWORD

INVOKE Str_length, pSource          ;loading lengths to local variables
mov Sor_len, eax
INVOKE Str_length, pTarget
mov Tar_len, eax

mov eax, 0                          ;eax now used for location of source in target
mov ecx,Tar_len
inc ecx
sub ecx,Sor_len                     ; ecx = tarlen - sorlen +1
mov esi, pSource
mov edi, pTarget
L1:
    CMPSB                        
    Je Equal
      
    dec esi
    loop L1
    Jmp NotFound

Equal:
    push ECX
    mov ecx, Sor_len
    dec ecx
    push edi
    Repe CMPSB
    
    je Found
    pop edi
    pop ecx
    mov esi, pSource
    loop L1
NotFound:
    mov eax, 1
    add eax, 99                      ;ZF=0
    mov eax, 0
    jmp Done

Found:  
        mov eax, edi
        sub eax, ptarget
        sub eax, sor_len
        pop ecx
        pop ecx
        cmp EAX, EAX

Done:

ret
Str_find ENDP

END main