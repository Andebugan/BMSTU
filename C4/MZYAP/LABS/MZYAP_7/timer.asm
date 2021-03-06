.MODEL TINY
.CODE
.186
ORG 100h
START PROC NEAR
    MOV AX, 351Ch
    INT 21h
    MOV WORD PTR OLD_INT1Ch, BX
    MOV WORD PTR OLD_INT1Ch + 2, ES

    MOV AX, 251Ch
    MOV DX, OFFSET INT1Ch_HANDLER
    INT 21h
    MOV AH, 1
    INT 21h

    MOV AX, 251Ch
    MOV DX, WORD PTR OLD_INT1Ch + 2
    MOV DS, DX
    MOV DX, WORD PTR CS:OLD_INT1Ch
    INT 21h
    RET
OLD_INT1Ch DD ?
START_POSITION DW 0
START ENDP

INT1Ch_HANDLER PROC FAR
    PUSHA
    PUSH ES
    PUSH DS

    PUSH CS
    POP DS

    MOV AH, 02h
    JC EXIT_HANDLER

    CALL BCD2ASC
    MOV BYTE PTR OUTPUT_LINE[16], AH
    MOV BYTE PTR OUTPUT_LINE[18], AL
    MOV CX, OUTPUT_LINE_L
    PUSH 0B800h
    POP ES
    MOV DI, WORD PTR START_POSITION
    MOV SI, OFFSET OUTPUT_LINE
    CLD
    REP MOVSB
    EXIT_HANDLER:
    POP DS
    POP ES
    POPA
    JMP CS:OLD_INT1Ch

BCD2ASC PROC NEAR
    MOV AH, AL
    AND AL, 0Fh
    SHR AH, 4
    OR AX, 3030h
    RET
BCD2ASC ENDP

OUTPUT_LINE DB ' ', 1Fh, '0', 1Fh, '0', 1Fh, 'h', 1Fh
            DB ' ', 1Fh, '0', 1Fh, '0', '1Fh', ':', 1Fh
            DB '0', 1Fh, '0', 1Fh, ' ', 1Fh
OUTPUT_LINE_L EQU $-OUTPUT_LINE
INT1Ch_HANDLER ENDP
END START