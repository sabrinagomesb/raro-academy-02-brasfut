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

    it "Todos os times devem começar com zero pontos" do
      @campeonato.equipes.each do |equipe|
        expect(equipe.classificacao.pontos).to eq(0)
      end
    end

    it "Todos os times devem começar com 0 vitórias, 0 derrotas e 0 empates" do
      @campeonato.equipes.each do |equipe|
        expect(equipe.classificacao.vitorias).to eq(0)
        expect(equipe.classificacao.derrotas).to eq(0)
        expect(equipe.classificacao.empates).to eq(0)
      end
    end

    it "Todos os times devem começar com 0 gols" do
      @campeonato.equipes.each do |equipe|
        expect(equipe.classificacao.gols_pro).to eq(0)
        expect(equipe.classificacao.gols_contra).to eq(0)
        expect(equipe.classificacao.saldo_gols).to eq(0)
      end
    end

    it "Deve incluir time reserva na tabela quando o número de equipes for ímpar" do
      novo_campeonato = Campeonato.new(2024)
      bahia = Equipe.new("Bahia", "BAH")
      novo_campeonato.equipes << bahia
      novo_campeonato.criar_tabela!

      expect(novo_campeonato.partidas[0].visitante.nome).to eq("Reserva")
    end

    it "Deve imprimir tabela de jogos" do
      tabela = "\nRODADA 1\n------------------------\nVAS X FOR\nCAM X CRU\n\nRODADA 2\n------------------------\nVAS X CRU\nFOR X CAM\n\nRODADA 3\n------------------------\nVAS X CAM\nCRU X FOR\n\nRODADA 4\n------------------------\nFOR X VAS\nCRU X CAM\n\nRODADA 5\n------------------------\nCRU X VAS\nCAM X FOR\n\nRODADA 6\n------------------------\nCAM X VAS\nFOR X CRU\n"

      expect(@campeonato.imprimir_tabela).to eq(tabela)
    end
  end

  describe "Saldo de gols" do
    before(:all) do
      @campeonato = Campeonato.new(2023)
      @cru = Equipe.new("Cruzeiro", "CRU")
      @for = Equipe.new("Fortaleza", "FOR")
      @campeonato.equipes = [@cru, @for]
      @cru.partidas = []
      @for.partidas = []
      partida = Partida.new(@cru, @for)
      partida.gols_mandante = 1
      partida.gols_visitante = 3
    end
    #   ## acrescentar mais uma partida e testar
    it "Fortaleza deve acumular 3 gols feitos" do
      classficacao = @for.classificacao
      expect(classficacao.gols_pro).to eq(3)
    end

    it "Fortaleza deve acumular 1 gol sofrido" do
      classficacao = @for.classificacao
      expect(classficacao.gols_contra).to eq(1)
    end

    it "Fortaleza deve ter 2 gols de saldo" do
      classficacao = @for.classificacao
      expect(classficacao.saldo_gols).to eq(2)
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

  describe "Resultados acumulados" do
    before(:all) do
      @campeonato = Campeonato.new(2023)
      @cru = Equipe.new("Cruzeiro", "CRU")
      @for = Equipe.new("Fortaleza", "FOR")
      @campeonato.equipes = [@cru, @for]
      @cru.partidas = []
      @for.partidas = []
      partida1 = Partida.new(@cru, @for)
      partida2 = Partida.new(@for, @cru)
      partida1.gols_mandante = 1
      partida1.gols_visitante = 3
      partida2.gols_mandante = 2
      partida2.gols_visitante = 2
    end

    it "Fortaleza deve acumular 1 vitoria" do
      classficacao = @for.classificacao
      expect(classficacao.vitorias).to eq(1)
    end

    it "Fortaleza deve acumular 1 empate" do
      classficacao = @for.classificacao
      expect(classficacao.empates).to eq(1)
    end

    it "Cruzeiro deve acumular 1 derrota" do
      classficacao = @cru.classificacao
      expect(classficacao.derrotas).to eq(1)
    end
  end

  describe "Classificação" do
    before(:all) do
      @camp = Campeonato.new(2022)
      @bah = Equipe.new("Bahia", "BAH")
      @fla = Equipe.new("Flamengo", "FLA")
      @pam = Equipe.new("Palmeiras", "PAM")
      @bgo = Equipe.new("Botafogo", "BFO")
      @camp.equipes = [@bah, @fla, @pam, @bgo]

      partida1 = Partida.new(@bah, @fla)
      partida1.gols_mandante = 3
      partida1.gols_visitante = 1
      partida2 = Partida.new(@fla, @bah)
      partida2.gols_mandante = 2
      partida2.gols_visitante = 5

      partida3 = Partida.new(@bah, @pam)
      partida3.gols_mandante = 2
      partida3.gols_visitante = 1
      partida4 = Partida.new(@pam, @bah)
      partida4.gols_mandante = 1
      partida4.gols_visitante = 1

      partida5 = Partida.new(@bah, @bgo)
      partida5.gols_mandante = 1
      partida5.gols_visitante = 0
      partida6 = Partida.new(@bgo, @bah)
      partida6.gols_mandante = 3
      partida6.gols_visitante = 1

      partida7 = Partida.new(@fla, @pam)
      partida7.gols_mandante = 1
      partida7.gols_visitante = 0
      partida8 = Partida.new(@pam, @fla)
      partida8.gols_mandante = 3
      partida8.gols_visitante = 1

      partida9 = Partida.new(@fla, @bgo)
      partida9.gols_mandante = 4
      partida9.gols_visitante = 4
      partida10 = Partida.new(@bgo, @fla)
      partida10.gols_mandante = 2
      partida10.gols_visitante = 5

      partida11 = Partida.new(@pam, @bgo)
      partida11.gols_mandante = 4
      partida11.gols_visitante = 4
      partida12 = Partida.new(@bgo, @pam)
      partida12.gols_mandante = 2
      partida12.gols_visitante = 2

      @classificacao = @camp.classificacao
    end

    it "Bahia deve ficar em primeiro lugar" do
      expect(@classificacao[0].equipe).to eq(@bah)
      expect(@classificacao[0].pontos).to eq(13)
    end

    it "Botafogo deve ficar em último lugar" do
      expect(@classificacao[3].equipe).to eq(@bgo)
      expect(@classificacao[3].saldo_gols).to eq(-2)
      expect(@classificacao[3].pontos).to eq(6)

      expect(@classificacao[2].equipe).to eq(@pam)
      expect(@classificacao[2].saldo_gols).to eq(0)
      expect(@classificacao[2].pontos).to eq(6)
    end

    it "Deve imprimir a tabela de classificação" do
      tabela = "| # | Sigla | Time            | Pontos | Vitorias | Empates | Derrotas | Saldo de Gols | Gols Pro | Gols Contra |\n|---|-------|-----------------|--------|----------|---------|----------|---------------|----------|-------------|\n| 1 |  BAH  | Bahia           | 13     | 4        | 1       | 1        | 5             | 13       | 8           |\n| 2 |  FLA  | Flamengo        | 7      | 2        | 1       | 3        | -3            | 14       | 17          |\n| 3 |  PAM  | Palmeiras       | 6      | 1        | 3       | 2        | 0             | 11       | 11          |\n| 4 |  BFO  | Botafogo        | 6      | 1        | 3       | 2        | -2            | 15       | 17          |\n|---|-------|-----------------|--------|----------|---------|----------|---------------|----------|-------------|\n"

      expect(@camp.imprimir_classificacao).to eq(tabela)
    end
  end
end
