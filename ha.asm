; Braydon Bieber
; WSUID: removed

.586
.MODEL FLAT

INCLUDE io.h			

.STACK 4096

.DATA
var_a     DWORD    ?
var_b     DWORD    ?
inptmsg1   BYTE    "Enter a number (unsigned)", 0
inptmsg2   BYTE    "Enter another number (unsigned)", 0
cstr_buff  BYTE    40 DUP (?)
GCD_LABEL  BYTE    "The GCD is ", 0
gcd        BYTE    11 DUP (?), 0

.CODE
_MainProc PROC
	input   inptmsg1, cstr_buff, 40
	atod    cstr_buff		
	mov     var_a, eax		

	input   inptmsg2, cstr_buff, 40	
	atod    cstr_buff
	mov     var_b, eax     
	
	push	var_b
	push	var_a
	call	_GcdProc	; cdecl	- relatively, expectations were listed in description of home assignment 
	add		esp, 8			; cleaning the stack
	dtoa	gcd, eax	 ; cdecl normally returns a value or part of memory using this register (EAX)
	output	GCD_LABEL, gcd
	xor		eax, eax	; Setting Eax to 0
	ret

_MainProc ENDP

_GcdProc PROC 

; if (a > b > 0)
;-----------------------------------------
	push	ebp 
	mov		ebp, esp
	mov		eax, DWORD PTR [ebp+8]
	cmp		eax, DWORD PTR [ebp+12]
	jna		less_than
	cmp		DWORD PTR [ebp+12], 0
	jna		less_than
	mov		eax, DWORD PTR [ebp+12]
	push	eax
	mov		eax, DWORD PTR [ebp+8]
	sub		eax, DWORD PTR [ebp+12]
	push	eax
	call	_GcdProc
	add		esp, 8
	jmp		end_of
;-----------------------------------------
less_than: ; the only other if statement in the pseudocode 0 < a < b
	cmp		DWORD PTR [ebp+8], 0
	jnae		return_a
	mov		eax, DWORD PTR [ebp+8]
	cmp		eax, DWORD PTR [ebp+12]
	jnb		return_a
	mov		eax, DWORD PTR [ebp+12]
	sub		eax, DWORD PTR [ebp+8]
	push	eax
	mov		eax, DWORD PTR [ebp+8]
	push 	eax
	call	_GcdProc
	add		esp, 8
	jmp		end_of
return_a:
	mov		eax, DWORD PTR [ebp+8]
end_of:
	pop		ebp
	ret
_GcdProc ENDP
	

END					




