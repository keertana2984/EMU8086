.MODEL SMALL
.STACK 100H

.DATA
    msg1 DB 'Enter first number: $'          ; Prompt message for the first number
    msg2 DB 10, 13, 'Enter second number: $' ; Prompt message for the second number (with newline and carriage return)
    equal_msg DB 10, 13, 'Numbers are equal$' ; Message to display if numbers are equal
    not_equal_msg DB 10, 13, 'Numbers are not equal$' ; Message to display if numbers are not equal

.CODE
MAIN PROC
    ; Initialize the data segment
    MOV AX, @DATA     ; Load the address of the data segment
    MOV DS, AX        ; Set DS to point to the data segment

    ; Prompt the user to enter the first number
    LEA DX, msg1      ; Load the address of the first prompt message
    MOV AH, 09H       ; DOS function to display a string
    INT 21H           ; Call DOS interrupt to display the message

    ; Take the first number as input
    MOV AH, 01H       ; DOS function to take single character input
    INT 21H           ; Call DOS interrupt to take the input
    SUB AL, 30H       ; Convert ASCII to integer by subtracting ASCII offset ('0' = 30H)
    MOV BL, AL        ; Store the first number in BL register

    ; Prompt the user to enter the second number
    LEA DX, msg2      ; Load the address of the second prompt message
    MOV AH, 09H       ; DOS function to display a string
    INT 21H           ; Call DOS interrupt to display the message

    ; Take the second number as input
    MOV AH, 01H       ; DOS function to take single character input
    INT 21H           ; Call DOS interrupt to take the input
    SUB AL, 30H       ; Convert ASCII to integer by subtracting ASCII offset ('0' = 30H)

    ; Compare the two numbers
    CMP AL, BL        ; Compare the second number (in AL) with the first number (in BL)
    JE EQUAL          ; If the numbers are equal, jump to the EQUAL label

    ; If numbers are not equal
    LEA DX, not_equal_msg ; Load the address of the "not equal" message
    JMP DISPLAY       ; Jump to DISPLAY to print the message

EQUAL:
    ; If numbers are equal
    LEA DX, equal_msg ; Load the address of the "equal" message

DISPLAY:
    ; Display the result message
    MOV AH, 09H       ; DOS function to display a string
    INT 21H           ; Call DOS interrupt to display the message

    ; Exit the program
    MOV AH, 4CH       ; DOS function to terminate the program
    INT 21H           ; Call DOS interrupt to terminate

MAIN ENDP
END MAIN
