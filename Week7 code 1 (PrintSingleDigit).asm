.model small
.stack 100h

.data
    prompt db 'Enter a digit: $'  ; Prompt message
    input db 0                    ; Variable to store user input

.code
main:
    ; Initialize the data segment
    mov ax, @data
    mov ds, ax

    ; Display prompt message
    mov ah, 09h           ; DOS interrupt for printing a string
    lea dx, prompt        ; Load address of prompt into DX
    int 21h               ; Call DOS interrupt to print prompt

    ; Read a single character input
    mov ah, 01h           ; DOS interrupt to read a character from the keyboard
    int 21h               ; Call DOS interrupt to read the input
    mov [input], al       ; Store the input in the 'input' variable

    ; Print the entered digit
    mov ah, 02h           ; DOS interrupt for printing a single character
    mov dl, [input]       ; Load the input character into DL
    int 21h               ; Call DOS interrupt to print the character

    ; Exit program
    mov ah, 4Ch           ; DOS interrupt to terminate program
    int 21h

end main
