.model small
.stack 100h
.data
    num1 db 20h         ; Define `num1` as a byte with the value `20h` (32 in decimal).
    num2 db 04h         ; Define `num2` as a byte with the value `04h` (4 in decimal).
    res dw ?            ; Define `res` as a word to store the result of the multiplication.
    buffer db 6 dup('$') ; Buffer to store the result string, max 5 digits + '$' (end marker).
.code
main:
    mov ax, @data       ; Load the segment address of the data segment into AX.
    mov ds, ax          ; Move the address from AX to the DS register,
                        ; setting up DS to point to the data segment.

    mov al, num1        ; Load the value of `num1` into AL (lower byte of AX).
    mov bl, num2        ; Load the value of `num2` into BL.
    mul bl              ; Multiply AL by BL. The result is stored in AX.

    mov res, ax         ; Store the result from AX into the `res` variable.

    ; Convert the result to a string
    lea si, buffer      ; Load the address of the buffer into SI.
    mov cx, 0           ; CX will count the number of digits.

convert_to_string:
    mov dx, 0           ; Clear DX for the division.
    mov bx, 10          ; Divisor (10 for decimal).
    div bx              ; AX = AX / 10, remainder in DX.
    add dl, '0'         ; Convert remainder to ASCII.
    dec si              ; Move SI back to store the digit.
    mov [si], dl        ; Store the digit in the buffer.
    inc cx              ; Increment the digit count.
    test ax, ax         ; Check if the quotient is 0.
    jnz convert_to_string ; Repeat if quotient is not zero.

    ; Display the result
    lea dx, [si]        ; Load the address of the string into DX.
    mov ah, 09h         ; DOS interrupt 09h to display a string.
    int 21h             ; Display the string.

    ; Exit the program
    mov ah, 4ch         ; Set AH to 4Ch, the DOS function to terminate the program.
    int 21h             ; Call DOS interrupt 21h to exit the program.

end main                ; End of the program, label "main" marks the entry point.