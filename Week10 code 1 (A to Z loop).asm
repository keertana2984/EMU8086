.MODEL SMALL              ; Define the memory model as SMALL (single code and data segment)
.STACK 100h               ; Define stack size of 256 bytes

.DATA
    msg db 'A', 0         ; Define a data variable 'msg' with initial value 'A' and a null terminator

.CODE
main PROC
    ; Initialize the data segment
    mov ax, @data         ; Load the address of the data segment into AX
    mov ds, ax            ; Set the data segment register DS to the value in AX

    ; Set up loop parameters
    mov cx, 26            ; Set CX to 26 (for 26 letters in the alphabet)
    mov dl, 'A'           ; Load DL with the ASCII value of 'A' (starting letter)

alphabet_print:
    ; Print the current character in DL
    mov ah, 2             ; DOS function to display a character in DL
    int 21h               ; Call DOS interrupt to display the character

    inc dl                ; Increment DL to move to the next character ('A' to 'B' and so on)
    loop alphabet_print   ; Decrement CX and loop if CX is not zero (print next character)

    ; Exit the program
    mov ah, 4Ch           ; DOS function to terminate the program
    int 21h               ; Call DOS interrupt to terminate

main ENDP
END main
