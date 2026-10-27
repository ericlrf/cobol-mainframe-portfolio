# Balanced line / totais de controle

O batch mantém:

- quantidade lida;
- quantidade válida;
- quantidade rejeitada;
- quantidade atualizada;
- soma dos valores de entrada;
- soma dos valores processados.

Critério de reconciliação:

`LIDOS = VALIDOS + REJEITADOS`

Além disso, o valor financeiro processado deve ser reconciliado com os registros efetivamente confirmados. Um RC=0 não substitui a conferência de totais de negócio.
