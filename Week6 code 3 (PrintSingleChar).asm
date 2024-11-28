; Program to read a single character from the user and print it back
ORG 100h  ; Set origin for COM file

MOV AH, 01h      ; Function to read a character from the keyboard
INT 21h          ; Call DOS interrupt
MOV DL, AL       ; Store the input character in DL
MOV AH, 02h      ; Function to display a character
INT 21h          ; Call DOS interrupt

MOV AH, 4Ch      ; Function to terminate the program
INT 21h          ; Call DOS interrupt
