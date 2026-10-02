# Diagrama EPS — Fechamento semanal de entregas · Grupo 05

> **MODELO DE REFERÊNCIA.** O que está preenchido vem do **cartão do grupo**. O que está como `______` é com vocês.
> Preencham **antes** de abrir o Portugol (roteiro de trabalho, passo 2). Copie este arquivo para `docs/` e escreva com as suas palavras.

**Sistema:** TáNaMão Delivery — fechamento semanal · **Base:** Benedito Bentes
**Código de autenticidade:** `SA03S-G05-49D2`
**Responsável pelo EPS:** __Denys_Henrique_Agostinho_Silva__  ·  **Integrantes:** __Jackson_Dafine_Denys_Carla_Evyli_________

---

## E — ENTRADA (o que o programa recebe)

### E1. Parâmetros da base (valores fixos do cartão)

| Dado | Valor do cartão | Tipo de dado (`inteiro`, `real` ou `cadeia`) |
|---|---|---|
| Pagamento por entrega | R$ 7,00 | __real____ |
| Meta semanal de entregas | 35 | ___inteiro___ |
| Meta mínima da semana | 25 | ___inteiro___ |
| Valor do bônus de meta | R$ 100,00 | __real____ |
| Desconto por cancelamento | R$ 8,00 | ___real___ |
| Nome da base | Benedito Bentes | __cadeia____ |
| Código de autenticidade | SA03S-G05-49D2 | __cadeia____ |

### E2. Cadastro dos entregadores (valores do cartão)

| Código | Nome | Cancelamentos | Tipo do código | Tipo do nome | Tipo dos cancelamentos |
|---|---|---|---|---|---|
| 501 | Elton | 3 | ___inteiro___ | ___cadeia___ | __real____ |
| 502 | Raul | 2 | __inteiro____ | __cadeia____ | __real____ |
| 503 | Tiago | 0 | ___inteiro___ | __cadeia____ | __real____ |
| 504 | Rosana | 0 | __inteiro____ | __cadeia____ | __real____ |

### E3. Entregas concluídas por dia (valores do cartão)

| Código | Segunda | Terça | Quarta | Quinta | Sexta |
|---|---|---|---|---|---|
| 501 | 8 | 5 | 9 | 5 | 11 |
| 502 | 6 | 2 | 3 | 4 | 2 |
| 503 | 12 | 7 | 5 | 11 | 9 |
| 504 | 8 | 8 | 8 | 4 | 6 |

Estrutura de dados que guarda esta tabela: __matriz__ (linhas = __4___ · colunas = __5___)

### E4. Entrada pelo teclado

| O que o operador digita | Tipo | Quando a digitação termina |
|---|---|---|
| __codigo do entregador ______ | __inteiro____ | __Digitar 0______ |

---

## P — PROCESSAMENTO (o que o programa calcula e decide)

Escreva cada passo como uma **conta ou condição**, em português, usando os valores do cartão quando precisar.
Os números entre parênteses são as **regras do enunciado** (seção 2) que vocês devem ler.

| # | Passo | Como é feito (conta, condição ou repetição) |
|---|---|---|
| P1 | Total de entregas de cada entregador | __501,Elton tem 38 entregas_502,Raul tem 17 entregas_503,Tiago tem 44 de entregas_504, Rosana tem 34 entregas_____ |
| P2 | Ganho com as entregas (regra 1) | ______R$ 991.0_______ |
| P3 | Bônus de meta (regra 2) | __R$ 100,00_____________ |
| P4 | Desconto por cancelamentos (regra 3) | __R$ 8,00_________ |
| P5 | Repasse da semana (regra 4) | __valor Bonús de meta__R$100____________ |
| P6 | Situação do entregador, na ordem do enunciado (regra 5) | 1º _1__ · 2º __2___ · 3º __1___ |
| P7 | Total a pagar da base (regra 6) | ________R$ 991,00_______ |
| P8 | Total de entregas da semana (regra 6) | _____133_entrega______ |
| P9 | Quantos entregadores em cada situação (regra 6) | __4_entregdores____ |
| P10 | Quem teve o maior repasse (regra 6) | __503_Tiago_com_44_com maior repasse______ |
| P11 | Dia mais movimentado, somando todos (regra 6) | __segunda__ |
| P12 | Consulta de extrato: busca pelo código e repetição (regra 7) | ______
Digite o código do entregador para consultar (ou 0 para sair): 503

