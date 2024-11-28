ORG 100h  ; Set origin for COM file

BUFFER_SIZE EQU 50 ; Define maximum buffer size

; Data Section
BUFFER DB BUFFER_SIZE, 0  ; First byte: buffer size, second: initial count
       TIMES BUFFER_SIZE DUP(0) ; Reserve space for input

START:
    ; Input a string
    MOV AH, 0Ah          ; DOS function: buffered input
    LEA DX, BUFFER       ; Load address of buffer into DX
    INT 21h              ; Call DOS interrupt

    ; Add '$' at the end of the input string
    LEA SI, BUFFER       ; Load address of BUFFER into SI
    MOV CL, [SI + 1]     ; Get the count of characters entered
    ADD SI, CX           ; Move SI to the end of the input string
    MOV BYTE PTR [SI + 2], '$' ; Add '$' to terminate the string

    ; Print a new line
    MOV AH, 02h
    MOV DL, 0Ah          ; Line feed (LF)
    INT 21h
    MOV DL, 0Dh          ; Carriage return (CR)
    INT 21h

    ; Output the string
    MOV AH, 09h          ; DOS function: display string
    LEA DX, BUFFER + 2   ; Skip the first two bytes (size and count)
    INT 21h              ; Call DOS interrupt

    ; Terminate program
    MOV AH, 4Ch          ; DOS function: terminate program
    INT 21h
