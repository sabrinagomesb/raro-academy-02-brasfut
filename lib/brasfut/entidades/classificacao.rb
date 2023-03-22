class Classificacao
  attr_accessor :equipe, :pontos,
                :gols_pro, :gols_contra, :saldo_gols,
                :vitorias, :derrotas, :empates

  def initialize(equipe, gols_pro, gols_contra, vitorias, derrotas, empates)
    @equipe = equipe
    @pontos = vitorias * 3 + empates * 1
    @gols_pro = gols_pro
    @gols_contra = gols_contra
    @saldo_gols = gols_pro - gols_contra
    @vitorias = vitorias
    @derrotas = derrotas
    @empates = empates
  end
end
