class Campeonato
  attr_accessor :edicao, :equipes

  def initialize(edicao)
    @edicao = edicao
    @equipes = []
  end
end
