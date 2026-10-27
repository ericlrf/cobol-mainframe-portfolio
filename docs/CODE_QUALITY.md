# Qualidade de código

Checklist:

- validar parâmetros antes de acessar recursos;
- tratar SQLCODE/RESP/RESP2 explicitamente;
- evitar `WHEN OTHER` sem logging contextual;
- manter unidade de trabalho curta;
- padronizar nomes e copybooks;
- não duplicar regras online/batch sem camada compartilhável;
- registrar correlação de transação/lote;
- testes de borda para limites monetários;
- revisão de impacto de índices e locks;
- separar erro técnico de mensagem de negócio.
