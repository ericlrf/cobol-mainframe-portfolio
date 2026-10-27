# GlobalBank Mainframe Lab — COBOL / CICS / DB2 / z/OS

Projeto de portfólio orientado aos conhecimentos da oportunidade **Analista Desenvolvedor COBOL **.

> **Objetivo:** demonstrar, em um único caso de uso, raciocínio de desenvolvimento e sustentação mainframe: COBOL online e batch, CICS, DB2, JCL, VSAM, MQ, CICS Web, SOA, Control-M, Connect:Direct, troubleshooting, performance, DevOps e documentação das ferramentas IBM/Broadcom/BMC citadas na vaga.

## Caso de uso

**GlobalBank Limit & Settlement Hub**: sistema fictício para manutenção online de limites de transferência e processamento batch de movimentos diários.

Fluxos principais:

1. **Online CICS** — consulta e alteração de limite via COBOL + DB2.
2. **CICS Web / SOA** — endpoint HTTP conceitual para consulta de conta.
3. **MQ** — publicação de evento após alteração de limite.
4. **Batch** — reconciliação diária via COBOL/JCL, SORT e IDCAMS.
5. **VSAM** — arquivo KSDS de contas e ESDS de auditoria.
6. **DB2 Native SQL Procedure** — procedure nativa para consulta de resumo.
7. **Control-M** — cadeia de jobs com dependências e retomada.
8. **Connect:Direct** — exemplo de transferência de arquivo de saída.
9. **Endevor / DevOps** — fluxo de promoção DEV → QA → PRD e pipeline CI local.
10. **Operação e performance** — runbooks de abend, dump, CICS lento, DB2 e ferramentas MainView/Strobe/Xpediter/Abend-Aid/File-Aid.
11. **CA Gen / SDF II / Eccox** — documentação conceitual de modelagem/geração e integração com o fluxo.

## Arquitetura

```text
[3270/BMS] --> [CICS Transaction LIMT]
                    |
                    +--> [COBOL LIMONL01] --> [DB2 ACCOUNT_LIMIT]
                    |           |
                    |           +--> [MQ LIMIT.EVENT]
                    |
[CICS Web / HTTP] --> [COBOL LIMWEB01]

[Control-M]
    |
    +--> JCL PREP --> SORT/IDCAMS --> COBOL LIMBAT01 --> DB2/VSAM
                                      |
                                      +--> Settlement output
                                                |
                                                +--> Connect:Direct
```

## Estrutura do repositório

- `src/cics/` — programas COBOL/CICS online e BMS conceitual.
- `src/cobol/` — programa batch COBOL.
- `src/db2/` — DDL, índices, EXPLAIN checklist e Native SQL Procedure.
- `src/mq/` — integração MQ conceitual.
- `src/cics-web/` — interface CICS/WEB e contrato SOA.
- `jcl/` — jobs de compilação/processamento e exemplos SORT/IDCAMS.
- `vsam/` — definições KSDS/ESDS.
- `control-m/` — desenho da cadeia batch.
- `connect-direct/` — exemplo de processo Sterling Connect:Direct.
- `endevor/` — estratégia de elementos, ambientes e promoção.
- `ca-gen/` — mapeamento de modelagem CA Gen para artefatos gerados.
- `ops/` — runbooks de produção, dump e performance.
- `docs/REQUIREMENTS_MATRIX.md` — requisito da vaga → evidência no projeto.
- `tests/` — testes de regras e cenários operacionais.

## Cenário online demonstrado

A transação `LIMT` recebe agência, conta e novo limite, valida dados, consulta DB2, atualiza o registro e publica evento MQ. O exemplo explicita tratamento de `SQLCODE`, unidade de trabalho, rollback e cuidado com recursos compartilhados para discutir **reentrância/threadsafe** em CICS.

## Cenário batch demonstrado

O processamento diário recebe movimentos, ordena dados, atualiza estado, escreve auditoria em ESDS e produz arquivo de liquidação. O runbook trata retomada após falha sem assumir que `RESTART=` sozinho garante consistência.

## Como apresentar este projeto na entrevista

Use a sequência:

1. **Problema de negócio** — limite online + liquidação batch.
2. **Arquitetura** — CICS/COBOL/DB2/MQ + batch/VSAM/JCL.
3. **Integridade** — commit, rollback, idempotência e retomada.
4. **Performance** — caminho de acesso DB2, locks, CICS response time.
5. **Operação** — dump/abend, monitoração e promoção.
6. **DevOps** — versionamento, CI e fluxo Endevor.

## Execução local

Os artefatos CICS, DB2 for z/OS, MQ, Endevor e Control-M são exemplos de portfólio e exigem ambiente/licenças apropriados para execução real. O repositório inclui testes locais de regras e validações de estrutura:

```bash
python3 -m unittest discover -s tests -v
```

## Nota de escopo

Este projeto **não afirma experiência profissional** com cada produto citado. Ele serve como laboratório demonstrável para estudar e discutir os conhecimentos exigidos na oportunidade.
