.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_MSG DB 'Enter a two-digit number: $' ; Prompt message for user input
    RESULT_MSG DB 0DH, 0AH, 'The number you entered is: $' ; Message to display the result
    ERROR_MSG DB 0DH, 0AH, 'Invalid input! Please enter two digits only.$' ; Error message
    NEWLINE DB 0DH, 0AH, '$' ; Newline for clean formatting
    NUM DB ?, ?              ; Storage for the two-digit number

.CODE
MAIN PROC
    ; Initialize the data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display the prompt message
    LEA DX, PROMPT_MSG
    MOV AH, 09H
    INT 21H

    ; Read the first digit
    MOV AH, 01H         ; Function to take single character input
    INT 21H
    CMP AL, '0'         ; Validate input: Check if AL >= '0'
    JB INVALID
    CMP AL, '9'         ; Validate input: Check if AL <= '9'
    JA INVALID
    SUB AL, '0'         ; Convert ASCII to numeric value
    MOV NUM, AL         ; Store first digit in NUM

    ; Read the second digit
    MOV AH, 01H         ; Function to take single character input
    INT 21H
    CMP AL, '0'         ; Validate input: Check if AL >= '0'
    JB INVALID
    CMP AL, '9'         ; Validate input: Check if AL <= '9'
    JA INVALID
    SUB AL, '0'         ; Convert ASCII to numeric value
    MOV NUM+1, AL       ; Store second digit in NUM+1

    ; Display the result message
    LEA DX, RESULT_MSG
    MOV AH, 09H
    INT 21H

    ; Display the first digit
    MOV DL, NUM         ; Load the first digit
    ADD DL, '0'         ; Convert to ASCII
    MOV AH, 02H         ; Function to display a character
    INT 21H

    ; Display the second digit
    MOV DL, NUM+1       ; Load the second digit
    ADD DL, '0'         ; Convert to ASCII
    MOV AH, 02H         ; Function to display a character
    INT 21H

    ; Add a newline for better formatting
    LEA DX, NEWLINE
    MOV AH, 09H
    INT 21H

    ; Exit the program
    JMP EXIT

INVALID:
    ; Display error message for invalid input
    LEA DX, ERROR_MSG
    MOV AH, 09H
    INT 21H

EXIT:
    ; Terminate the program
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
