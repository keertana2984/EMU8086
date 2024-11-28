.MODEL SMALL              ; Define the memory model as SMALL (single code and data segment)
.STACK 100h               ; Define stack size of 256 bytes

.DATA
    msg db 'Z', 0         ; Define a data variable 'msg' with initial value 'Z' and a null terminator

.CODE
main PROC
    ; Initialize the data segment
    mov ax, @data         ; Load the address of the data segment into AX
    mov ds, ax            ; Set the data segment register DS to the value in AX

    ; Set up loop parameters
    mov cx, 26            ; Set CX to 26 (for 26 letters in the alphabet)
    mov dl, 'Z'           ; Load DL with the ASCII value of 'Z' (starting letter)

reverse_print:
    ; Print the current character in DL
    mov ah, 2             ; DOS function to display a character in DL
    int 21h               ; Call DOS interrupt to display the character

    dec dl                ; Decrement DL to move to the previous character ('Z' to 'Y' and so on)
    loop reverse_print    ; Decrement CX and loop if CX is not zero (print next character in reverse order)

    ; Exit the program
    mov ah, 4Ch           ; DOS function to terminate the program
    int 21h               ; Call DOS interrupt to terminate

main ENDP
END main
