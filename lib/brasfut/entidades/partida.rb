class Partida
  attr_accessor :mandante, :visitante,
                :gols_mandante, :gols_visitante

  def initialize(mandante, visitante)
    @mandante = mandante
    @visitante = visitante

    @mandante.partidas << self
    @visitante.partidas << self
  end

  def resultado_para(equipe)
    return "não houve partida" if gols_mandante.nil? || gols_visitante.nil?
    return "empate" if @gols_mandante == @gols_visitante

    if equipe == @mandante
      return "vitoria" if @gols_mandante > @gols_visitante
      return "derrota" if @gols_mandante < @gols_visitante
    elsif equipe == @visitante
      return "vitoria" if @gols_visitante > @gols_mandante
      return "derrota" if @gols_visitante < @gols_mandante
    end
  end

  def saldo_gols_para(equipe)
    return [0, 0] if gols_mandante.nil? || gols_visitante.nil?

    if equipe == @mandante
      return [@gols_mandante, @gols_visitante]
    elsif equipe == @visitante
      return [@gols_visitante, @gols_mandante]
    end
  end

  def quantos_pontos_para(equipe)
    return 0 if gols_mandante.nil? || gols_visitante.nil?

    if gols_mandante == gols_visitante
      return 1
    elsif (equipe == @mandante && gols_mandante > gols_visitante)
      return 3
    elsif (equipe == @visitante && gols_visitante > gols_mandante)
      return 3
    else
      return 0
    end
  end
end
