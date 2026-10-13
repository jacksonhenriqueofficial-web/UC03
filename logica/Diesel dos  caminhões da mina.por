programa {
  inclua biblioteca Matematica --> mat
  funcao inicio() {
  real Kilometros, Litros, Preco_do_Litro, Rendimento, Custo_do_Diesel, Custo_por_Km
  cadeia Classificacao[3] = {"eficiente", "aceitável", "revisar"}
  escreva("Quantos Kilometros foram rodados?\n")
  leia(Kilometros)
  escreva("Quantos Litros foi consumidos?\n")
  leia(Litros)
  escreva("Qual o valor do Litro?\n")
  leia(Preco_do_Litro)
  Rendimento = Kilometros/Litros
  Custo_por_Km = Kilometros*Preco_do_Litro
  Custo_do_Diesel = Litros*Preco_do_Litro
  escreva("====Relatório da Mineradora Serra do Espinhaço==\n")
  escreva("O rendimento do transporte é:",mat.arredondar(Rendimento,2),"\n")
  escreva("O custo por km do transporte é:",mat.arredondar(Custo_por_Km,2),"\n")
  escreva("O Custo do Diesel do transporte é:",mat.arredondar(Custo_do_Diesel,2),"\n")
  se(Rendimento >= 0.8){
  escreva("a situação do caminhão é :",Classificacao[0],"\n")
  } senao se(Rendimento >= 0.6 e Custo_por_Km <= 9.00){
  escreva("a situação do caminhão é :",Classificacao[1],"\n")
  } senao{
  escreva("a situação do caminhão é :",Classificacao[2],"\n")
  }
  }
}
