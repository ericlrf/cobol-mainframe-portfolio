# CA Gen 8+ — modelagem conceitual do caso

## Processo de negócio

`Maintain Account Transfer Limit`

Entradas:
- agência;
- conta;
- novo limite.

Saídas:
- status;
- limite anterior;
- limite novo;
- código/mensagem.

## Entidades

- Customer Account
- Account Limit
- Limit Audit

## Ações

1. Validate Account
2. Retrieve Current Limit
3. Validate New Limit
4. Update Limit
5. Register Audit
6. Publish Limit Event

A pasta documenta como o caso seria representado em modelagem e geração. Não é export de um modelo proprietário CA Gen.
