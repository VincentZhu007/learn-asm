;
; c05_mbr
;
; 16-bit asm program to print hello world.
;
; Init reg: cs=0xffff, other=0x0000
; Memery size: 1MB
; Memory map:
;
;  +                  RAM                  +                  ROM-BIOS
;  |                                       |                   |   |
;  +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
;  |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
;  +---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+---+
;  |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |   |
;  0   1   2   3   4   5   6   7   8   9   a   b   c   d   e   f  end
;

BOOTSEG equ 0x07c0
VRAMSEG	equ 0xb800
COLOR	equ 0x04

; Program starts here.
start:
	mov ax, BOOTSEG
	mov ds, ax
	mov ax, VRAMSEG
	mov es, ax

; Write string to the vga memory
	mov si, ascii
	xor di, di
pchar:
	mov al, [ds:si]
	mov ah, COLOR
	mov word [es:di], ax
	inc si
	inc di
	inc di
	cmp si, ascii+len
	jnz pchar

infi:
	jmp near infi

; Message stores here.
ascii	db 'hello world!'
len	equ $ - ascii

; Reserves some space
	times 510 - ($ - $$) db 0x00

; Set main boot sector signature.
mbr_sig:
	db 0x55, 0xaa
