require "./exemplos.rb"

describe "Palindrome" do
  # Um cenario uma palavra que eh
  it "A palavra é um palíndrome" do
    expect(palindrome?("arara")).to eq(true)
  end

  it "A palavra nao é um palíndrome" do
    expect(palindrome?("banana")).to eq(false)
  end

  it "A frase é um palíndrome" do
    expect(palindrome?("subi no onibus")).to eq(true)
  end

  it "A frase que não é um palíndrome" do
    expect(palindrome?("Arara gosta de banana")).to eq(false)
  end

  it "Uma string vazia é um palíndrome" do
    expect(palindrome?("")).to eq(true)
  end
end

describe "Frequencia" do
  it "Vetor/Lista/Array vazio" do
    expect(contar_frequencia([])).to eq({})
  end

  it "Um unico elemento" do
    expect(contar_frequencia([22])).to eq({ 22 => 1 })
  end

  it "Multiplas frequencias" do
    expect(contar_frequencia([22, 1, 22, 5])).to eq({ 22 => 2, 1 => 1, 5 => 1 })
  end
end
