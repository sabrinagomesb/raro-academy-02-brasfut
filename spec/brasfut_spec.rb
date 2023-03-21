# frozen_string_literal: true

require "brasfut"

RSpec.describe Brasfut do
  describe "Campeonato" do
    before(:all) do
      @campeonato = Campeonato.new(2023)
      @vas = Equipe.new("Vasco", "VAS")
      @cam = Equipe.new("Atlético-MG", "CAM")
      @cru = Equipe.new("Cruzeiro", "CRU")
      @for = Equipe.new("Fortaleza", "FOR")
      @campeonato.equipes = [@vas, @cam, @cru, @for]
      @campeonato.criar_tabela!
    end

    it "Deve ser a edição 2023" do
      expect(@campeonato.edicao).to eq(2023)
    end

    it "Deve ter 4 equipes" do
      expect(@campeonato.equipes.size).to eq(4)
    end

    it "Deve ter 3 rodadas de turno e 3 rodadas de returno, totalizando 6 rodadas" do
      expect(@campeonato.rodadas_turno.size).to eq(3)
      expect(@campeonato.rodadas_returno.size).to eq(3)
      expect(@campeonato.rodadas_turno.size + @campeonato.rodadas_returno.size).to eq(6)
    end

    it "Deve ter 2 partidas por rodada" do
      expect(@campeonato.rodadas_turno[0].partidas.size).to eq(2)
      expect(@campeonato.rodadas_returno[0].partidas.size).to eq(2)
    end

    it "Deve ter 12 partidas" do
      rodadas = @campeonato.rodadas_turno.size + @campeonato.rodadas_returno.size
      partidas_por_rodadas = @campeonato.rodadas_turno[0].partidas.size
      expect(partidas_por_rodadas * rodadas).to eq(12)
      expect(@campeonato.partidas.size).to eq(12)
    end

    it "Todos os times devem ter zero pontos" do
      @campeonato.equipes.each do |equipe|
        expect(equipe.classificacao.pontos).to eq(0)
      end
    end

    it "Deve incluir time reserva na tabela quando o número de equipes for ímpar" do
      novo_campeonato = Campeonato.new(2024)
      bahia = Equipe.new("Bahia", "BAH")
      novo_campeonato.equipes << bahia
      novo_campeonato.criar_tabela!

      expect(novo_campeonato.partidas[0].visitante.nome).to eq("Reserva")
    end
  end

  describe "Pontuação" do
    before(:all) do
      @campeonato = Campeonato.new(2023)
      @cam = Equipe.new("Atlético-MG", "CAM")
      @vas = Equipe.new("Vasco", "VAS")
      @cru = Equipe.new("Cruzeiro", "CRU")
      @for = Equipe.new("Fortaleza", "FOR")
      @campeonato.equipes = [@vas, @cam, @cru, @for]
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
  end

  describe "Classificação" do
    before(:all) do
      @campeonato = Campeonato.new(2023)
      @cam = Equipe.new("Atlético-MG", "CAM")
      @vas = Equipe.new("Vasco", "VAS")
      @cru = Equipe.new("Cruzeiro", "CRU")
      @for = Equipe.new("Fortaleza", "FOR")
      @campeonato.equipes = [@vas, @cam, @cru, @for]
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
end
