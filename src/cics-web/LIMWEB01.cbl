       IDENTIFICATION DIVISION.
       PROGRAM-ID. LIMWEB01.
      * Conceptual CICS Web program.
      * Real implementation would use EXEC CICS WEB RECEIVE/EXTRACT/SEND
      * and call a shared business-service program for DB2 access.
       PROCEDURE DIVISION.
           EXEC CICS WEB RECEIVE
                SERVERCONV(WS-TOKEN)
                INTO(WS-REQUEST)
                LENGTH(WS-LENGTH)
           END-EXEC
      * Parse request, validate, call domain service, serialize JSON.
           EXEC CICS WEB SEND
                SERVERCONV(WS-TOKEN)
                FROM(WS-RESPONSE)
                FROMLENGTH(WS-RESP-LEN)
                MEDIATYPE('application/json')
                STATUSCODE(200)
           END-EXEC
           EXEC CICS RETURN END-EXEC.
