# frozen_string_literal: true

require "brasfut"

RSpec.describe Brasfut do
  before(:all) do
    @campeonato = Campeonato.new(2023)
    @campeonato.equipes << Equipe.new("Atlético-MG", "CAM")
    @campeonato.equipes << Equipe.new("Vasco", "VAS")
    @campeonato.equipes << Equipe.new("Cruzeiro", "CRU")
    @campeonato.equipes << Equipe.new("Fortaleza", "FOR")
  end

  it "Todos os times devem ter zero pontos" do
    @campeonato.equipes.each do |equipe|
      expect(equipe.classificacao.pontos).to eq(0)
    end
  end
end
