# SOA e CICS Web

Serviço conceitual `GET /accounts/{agency}/{account}/limit`.

Contrato de resposta:

```json
{
  "agency": "1234",
  "account": "0000123456",
  "dailyLimit": 25000.00,
  "status": "ACTIVE"
}
```

O serviço reaproveita a regra de negócio do domínio sem acoplar o consumidor ao layout 3270. Em produção, autenticação, autorização, TLS, versionamento, timeout e observabilidade seriam obrigatórios.
