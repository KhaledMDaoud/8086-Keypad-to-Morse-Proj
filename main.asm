.MODEL SMALL
.STACK 128

PORTA EQU 10h
PORTB EQU 12h
PORTC EQU 14h
CTRL  EQU 16h

.DATA
display_0 db 0BFh
display_1 db 06h
display_2 db 5Bh
display_3 db 4Fh
display_4 db 66h
display_5 db 6Dh
display_6 db 7Dh
display_7 db 07h
display_8 db 0FFh
display_9 db 0EFh
morse_0 db 3h,3h,3h,3h,3h
morse_1 db 1h,3h,3h,3h,3h
morse_2 db 1h,1h,3h,3h,3h
morse_3 db 1h,1h,1h,3h,3h
morse_4 db 1h,1h,1h,1h,3h
morse_5 db 1h,1h,1h,1h,1h
morse_6 db 3h,1h,1h,1h,1h
morse_7 db 3h,3h,1h,1h,1h
morse_8 db 3h,3h,3h,1h,1h
morse_9 db 3h,3h,3h,3h,1h
morse_SOS db 1h,1h,1h,3h,3h,3h,1h,1h,1h
last_len db 0
last_morse dw 0
last_disp dw 0

.CODE
walking0 PROC
    mov dx,PORTC
    mov al,0E0h
    out dx,al
    
    in al,dx
    and al,0Fh
    cmp al,0Fh
    jne row1
    
    mov al,0D0h
    out dx,al
    in al,dx
    and al,0Fh
    cmp al,0Fh
    jne row2
    
    mov al,0B0h
    out dx,al
    in al,dx
    and al,0Fh
    cmp al,0Fh
    jne row3
    
    mov al,70h
    out dx,al
    in al,dx
    and al,0Fh
    cmp al,0Fh
    jne row4
    mov al,0FFh
    ret
row1:
    mov al,01h
    ret
row2:
    mov al,02h
    ret
row3:
    mov al,03h
    ret
row4:
    mov al,04h
    ret
walking0 ENDP

printmorse PROC
   outerlp:
    push cx
    mov cl,[si]
    mov al,01h
    out dx,al
innerlp:
    call delay
    loop innerlp
    xor al,al
    out dx,al
    call delay
    pop cx
    inc si
    loop outerlp
    xor ax,ax
    mov dx,PORTA
    out dx,al
    call delay
    ret
printmorse ENDP

debounce PROC
dbloop:
     in al,PORTC
     and al,0Fh
     cmp al,0Fh
     JE dbend
     jmp dbloop
dbend:
     ret
debounce ENDP

START:
    mov ax, @data
    mov ds, ax

    mov dx, CTRL
    mov al, 81h
    out dx, al
main_loop:
    call debounce
    mov al,00h
    out PORTC, al
readkey:
    in al,PORTC
    and al,0Fh
    cmp al,0Eh
    JE col1
    cmp al,0Dh
    JE col2
    cmp al,0Bh
    JE col3
    jmp readkey
col1:
    call walking0
    cmp al,01h
    JE print1
    cmp al,02h
    JE print4
    cmp al,03h
    JE print7
    cmp al,04h
    JE replay
    jmp readkey
col2:
    call walking0
    cmp al,01h
    JE print2
    cmp al,02h
    JE print5
    cmp al,03h
    JE print8
    cmp al,04h
    JE print0
    jmp readkey
col3:
    call walking0
    cmp al,01h
    JE print3
    cmp al,02h
    JE print6
    cmp al,03h
    JE print9
    cmp al,04h
    JE printSOS
    jmp readkey
print0:
    mov dx,PORTA
    lea si,display_0
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_0
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print1:
    mov dx,PORTA
    lea si,display_1
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_1
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print2:
    mov dx,PORTA
    lea si,display_2
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_2
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print3:
    mov dx,PORTA
    lea si,display_3
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_3
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print4:
    mov dx,PORTA
    lea si,display_4
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_4
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print5:
    mov dx,PORTA
    lea si,display_5
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_5
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print6:
    mov dx,PORTA
    lea si,display_6
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_6
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print7:
    mov dx,PORTA
    lea si,display_7
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_7
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print8:
    mov dx,PORTA
    lea si,display_8
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_8
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
print9:
    mov dx,PORTA
    lea si,display_9
    lea di,last_disp
    mov [di],si
    mov al,[si]
    out dx,al
    xor cx,cx
    mov cx,5h
    lea di,last_len
    mov [di],cl
    lea si,morse_9
    lea di,last_morse
    mov [di],si
    mov dx,PORTB
    call printmorse
    jmp main_loop
replay:
    lea di,last_len
    mov al,[di]
    cmp al,0
    JE main_loop
    cmp al,09h
    JE printSOS
    xor cx,cx
    mov cl,al
    lea di,last_disp
    mov si,[di]
    mov al,[si]
    out PORTA,al
    lea di,last_morse
    mov si,[di]
    mov dx,PORTB
    call printmorse
    jmp main_loop
printSOS:
    lea di,last_len
    xor cx,cx
    mov cx,9h
    mov [di],cl
    lea si,morse_SOS
    mov dx,PORTB
    call printmorse
    jmp main_loop

delay PROC
    push cx
    mov  cx, 15000
INNER:
    loop INNER
    pop cx
    ret
delay ENDP

END START
