-- Consulta crítica online
SELECT DAILY_LIMIT, VERSION_NO
  FROM ACCOUNT_LIMIT
 WHERE AGENCY_CODE = ?
   AND ACCOUNT_NO = ?;

-- Perguntas de performance:
-- 1. O predicado usa a chave adequada?
-- 2. Houve mudança de cardinalidade/estatística?
-- 3. O caminho de acesso mudou?
-- 4. Existe lock wait/deadlock?
-- 5. O índice adicional reduz custo total ou apenas desloca custo para escrita?
-- Em z/OS real: executar EXPLAIN e analisar PLAN_TABLE/DSN_STATEMNT_TABLE.
