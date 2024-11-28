ORG 100h  ; Set origin for COM file

START:
    ; Input a single character
    MOV AH, 01h          ; DOS function: input a single character
    INT 21h              ; Call DOS interrupt
    MOV AL, AL           ; Store the input character in AL

    ; Convert to uppercase if it is lowercase
    CMP AL, 'a'          ; Check if input is >= 'a'
    JB PRINT             ; If less, it's not lowercase, skip conversion
    CMP AL, 'z'          ; Check if input is <= 'z'
    JA PRINT             ; If greater, it's not lowercase, skip conversion
    SUB AL, 20h          ; Convert to uppercase by subtracting 0x20

PRINT:
    ; Print the converted character
    MOV DL, AL           ; Move the (possibly converted) character to DL
    MOV AH, 02h          ; DOS function: print a character
    INT 21h              ; Call DOS interrupt

    ; Print a new line
    MOV DL, 0Dh          ; Carriage return
    INT 21h
    MOV DL, 0Ah          ; Line feed
    INT 21h

    ; Terminate program
    MOV AH, 4Ch          ; DOS function: terminate program
    INT 21h
