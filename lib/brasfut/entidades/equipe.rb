class Equipe
  attr_accessor :nome, :sigla, :partidas

  def initialize(nome, sigla)
    self.nome = nome
    self.sigla = sigla
    self.partidas = []
  end

  def classificacao
    gols_pro = 0
    gols_contra = 0
    vitorias = 0
    derrotas = 0
    empates = 0

    @partidas.map do |partida|
      gols_pro += partida.saldo_gols_para(self)[0]
      gols_contra += partida.saldo_gols_para(self)[1]
      if partida.resultado_para(self) == "vitoria"
        vitorias += 1
      elsif partida.resultado_para(self) == "empate"
        empates += 1
      elsif partida.resultado_para(self) == "derrota"
        derrotas += 1
      end
    end

    Classificacao.new(self, gols_pro, gols_contra, vitorias, derrotas, empates)
  end
end
