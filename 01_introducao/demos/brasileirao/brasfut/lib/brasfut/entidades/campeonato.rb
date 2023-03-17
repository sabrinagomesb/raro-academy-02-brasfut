class Campeonato
  attr_accessor :edicao, :equipes, :partidas

  def initialize(edicao)
    @edicao = edicao
    @equipes = []
    @partidas = []
  end

  def classificacao
    @equipes.map do |equipe|
      equipe.classificacao
    end.sort { |x, y| y.pontos <=> x.pontos }
  end

  def criar_tabela!
    ## Implementar a geracao automatica da tabela
    ## considerando que todos os times devem
    ## jogar entre sí em turno e returno
    ## uma vez como mandante e outra como visitante
  end

  def imprimir_tabela
    ## Implementar um metodo que retorne uma string
    ## representando a tabela de jogos no seguinte formato
    ## RODADA <numero da rodada>
    ## ------------------------
    ## CAM X CRU
    ## VAS X FOR
    ##
    ## RODADA <numero da rodada>
    ## ------------------------
    ## CAM X CRU
    ## VAS X FOR
  end

  def imprimir_classificao
    ## Implementar um metodo que retorno uma string
    ## representando a classificacao dos times no seguinte formato
    ## | # | Sigla | Time        | Pontos | Vitorias | Empates | Derrotas | Saldo de Gols | Gols Pro | Gols Contra |
    ## |---|-------|-------------|--------|----------|---------|----------|---------------|----------|-------------|
    ## | 1 | CAM   | Atletico-MG | 18     | 3        | 1       | 0        | 20            | 22       | 2           |
    ## | 2 | VAS   | Vasco       | 12     | 1        | 3       | 2        | -4            | 4        | 8           |
    ## Modifique o projeto para ter as informações necessárias para a geração da tabela
  end
end
