# CICS: reentrância, quasi-reentrância e threadsafe

## Princípios usados

- Estado da requisição fica em `WORKING-STORAGE`/COMMAREA apropriada, sem depender de estado global mutável entre tarefas.
- Recursos compartilhados exigem disciplina de concorrência.
- `RENT` ou `CONCURRENCY(THREADSAFE)` não corrigem lógica insegura por si só.
- Rotinas chamadas devem ser avaliadas quanto a threadsafety.
- Unidade de trabalho deve ser curta para reduzir locks e tempo de resposta.

## Pergunta de entrevista

**Por que este programa pode ser discutido como candidato a threadsafe?**

Porque não depende de memória global compartilhada mutável, mantém a transação curta e isola acesso persistente no DB2/MQ. Em ambiente real, ainda seria necessário verificar todas as APIs, exits, subprogramas e definições CICS antes de marcar o programa como threadsafe.
