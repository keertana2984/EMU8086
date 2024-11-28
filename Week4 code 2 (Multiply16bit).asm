.model small
.stack 100h

.data
    num1 dw 1234h       ; Define `num1` as a 16-bit word (4660 in decimal).
    num2 dw 0002h       ; Define `num2` as a 16-bit word (2 in decimal).
    buffer db 12 dup('$') ; Buffer to store the result string, max 10 digits + '$'.

.code
main:
    mov ax, @data       ; Initialize data segment.
    mov ds, ax

    mov ax, num1        ; Load `num1` into AX.
    mov bx, num2        ; Load `num2` into BX.
    mul bx              ; Multiply AX by BX, result in DX:AX.

    ; Convert DX:AX to string and store in buffer
    lea si, buffer+11   ; Point SI to the end of the buffer (before '$').
    mov byte ptr [si], '$' ; Place string terminator.
    
convert_to_string:
    dec si              ; Move to the next position in the buffer.
    xor dx, dx          ; Clear DX for division.
    mov bx, 10          ; Divisor for decimal conversion.
    div bx              ; DX:AX = DX:AX / 10, remainder in DL.
    add dl, '0'         ; Convert remainder to ASCII.
    mov [si], dl        ; Store ASCII character in buffer.
    cmp ax, 0           ; Check if quotient is 0.
    jne convert_to_string ; Repeat if not.

    ; Display the result
    lea dx, [si]        ; Point DX to the start of the string.
    mov ah, 09h         ; DOS interrupt 09h to display string.
    int 21h

    ; Exit program
    mov ah, 4ch         ; DOS interrupt to terminate.
    int 21h

end main
