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
    return "não jogou" if gols_mandante.nil? || gols_visitante.nil?

    if gols_mandante == gols_visitante
      return "empate"
    elsif (equipe == @mandante && gols_mandante > gols_visitante)
      return "vitoria"
    elsif (equipe == @visitante && gols_visitante > gols_mandante)
      return "vitoria"
    else
      return "derrota"
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
end
