# Dado um texto qualquer o objetivo e saber
# as palavras que mais se repetem

require "./freq.rb"

describe "Frequencia" do
  it "Um texto vazio nao deve ter nenhuma frequência contada" do
    expect(freq("")).to eq({})
  end

  it "Cada palavra deve ter exatamente 1 de frequência" do
    expect(freq("The quick brown fox jumps over the lazy dog")).to eq({
                                                                     "The" => 1,
                                                                     "quick" => 1,
                                                                     "brown" => 1,
                                                                     "fox" => 1,
                                                                     "jumps" => 1,
                                                                     "over" => 1,
                                                                     "the" => 1,
                                                                     "lazy" => 1,
                                                                     "dog" => 1,
                                                                   })
  end

  it "A palavra casa deve ter frêquencia de 2" do
    expect(freq("Quando casa quer casa")).to eq({ "Quando" => 1, "casa" => 2, "quer" => 1 })
  end
end
