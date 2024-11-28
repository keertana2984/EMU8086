.MODEL SMALL           ; Specify the memory model: small (single code and data segment)
.STACK 100H            ; Reserve 256 bytes for the stack

.DATA
    prompt DB 'Enter a number: $'         ; Prompt message for the user to enter a number
    even_msg DB 10, 13, 'Number is Even$' ; Message to display if the number is even
    odd_msg DB 10, 13, 'Number is Odd$'   ; Message to display if the number is odd

.CODE
MAIN PROC
    ; Initialize the data segment
    MOV AX, @DATA       ; Load the starting address of the data segment
    MOV DS, AX          ; Set the data segment register (DS) to this address

    ; Display the prompt message
    LEA DX, prompt      ; Load the address of the prompt message into DX
    MOV AH, 09H         ; DOS function to display a string
    INT 21H             ; Call DOS interrupt to display the message

    ; Take a single-digit number as input
    MOV AH, 01H         ; DOS function to take a single character input
    INT 21H             ; Call DOS interrupt to take input
    SUB AL, 30H         ; Convert the ASCII input (e.g., '3') to its numeric value (3)

    ; Prepare for division by 2
    MOV AH, 00H         ; Clear AH to ensure no garbage value affects the division
    MOV BL, 2           ; Load the divisor (2) into BL
    DIV BL              ; Divide AL by BL; Quotient is in AL, remainder in AH

    ; Check if the remainder (AH) is 0 (indicating an even number)
    CMP AH, 0           ; Compare the remainder (AH) with 0
    JE EVEN             ; If AH = 0, jump to the EVEN label

    ; If the number is odd
    LEA DX, odd_msg     ; Load the address of the "odd" message into DX
    JMP DISPLAY         ; Jump to the DISPLAY label to show the message

EVEN:
    ; If the number is even
    LEA DX, even_msg    ; Load the address of the "even" message into DX

DISPLAY:
    ; Display the result message
    MOV AH, 09H         ; DOS function to display a string
    INT 21H             ; Call DOS interrupt to display the message

    ; Exit the program
    MOV AH, 4CH         ; DOS function to terminate the program
    INT 21H             ; Call DOS interrupt to terminate

MAIN ENDP
END MAIN
