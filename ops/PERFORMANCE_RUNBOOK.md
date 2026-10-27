# Runbook — performance z/OS / CICS / DB2

## CICS lento

1. definir escopo: transação, horário, usuários e início do problema;
2. comparar execução normal x lenta;
3. separar CPU, wait, DB2, VSAM, MQ e chamadas externas;
4. verificar mudanças de código/dados/configuração;
5. medir antes e depois da correção.

## DB2

- analisar SQL e caminho de acesso;
- EXPLAIN;
- estatísticas/cardinalidade;
- índices;
- lock waits/deadlocks/timeouts;
- volume retornado;
- frequência de COMMIT.

## Ferramentas

- **MainView** — monitoração operacional e análise de recursos conforme módulos disponíveis.
- **Strobe** — profiling para identificar consumo de CPU/esperas por componente.
- **CICS/DB2 monitors** — evidências de tempo e waits.

## Regra

Não alterar índice, prioridade ou configuração sem hipótese mensurável e critério de validação.
