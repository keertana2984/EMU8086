.model small
.stack 100h

.data
    dividend dw 1234h   ; Define the 16-bit dividend (4660 in decimal).
    divisor dw 0002h    ; Define the 16-bit divisor (2 in decimal).
    buffer db 12 dup('$') ; Buffer to store the result string, max 10 digits + '$'.

.code
main:
    mov ax, @data       ; Initialize data segment.
    mov ds, ax

    mov ax, dividend    ; Load the dividend into AX.
    mov bx, divisor     ; Load the divisor into BX.
    xor dx, dx          ; Clear DX for division.
    div bx              ; Divide DX:AX by BX, result in AX (quotient).

    ; Convert the quotient in AX to string and store in buffer
    lea si, buffer+11   ; Point SI to the end of the buffer (before '$').
    mov byte ptr [si], '$' ; Place string terminator.

convert_to_string:
    dec si              ; Move to the next position in the buffer.
    xor dx, dx          ; Clear DX for division.
    mov bx, 10          ; Divisor for decimal conversion.
    div bx              ; DX:AX = AX / 10, remainder in DX.
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
