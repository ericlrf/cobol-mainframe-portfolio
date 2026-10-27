# Runbook — Abend e análise de DUMP

## S0C7

1. identificar job/step/programa/load module;
2. coletar completion code e offset;
3. correlacionar offset com listing/compile map;
4. identificar campo usado em operação numérica;
5. verificar conteúdo, layout/copybook e origem;
6. revisar mudança recente;
7. reproduzir em teste;
8. corrigir causa, não apenas mascarar o dado;
9. validar dados e retomada.

## Ferramentas citadas na oportunidade

- **Abend-Aid** — acelerar localização da falha e contexto do dump.
- **Xpediter** — depuração/interceptação em ambiente controlado.
- **File-Aid** — inspeção/edição controlada de datasets de teste.

Nunca editar produção diretamente para “resolver rápido”.
