.model small
.stack 100h

.data
    result_msg db 'The result is: $'  ; Message to display the result
    newline db 0Dh, 0Ah, '$'          ; Newline for proper formatting

.code
main:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Add two hardcoded single-digit numbers
    mov al, 4       ; First number
    add al, 3       ; Add second number (AL = 4 + 3)

    ; Convert result to ASCII
    ; If the result is a single digit, print it directly
    cmp al, 10      ; Check if result is less than 10
    jl single_digit ; If less than 10, jump to print a single digit

    ; For results >= 10, split into tens and ones
    mov bl, 10      ; Divisor for splitting digits
    xor ah, ah      ; Clear AH for division
    div bl          ; AL / 10: Quotient in AL (tens), Remainder in AH (ones)

    ; Print the tens digit
    add al, '0'     ; Convert to ASCII
    mov dl, al      ; Move to DL for printing
    mov ah, 02h     ; Print character function
    int 21h

    ; Print the ones digit
    mov al, ah      ; Move remainder (ones) to AL
    add al, '0'     ; Convert to ASCII
    mov dl, al      ; Move to DL for printing
    mov ah, 02h     ; Print character function
    int 21h

    jmp print_done  ; Skip the single-digit print section

single_digit:
    ; Print the single-digit result
    add al, '0'     ; Convert to ASCII
    mov dl, al      ; Move to DL for printing
    mov ah, 02h     ; Print character function
    int 21h

print_done:
    ; Print a newline for formatting
    lea dx, newline
    mov ah, 09h
    int 21h

    ; Exit program
    mov ah, 4Ch
    int 21h

end main
