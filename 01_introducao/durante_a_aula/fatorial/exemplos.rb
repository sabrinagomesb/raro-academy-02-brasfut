def fatorial(num)
  Hash.new { |h, k| h[k] = (1..k).inject(:*) || 1 }[num]
end

def palindrome?(texto)
  texto.gsub!(/\s/, "")
  texto == texto.reverse
end

def contar_frequencia(lista)
  lista.tally
end
