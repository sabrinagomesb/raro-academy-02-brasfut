class Equipe
  attr_accessor :nome, :sigla

  def initialize(nome, sigla)
    self.nome = nome
    self.sigla = sigla
  end

  def classificacao
    Classificacao.new(self, 0)
  end
end
