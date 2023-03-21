class Campeonato
  attr_accessor :edicao, :equipes, :partidas,
                :rodadas_turno, :rodadas_returno

  def initialize(edicao)
    @edicao = edicao
    @equipes = []
    @partidas = []
    @rodadas_turno = []
    @rodadas_returno = []
  end

  def classificacao
    @equipes.map do |equipe|
      equipe.classificacao
    end.sort { |x, y| y.pontos <=> x.pontos }
  end

  def criar_tabela!
    # reseta atributos
    @partidas = []
    @rodadas_turno = []
    @rodadas_returno = []

    times = @equipes.dup

    # adiciona um time reserva se o número de times por impar
    times << Equipe.new("Reserva", "RES") if times.size.odd?

    # quantidade de rodadas = quantidade de times - 1
    numero_rodadas = times.size - 1

    # gera as rodadas de ida e volta
    (1..numero_rodadas).each do |rodada|
      rodada_turno = Rodada.new(rodada)
      rodada_returno = Rodada.new(numero_rodadas + rodada)

      rodada_turno.partidas = []
      rodada_returno.partidas = []

      # gera as partidas das rodadas de ida e volta
      partidas_por_rodada = times.size / 2

      (0..partidas_por_rodada - 1).each do |i|
        mandante = times[i]
        visitante = times[times.size - 1 - i]

        partida_turno = Partida.new(mandante, visitante)
        partida_returno = Partida.new(visitante, mandante)

        # armazena jogos
        rodada_turno.partidas << partida_turno
        rodada_returno.partidas << partida_returno
        @partidas << partida_turno << partida_returno
      end

      @rodadas_turno << rodada_turno
      @rodadas_returno << rodada_returno

      times.insert(1, times.pop)
    end
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
