programa {
  funcao inicio() {
    /**
     * peso total produzido: 13125.0 | Total de paletes completos: 26 | Caixas extras: 10
     * O caminhão foi liberado!
     * ===================================================================================
     * peso total produzido: 15714.0 | Total de paletes completos: 21 | Caixas extras: 33
     * A câmara está com a temperatura elevada, porém não tem paletes completos.
     * ===================================================================================
     * peso total produzido: 350.0 | Total de paletes completos: 0 | Caixas extras: 35
     * A câmara está na temperatura correta, porém não tem paletes completos.
     * ===================================================================================
     */
    real temperatura, kg, total
    inteiro caixas, paletes = 40, sobras, completo
    escreva("Qual foi a quantidade de caixas produzidas?\n")
    leia(caixas)
    escreva("Qual o peso de cada caixa?\n")
    leia(kg)
    escreva("Qual a temperatura da câmara?\n")
    leia(temperatura)
    completo = caixas/paletes
    sobras = caixas % paletes
    total = caixas*kg
    logico liberado = completo >= 1 e temperatura <= -18
    escreva("\npeso total produzido: ", total," | Total de paletes completos: ",completo," | Caixas extras: ", sobras, "\n")
    se(liberado){
      escreva("\nO caminhão foi liberado!")
    } senao se(completo <= 0 e temperatura <= -18){
      escreva("\nA câmara está na temperatura correta, porém não tem paletes completos.")
    } senao se(completo >= 1 e temperatura > -18){
      escreva("\nA câmara está com a temperatura elevada, porém não tem paletes completos.")
    } senao{
      escreva("\nO caminhão não pode ser liberado, pois não tem nenhum requisito concluido!")
    }
  }
}
