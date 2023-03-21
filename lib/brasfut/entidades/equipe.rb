class Equipe
  attr_accessor :nome, :sigla, :partidas

  def initialize(nome, sigla)
    self.nome = nome
    self.sigla = sigla
    self.partidas = []
  end

  def classificacao
    pontos = @partidas.map do |partida|
      partida.quantos_pontos_para(self)
    end.sum

    Classificacao.new(self, pontos)
  end
end
