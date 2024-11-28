.model small
.stack 100h

.data
    dividend db 50h     ; Define the dividend as a byte (80 in decimal).
    divisor db 04h      ; Define the divisor as a byte (4 in decimal).
    buffer db 6 dup('$') ; Buffer to store the result string, max 5 digits + '$'.

.code
main:
    mov ax, @data       ; Initialize data segment.
    mov ds, ax

    mov al, dividend    ; Load the dividend into AL.
    mov bl, divisor     ; Load the divisor into BL.
    div bl              ; Divide AL by BL, result in AL (quotient), remainder in AH.

    ; Convert the quotient in AL to string and store in buffer
    lea si, buffer+5    ; Point SI to the end of the buffer (before '$').
    mov byte ptr [si], '$' ; Place string terminator.

convert_to_string:
    dec si              ; Move to the next position in the buffer.
    xor ah, ah          ; Clear AH for division.
    mov bl, 10          ; Divisor for decimal conversion.
    div bl              ; AL = AL / 10, remainder in AH.
    add ah, '0'         ; Convert remainder to ASCII.
    mov [si], ah        ; Store ASCII character in buffer.
    cmp al, 0           ; Check if quotient is 0.
    jne convert_to_string ; Repeat if not.

    ; Display the result
    lea dx, [si]        ; Point DX to the start of the string.
    mov ah, 09h         ; DOS interrupt 09h to display string.
    int 21h

    ; Exit program
    mov ah, 4ch         ; DOS interrupt to terminate.
    int 21h

end main
