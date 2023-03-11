def freq(texto)
  resultado = {}
  texto.split.each do |palavra|
    resultado[palavra] ||= 0
    resultado[palavra] += 1
  end
  return resultado
end
