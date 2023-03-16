# frozen_string_literal: true

require "bolao"

RSpec.describe Bolao::Campeonato do
  before(:all) do
    @campeonato = Bolao::Campeonato.new(edicao: 2023)
    @times = [
      ["América-MG", "AME"],
      ["Athletico", "ATH"],
      ["Atlético-MG", "CAM"],
      ["Bahia", "BAH"],
      ["Botafogo", "BOT"],
      ["Bragantino", "BRA"],
      ["Corinthians", "CSP"],
      ["Coritiba", "COR"],
      ["Cruzeiro", "CRU"],
      ["Cuiabá", "CUI"],
      ["Flamengo", "FLA"],
      ["Fluminense", "FLU"],
      ["Fortaleza", "FOR"],
      ["Goiás", "GOI"],
      ["Grêmio", "GRE"],
      ["Internacional", "INT"],
      ["Palmeiras", "PAL"],
      ["Santos", "SAN"],
      ["São Paulo", "SAO"],
      ["Vasco", "VAS"],
    ].map do |time|
      Bolao::Time.new(time[0], time[1])
    end

    @campeonato.times = @times
  end

  it "Montar tabela de jogos" do
    @campeonato.criar_rodadas!
    puts @campeonato.tabela
    expect(@campeonato.rodadas.size).to eq(38)
    expect(@campeonato.jogos_como_mandante("Atlético-MG").size).to eq(19)
    expect(@campeonato.jogos_como_visitante("Atlético-MG").size).to eq(19)
  end

  it "Calcular a classificacao" do
    @campeonato.jogos_como_mandante("Atlético-MG").each do |partida|
      partida.gols_mandante = 1
      partida.gols_visitante = 0
    end

    primeiro_colocado = @campeonato.classificacao.first
    expect(primeiro_colocado.time.nome).to eq("Atlético-MG")
    expect(primeiro_colocado.pontos).to eq(57)
    expect(primeiro_colocado.saldo_gols).to eq(19)
  end
end
