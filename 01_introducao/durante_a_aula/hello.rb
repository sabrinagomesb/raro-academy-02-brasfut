def ola(*nomes)
  nomes.each do |nome|
    puts "Olá #{nome}"
  end
end

puts ola(*["Joao", "Maria", "Pedro"])
