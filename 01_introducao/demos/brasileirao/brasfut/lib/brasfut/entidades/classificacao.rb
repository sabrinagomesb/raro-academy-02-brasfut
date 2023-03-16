class Classificacao
  attr_accessor :equipe, :pontos

  def initialize(equipe, pontos)
    puts equipe.inspect

    @equipe = equipe
    @pontos = pontos
  end
end
