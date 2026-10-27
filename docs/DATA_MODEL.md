# Modelo de dados

Entidades principais:

- `CUSTOMER_ACCOUNT` — conta e estado operacional.
- `ACCOUNT_LIMIT` — limite corrente, versão e timestamp.
- `LIMIT_AUDIT` — trilha de auditoria.
- `BATCH_CHECKPOINT` — checkpoint lógico para retomada segura.

A coluna `VERSION_NO` permite discutir controle otimista. Índices são propostos para consultas online e batch sem assumir que todo índice é benéfico; o caminho de acesso deve ser validado por EXPLAIN e métricas.
