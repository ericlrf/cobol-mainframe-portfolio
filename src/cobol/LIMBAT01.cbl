       IDENTIFICATION DIVISION.
       PROGRAM-ID. LIMBAT01.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MOV-IN ASSIGN TO MOVIN.
           SELECT SETTLE-OUT ASSIGN TO SETOUT.
       DATA DIVISION.
       FILE SECTION.
       FD MOV-IN.
       01 MOV-REC.
          05 MOV-KEY         PIC X(20).
          05 MOV-AMOUNT      PIC S9(13)V99 COMP-3.
          05 MOV-STATUS      PIC X.
       FD SETTLE-OUT.
       01 SETTLE-REC         PIC X(120).
       WORKING-STORAGE SECTION.
       01 WS-EOF             PIC X VALUE 'N'.
       01 WS-READ            PIC 9(9) VALUE ZERO.
       01 WS-VALID           PIC 9(9) VALUE ZERO.
       01 WS-REJECT          PIC 9(9) VALUE ZERO.
       01 WS-TOTAL-IN        PIC S9(15)V99 COMP-3 VALUE ZERO.
       01 WS-TOTAL-OUT       PIC S9(15)V99 COMP-3 VALUE ZERO.

       PROCEDURE DIVISION.
           OPEN INPUT MOV-IN OUTPUT SETTLE-OUT
           PERFORM UNTIL WS-EOF = 'Y'
              READ MOV-IN
                 AT END MOVE 'Y' TO WS-EOF
                 NOT AT END
                    ADD 1 TO WS-READ
                    ADD MOV-AMOUNT TO WS-TOTAL-IN
                    IF MOV-STATUS = 'V'
                       ADD 1 TO WS-VALID
                       ADD MOV-AMOUNT TO WS-TOTAL-OUT
                       MOVE MOV-REC TO SETTLE-REC
                       WRITE SETTLE-REC
                    ELSE
                       ADD 1 TO WS-REJECT
                    END-IF
              END-READ
           END-PERFORM
           CLOSE MOV-IN SETTLE-OUT

           IF WS-READ NOT = WS-VALID + WS-REJECT
              MOVE 12 TO RETURN-CODE
           END-IF
           GOBACK.