-----------------------------------------
DETALHES DO ENTREGADOR (Código: 503)
Nome: Tiago
Entregas dia a dia:
  - Dia 1: 12 entregas
  - Dia 2: 7 entregas
  - Dia 3: 5 entregas
  - Dia 4: 11 entregas
  - Dia 5: 9 entregas
Total de entregas realizadas: 44
Cancelamentos: 0
Situação: Destaque!
Repasse (sem descontos): R$ 408.0
Pagamento Líquido (com descontos): R$ 408.0
-----------------------------------------
________ |

**Repetições usadas (quais laços, percorrendo o quê):** ______para e o enquanto________

**Acumuladores e contadores (nome e para que servem):** __Acumulador ele guarda o valor de uma matriz/vetor e faz uma soma, já o contador, ele conta os vetores/matrizes de cada situação especifica__ |

---

## S — SAÍDA (o que o programa mostra)

A **primeira linha** impressa é o código de autenticidade do grupo. Complete de onde vem cada informação (variável ou passo P1–P12).

| Informação exibida | Vem de (passo ou variável) |
|---|---|
| Código de autenticidade (1ª linha) | `SA03S-G05-49D2` |
| Nome da base | Benedito Bentes |
| Por entregador: código, nome, total de entregas, cancelamentos, ganho, bônus, desconto, repasse e situação | _                  501, Elton, 38 entregas, 3 cancelamentos, 242, 0, 24, 266, Situação: Regular___________ |
| Por entregador: código, nome, total de entregas, cancelamentos, ganho, bônus, desconto, repasse e situação | _                  502, Raul, 17 entregas, 2 cancelamentos, 103, 0, 16, 119, Situação: Atenção___________ |
| Por entregador: código, nome, total de entregas, cancelamentos, ganho, bônus, desconto, repasse e situação | _                  503, Tiago, 44 entregas, 0 cancelamentos, 408, 100, 0, 408, Situação: Destaque___________ |
| Por entregador: código, nome, total de entregas, cancelamentos, ganho, bônus, desconto, repasse e situação | _                  504, Rosana, 34 entregas, 0 cancelamentos, 238, 0, 0, 238, Situação: Regular___________ |
| Total a pagar | ________991,00 reais___________ |
| Total de entregas da semana | __133________________ |
| Quantidade de entregadores por situação | ___4 entregadores____________ |
| Entregador com o maior repasse | __Tiago________ |
| Dia mais movimentado | __segunda feira__________ |
| Extrato do entregador consultado (dia a dia, total, cancelamentos e situação) |_
 -----------------------------------------
DETALHES DO ENTREGADOR (Código: 504)
Nome: Rosana
Entregas dia a dia:
  - Dia 1: 8 entregas
  - Dia 2: 8 entregas
  - Dia 3: 8 entregas
  - Dia 4: 4 entregas
  - Dia 5: 6 entregas
Total de entregas realizadas: 34
Cancelamentos: 0
Situação: Regular
Repasse (sem descontos): R$ 238.0
Pagamento Líquido (com descontos): R$ 238.0
-----------------------------------------
| Aviso quando o código não existe | __"[ALERTA] Código 509 não encontrado na base! Tente novamente."___ |

---

## Para discutir em grupo antes de codar

1. O que acontece com um entregador que tem **exatamente** o número de entregas da meta? Confiram no seu cartão se alguém está nessa situação. Resposta do grupo: _______Ele recebera destaque se também tiver total de cancelamento igual a zero.________
2. Em que situação alguém recebe o bônus e **não** é DESTAQUE? Resposta do grupo: _______Não tava essa situção no nosso codigo._________
3. Alguma regra deu margem a dúvida? Anotem aqui (vai para a seção 8 da documentação): _______Não_________

