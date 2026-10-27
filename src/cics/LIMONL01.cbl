       IDENTIFICATION DIVISION.
       PROGRAM-ID. LIMONL01.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-AGENCY        PIC X(4).
       01 WS-ACCOUNT       PIC X(10).
       01 WS-NEW-LIMIT     PIC S9(13)V99 COMP-3.
       01 WS-OLD-LIMIT     PIC S9(13)V99 COMP-3.
       01 WS-SQLCODE       PIC S9(9) COMP.
       01 WS-MESSAGE       PIC X(70).
       01 WS-MQ-AVAILABLE  PIC X VALUE 'Y'.

       PROCEDURE DIVISION.
       MAIN-LOGIC.
      * In a real CICS program the fields would normally come from
      * RECEIVE MAP / COMMAREA / CHANNEL-CONTAINER.
           IF WS-AGENCY = SPACES OR WS-ACCOUNT = SPACES
               MOVE 'INVALID INPUT' TO WS-MESSAGE
               GO TO RETURN-TO-CICS
           END-IF

           EXEC SQL
             SELECT DAILY_LIMIT
               INTO :WS-OLD-LIMIT
               FROM ACCOUNT_LIMIT
              WHERE AGENCY_CODE = :WS-AGENCY
                AND ACCOUNT_NO  = :WS-ACCOUNT
           END-EXEC

           MOVE SQLCODE TO WS-SQLCODE
           EVALUATE WS-SQLCODE
             WHEN 0
                CONTINUE
             WHEN 100
                MOVE 'ACCOUNT NOT FOUND' TO WS-MESSAGE
                GO TO RETURN-TO-CICS
             WHEN -911
                MOVE 'DB2 DEADLOCK/TIMEOUT - RETRY POLICY' TO WS-MESSAGE
                GO TO RETURN-TO-CICS
             WHEN -913
                MOVE 'DB2 RESOURCE UNAVAILABLE - CHECK UOW' TO WS-MESSAGE
                GO TO RETURN-TO-CICS
             WHEN OTHER
                MOVE 'DB2 ERROR - SEE LOG' TO WS-MESSAGE
                GO TO RETURN-TO-CICS
           END-EVALUATE

           EXEC SQL
             UPDATE ACCOUNT_LIMIT
                SET DAILY_LIMIT = :WS-NEW-LIMIT,
                    VERSION_NO  = VERSION_NO + 1,
                    UPDATED_AT  = CURRENT TIMESTAMP
              WHERE AGENCY_CODE = :WS-AGENCY
                AND ACCOUNT_NO  = :WS-ACCOUNT
           END-EXEC

           IF SQLCODE NOT = 0
               EXEC CICS SYNCPOINT ROLLBACK END-EXEC
               MOVE 'UPDATE FAILED - ROLLBACK' TO WS-MESSAGE
               GO TO RETURN-TO-CICS
           END-IF

      * MQ publish would be implemented with MQPUT under the intended UOW.
      * The actual syncpoint semantics must be validated for the environment.
           IF WS-MQ-AVAILABLE = 'Y'
               MOVE 'LIMIT UPDATED' TO WS-MESSAGE
           ELSE
               EXEC CICS SYNCPOINT ROLLBACK END-EXEC
               MOVE 'MQ FAILURE - ROLLBACK' TO WS-MESSAGE
               GO TO RETURN-TO-CICS
           END-IF

           EXEC CICS SYNCPOINT END-EXEC

       RETURN-TO-CICS.
           EXEC CICS RETURN END-EXEC.
