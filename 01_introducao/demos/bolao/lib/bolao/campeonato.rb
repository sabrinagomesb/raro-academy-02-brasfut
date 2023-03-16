module Bolao
  class Campeonato
    attr_accessor :edicao, :rodadas, :times

    def initialize(edicao)
      @edicao = edicao
      @rodadas = []
    end

    def criar_rodadas!
      RoundRobinTournament.schedule(@times).each_with_index do |rodada, index|
        @rodadas[index] ||= Rodada.new(index + 1)
        @rodadas[index + 19] ||= Rodada.new(index + 20)
        rodada.each do |partida|
          @rodadas[index].partidas.push(Partida.new(partida[0], partida[1]))
          @rodadas[index + 19].partidas.push(Partida.new(partida[1], partida[0]))
        end
      end
      tabela
    end

    def jogos_como_mandante(time)
      jogos_como(time, :mandante)
    end

    def jogos_como_visitante(time)
      jogos_como(time, :visitante)
    end

    def jogos_como(time, tipo)
      jogos = []
      @rodadas.each do |rodada|
        rodada.partidas.each do |partida|
          jogos.push(partida) if partida.send(tipo).nome == time
        end
      end
      jogos
    end

    def tabela
      @rodadas.each do |rodada|
        rodada.partidas.each do |p|
          puts p
        end
      end
    end

    def classificacao
      resumo = {}
      @rodadas.each do |rodada|
        rodada.partidas.select { |p| p.gols_visitante.present? && p.gols_visitante.present? }.each do |partida|
          resumo[partida.mandante] ||= { pontos: 0, gols_pro: 0, gols_contra: 0 }
          resumo[partida.visitante] ||= { pontos: 0, gols_pro: 0, gols_contra: 0 }
          resumo[partida.mandante][:gols_pro] += partida.gols_mandante
          resumo[partida.mandante][:gols_contra] += partida.gols_visitante
          resumo[partida.visitante][:gols_pro] += partida.gols_visitante
          resumo[partida.visitante][:gols_contra] += partida.gols_mandante

          if partida.gols_mandante > partida.gols_visitante
            resumo[partida.mandante][:pontos] = resumo[partida.mandante][:pontos] + 3
          elsif partida.gols_visitante > partida.gols_mandante
            resumo[partida.visitante][:pontos] = resumo[partida.visitante][:pontos] + 3
          else
            resumo[partida.mandante][:pontos] = resumo[partida.mandante][:pontos] + 1
            resumo[partida.visitante][:pontos] = resumo[partida.visitante][:pontos] + 1
          end
        end
      end

      resumo.to_a.sort { |x, y| y[1][:pontos] <=> x[1][:pontos] }
        .map { |r| Classificacao.new(r[0], r[1][:pontos], r[1][:gols_pro], r[1][:gols_contra]) }
    end
  end

  class Classificacao
    attr_accessor :time, :pontos, :gols_pro, :gols_contra

    def initialize(time, pontos, gols_pro, gols_contra)
      @time = time
      @pontos = pontos
      @gols_pro = gols_pro
      @gols_contra = gols_contra
    end

    def saldo_gols
      (gols_pro || 0) - (gols_contra || 0)
    end
  end

  class Rodada
    attr_accessor :campeonato, :numero, :partidas

    def initialize(numero)
      @numero = numero
      @partidas = []
    end
  end

  class Partida
    attr_accessor :rodada, :mandante, :visitante, :gols_visitante, :gols_mandante

    def initialize(mandante, visitante)
      @mandante = mandante
      @visitante = visitante
    end

    def to_s
      "#{mandante.sigla} x #{visitante.sigla}"
    end
  end

  class Time
    attr_accessor :partidas_como_mandante, :partidas_como_visitante, :nome, :sigla

    def initialize(nome, sigla)
      @nome = nome
      @sigla = sigla
    end

    def to_s
      "#{@sigla}"
    end
  end
end
