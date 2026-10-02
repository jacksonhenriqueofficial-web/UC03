programa {
  //Não consegui usar o registro...
  const cadeia codigo_grupo = "SA03S-G05-49D2"
  const cadeia base = "Benedito Bentes"
  const real VALOR_POR_ENTREGA = 7.00
  const real BONUS_META = 100.00
  const real DESCONTO_CANCELAMENTO = 8.00

  // Função para calcular o bônus com base na meta semanal (meta: >= 35 entregas)
  funcao real calcularBonus(inteiro totalEntregas, inteiro cancelamentos) {
    se (totalEntregas >= 35 e cancelamentos == 0) {
      retorne BONUS_META
    } senao {
      retorne 0.0
    }
  }

  // Função: Pagamento por entrega (com bônus e COM descontos por cancelamento)
  funcao real pagamentoPorEntrega(inteiro entregas, inteiro cancelamentos) {
    real bonus = calcularBonus(entregas, cancelamentos)
    real bruto = entregas * VALOR_POR_ENTREGA
    real desconto = cancelamentos * DESCONTO_CANCELAMENTO
    
    retorne bruto + bonus - desconto
  }

  // Função: Repasse das entregas (com bônus, mas SEM os descontos por cancelamento)
  funcao real repasseDasEntregas(inteiro entregas, inteiro cancelamentos) {
    real bonus = calcularBonus(entregas, cancelamentos)
    real bruto = entregas * VALOR_POR_ENTREGA
    
    retorne bruto + bonus
  }

  // Função: Situação do Entregador
  funcao cadeia situacaoDoEntregador(inteiro entregas, inteiro cancelamentos) {
    se (entregas >= 35 e cancelamentos == 0) {
      retorne "Destaque!"
    } senao se (entregas >= 25) {
      retorne "Regular"
    } senao {
      retorne "Atenção"
    }
  }

  funcao inicio() {
    // Vetores para guardar os dados dos 4 entregadores
    inteiro codigo[4] = {501,502,503,504}
    cadeia nome[4] = {"Elton", "Raul", "Tiago", "Rosana"}
    inteiro cancelamentos[4] = {3,2,0,0}
    
    // Matriz com as entregas da semana (4 entregadores x 5 dias)
    inteiro entregasSemana[4][5] = {
      {8, 5, 9, 5, 11},
      {6, 2, 3, 4, 2},
      {12, 7, 5, 11, 9},
      {8, 8, 8, 4, 6}
    }

    // Variáveis acumuladoras para o Relatório Geral da Base
    real totalAPagarBase = 0.0
    inteiro totalEntregasBase = 0
    inteiro qtdDestaque = 0
    inteiro qtdRegular = 0
    inteiro qtdAtencao = 0

    // Vetor auxiliar para guardar o total de entregas de cada entregador
    inteiro totalEntregasEntregador[4]

    // Processamento do total de entregas e cálculo das situações
    para (inteiro i = 0; i < 4; i++) {
      inteiro somaEntregas = 0
      para (inteiro dia = 0; dia < 5; dia++) {
        somaEntregas = somaEntregas + entregasSemana[i][dia]
      }
      totalEntregasEntregador[i] = somaEntregas
      totalEntregasBase = totalEntregasBase + somaEntregas

      // Soma o pagamento líquido ao total a pagar da base
      real pagLiquido = pagamentoPorEntrega(somaEntregas, cancelamentos[i])
      totalAPagarBase = totalAPagarBase + pagLiquido

      // Contagem da situação de cada entregador
      cadeia sit = situacaoDoEntregador(somaEntregas, cancelamentos[i])
      se (sit == "Destaque!") {
        qtdDestaque = qtdDestaque + 1
      } senao se (sit == "Regular") {
        qtdRegular = qtdRegular + 1
      } senao {
        qtdAtencao = qtdAtencao + 1
      }
    }

    // Cálculo do dia mais movimentado da semana (coluna da matriz com maior soma)
    inteiro maiorTotalDia = -1
    inteiro diaMaisMovimentado = 1

    para (inteiro dia = 0; dia < 5; dia++) {
      inteiro totalDia = 0
      para (inteiro i = 0; i < 4; i++) {
        totalDia = totalDia + entregasSemana[i][dia]
      }
      se (totalDia > maiorTotalDia) {
        maiorTotalDia = totalDia
        diaMaisMovimentado = dia + 1
      }
    }

    // 2. EXIBIÇÃO DO RELATÓRIO DA BASE
    escreva("[ ",codigo_grupo," ]\n")
    escreva("[ ",base," ]\n")
    escreva("\n=========================================\n")
    escreva("           RELATÓRIO DA BASE             \n")
    escreva("=========================================\n")
    escreva("Total de Entregas da Base: ", totalEntregasBase, "\n")
    escreva("Total a Pagar (Base): R$ ", totalAPagarBase, "\n")
    escreva("Dia Mais Movimentado: Dia ", diaMaisMovimentado, " (com ", maiorTotalDia, " entregas)\n")
    escreva("\n--- Quantidade por Situação ---\n")
    escreva(" - Destaque!: ", qtdDestaque, "\n")
    escreva(" - Regular:   ", qtdRegular, "\n")
    escreva(" - Atenção:   ", qtdAtencao, "\n")
    escreva("=========================================\n\n")

    // 3. CONSULTA INDIVIDUAL POR CÓDIGO DO ENTREGADOR
    inteiro codigoBusca = -1

    enquanto (verdadeiro) {
      escreva("Digite o código do entregador para consultar (ou 0 para sair): ")
      leia(codigoBusca)

      // Encerrar o programa
      se (codigoBusca == 0) {
        escreva("\nPrograma finalizado com sucesso!\n")
        pare
      }

      logico encontrado = falso
      inteiro idx = -1

      // Busca sequencial no vetor de códigos
      para (inteiro i = 0; i < 4; i++) {
        se (codigo[i] == codigoBusca) {
          encontrado = verdadeiro
          idx = i
          pare
        }
      }

      // Se encontrar o entregador
      se (encontrado) {
        inteiro totalE = totalEntregasEntregador[idx]
        inteiro canc = cancelamentos[idx]
        cadeia sit = situacaoDoEntregador(totalE, canc)
        real repasse = repasseDasEntregas(totalE, canc)
        real pagLiquido = pagamentoPorEntrega(totalE, canc)

        escreva("\n-----------------------------------------\n")
        escreva("DETALHES DO ENTREGADOR (Código: ", codigo[idx], ")\n")
        escreva("Nome: ", nome[idx], "\n")
        escreva("Entregas dia a dia:\n")
        para (inteiro dia = 0; dia < 5; dia++) {
          escreva("  - Dia ", dia + 1, ": ", entregasSemana[idx][dia], " entregas\n")
        }
        escreva("Total de entregas realizadas: ", totalE, "\n")
        escreva("Cancelamentos: ", canc, "\n")
        escreva("Situação: ", sit, "\n")
        escreva("Repasse (sem descontos): R$ ", repasse, "\n")
        escreva("Pagamento Líquido (com descontos): R$ ", pagLiquido, "\n")
        escreva("-----------------------------------------\n")
      } 
      // Se o código não existir
      senao {
        escreva("\n[ALERTA] Código ", codigoBusca, " não encontrado na base! Tente novamente.\n")
      }
    }
  }
}
