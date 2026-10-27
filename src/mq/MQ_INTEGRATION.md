# MQ Series — evento de alteração de limite

Fila lógica: `GBANK.LIMIT.EVENT.Q`.

Mensagem:

```json
{"event":"LIMIT_UPDATED","agency":"1234","account":"0000123456","correlationId":"..."}
```

## Decisões

- MQPUT deve respeitar a estratégia transacional definida para CICS/DB2.
- Em falha, distinguir retry técnico de rejeição funcional.
- Usar correlation ID para rastreabilidade.
- Configurar DLQ/backout conforme padrões do ambiente.
- Evitar duplicidade no consumidor com idempotência.
