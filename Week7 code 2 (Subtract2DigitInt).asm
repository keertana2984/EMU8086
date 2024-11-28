.model small
.stack 100h

.data
    result_msg db 'The result is: $'  ; Message to display the result
    newline db 0x0D, 0x0A, '$'        ; Newline

.code
main:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Subtract two hardcoded 2-digit numbers
    mov ax, 45       ; First number
    mov bx, 23       ; Second number
    sub ax, bx       ; Perform subtraction (AX = 45 - 23)

    ; Display result message
    mov ah, 09h
    lea dx, result_msg
    int 21h

    ; Convert the result to ASCII and print each digit
    mov bx, 10       ; Set divisor to 10
    xor dx, dx       ; Clear DX (necessary for division)
    div bx           ; AX / 10 -> quotient in AL, remainder in AH

    ; Print the tens digit (quotient in AL)
    add al, '0'      ; Convert to ASCII
    mov dl, al
    mov ah, 02h
    int 21h

    ; Print the ones digit (remainder in AH)
    add ah, '0'      ; Convert remainder to ASCII
    mov dl, ah
    mov ah, 02h
    int 21h

    ; Print newline after the result
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit the program
    mov ah, 4Ch
    int 21h

end main
