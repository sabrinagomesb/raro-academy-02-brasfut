def fatorial(num)
  Hash.new { |h, k| h[k] = (1..k).inject(:*) || 1 }[num]
end

def palindrome?(texto)
  texto.gsub!(/\s/, "")
  texto == texto.reverse
end

def contar_frequencia(lista)
  freq = {}
  lista.each do |e|
    freq[e] ||= 0
    freq[e] = freq[e] + 1

    puts freq.inspect
  end
  return freq
end
