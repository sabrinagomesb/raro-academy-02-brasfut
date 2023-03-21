# frozen_string_literal: true

require "brasfut"

RSpec.describe Brasfut do
  before(:all) do
    @campeonato = Campeonato.new(2023)
    @cam = Equipe.new("Atlético-MG", "CAM")
    @vas = Equipe.new("Vasco", "VAS")
    @cru = Equipe.new("Cruzeiro", "CRU")
    @for = Equipe.new("Fortaleza", "FOR")
    @campeonato.equipes = [@vas, @cam, @cru, @for]
  end

  it "Todos os times devem ter zero pontos" do
    @campeonato.equipes.each do |equipe|
      expect(equipe.classificacao.pontos).to eq(0)
    end
  end

  it "Deve calcular 3 pontos por uma vitoria" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 2
    partida.gols_visitante = 1

    expect(@cam.classificacao.pontos).to eq(3)
    expect(@vas.classificacao.pontos).to eq(0)
  end

  it "Deve calcular 1 ponto por empate" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 5
    partida.gols_visitante = 5

    expect(@cam.classificacao.pontos).to eq(1)
    expect(@vas.classificacao.pontos).to eq(1)
  end

  it "Deve calcular 0 ponto por derrota" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cru, @cam)
    partida.gols_mandante = 0
    partida.gols_visitante = 1

    expect(@cru.classificacao.pontos).to eq(0)
    expect(@cam.classificacao.pontos).to eq(3)
  end

  it "O galo deve estar em primeiro e o vasco em segundo" do
    @vas.partidas = []
    @cam.partidas = []
    partida = Partida.new(@cam, @vas)
    partida.gols_mandante = 2
    partida.gols_visitante = 1

    classificacoes = @campeonato.classificacao
    expect(classificacoes[0].equipe).to eq(@cam)
    expect(classificacoes[0].pontos).to eq(3)

    expect(classificacoes[1].equipe).to eq(@vas)
    expect(classificacoes[1].pontos).to eq(0)
  end
end
