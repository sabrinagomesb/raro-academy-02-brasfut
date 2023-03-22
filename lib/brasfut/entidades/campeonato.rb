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
    classificacao = @equipes.map do |equipe|
      equipe.classificacao
    end

    classificacao.sort do |x, y|
      if y.pontos != x.pontos
        y.pontos <=> x.pontos
      elsif y.vitorias != x.vitorias
        y.vitorias <=> x.vitorias
      elsif y.saldo_gols != x.saldo_gols
        y.saldo_gols <=> x.saldo_gols
      else
        y.gols_pro <=> x.gols_pro
      end
    end
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
    rodadas_total = @rodadas_turno + @rodadas_returno
    tabela = ""

    rodadas_total.each do |rodada|
      tabela += "\nRODADA #{rodada.numero}\n------------------------\n"
      rodada.partidas.each do |partida|
        tabela += "#{partida.mandante.sigla} X #{partida.visitante.sigla}\n"
      end
    end

    puts tabela
    tabela
  end

  def imprimir_classificacao
    cabecalho = "| # | Sigla | Time            | Pontos | Vitorias | Empates | Derrotas | Saldo de Gols | Gols Pro | Gols Contra |\n"
    divisoria = "|---|-------|-----------------|--------|----------|---------|----------|---------------|----------|-------------|\n"
    dados = self.classificacao.map.with_index do |classificacao, index|
      "| #{index + 1} |  #{classificacao.equipe.sigla}  | #{classificacao.equipe.nome.ljust(15)} | #{classificacao.pontos.to_s.ljust(6)} | #{classificacao.vitorias.to_s.ljust(8)} | #{classificacao.empates.to_s.ljust(7)} | #{classificacao.derrotas.to_s.ljust(8)} | #{classificacao.saldo_gols.to_s.ljust(13)} | #{classificacao.gols_pro.to_s.ljust(8)} | #{classificacao.gols_contra.to_s.ljust(11)} |\n"
    end

    tabela = cabecalho + divisoria + dados.join + divisoria
    puts tabela
    tabela
  end
end
