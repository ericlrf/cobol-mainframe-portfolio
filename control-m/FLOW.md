# Control-M — cadeia diária

```text
WAIT_INPUT
   |
SORT_MOVEMENTS
   |
LIMIT_BATCH
   |------ on RC > 4 --> HOLD + alert
   |
RECONCILE_TOTALS
   |
SEND_CONNECT_DIRECT
   |
END_OF_DAY
```

## Condições

- `MOVEMENTS_READY` libera `SORT_MOVEMENTS`.
- `LIMIT_BATCH_OK` só é gerada após reconciliação técnica.
- `SEND_CONNECT_DIRECT` depende também da validação de totais de negócio.

## Retomada

Não forçar condição apenas para “destravar” a cadeia. Primeiro verificar se a saída do antecessor é válida e se há efeitos parciais.
