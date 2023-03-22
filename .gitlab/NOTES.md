Calcular o número de rodadas necessárias:

- O número de rodadas necessárias é igual a 2 * (equipes.size - 1).
- Cada rodada deve ter equipes.size / 2 partidas.
- Gerar as partidas para cada rodada:
  - Para gerar as partidas para cada rodada, podemos usar um algoritmo chamado Round-Robin.
  - O algoritmo Round-Robin é usado para gerar um conjunto de partidas em que cada equipe joga uma vez contra cada uma das outras equipes.
  - Para aplicar o algoritmo Round-Robin, podemos usar a seguinte estratégia:
    - Dividir as equipes em duas metades: mandantes e visitantes.
    - Para cada rodada, gerar as partidas fazendo a combinação de equipes mandantes e visitantes da seguinte forma:
    - Na primeira rodada, as equipes da metade dos mandantes jogam em casa.
    - Nas rodadas seguintes, as equipes da metade dos visitantes jogam em casa.
    - Cada equipe joga uma vez como mandante e outra como visitante.
  
    - Se o número de equipes for ímpar, podemos adicionar uma equipe fictícia que não joga e não é exibida na tabela, para que as rodadas sejam geradas corretamente.

    - Adicionar as partidas e as rodadas ao campeonato:
    - Para cada rodada, criar uma instância da classe Rodada e adicionar as partidas geradas à propriedade partidas da rodada.
    - Adicionar cada rodada à propriedade rodadas do campeonato.

```ruby
def criar_rodadas!
    # Define o número de rodadas
    num_rodadas = @equipes.size - 1
    
    # Cria um array de equipes para as rodadas
    equipes_rodadas = @equipes.dup
    equipes_rodadas << Equipe.new("Bye", "-") if equipes_rodadas.size.odd?
    
    # Divide o array de equipes em duas partes
    mandantes = equipes_rodadas[0, equipes_rodadas.size / 2]
    visitantes = equipes_rodadas - mandantes
    
    # Cria as rodadas e as partidas
    num_rodadas.times do |r|
      rodada = Rodada.new(r + 1)
      
      mandantes.zip(visitantes.reverse).each do |mandante, visitante|
        partida = Partida.new(mandante, visitante)
        rodada.partidas << partida
        @partidas << partida
      end
      
      @rodadas << rodada
      
      # Faz a rotação das equipes mandantes e visitantes
      mandantes.unshift(visitantes.shift)
      visitantes << mandantes.pop
    end
  end
```


Gerar a tabela do campeonato:
Para gerar a tabela do campeonato, podemos criar uma instância da classe Tabela e passar as equipes e as partidas como argumentos.

A classe Tabela pode ter um método gerar que calcula os pontos de cada equipe, ordena a classificação por pontos e retorna a tabela em formato de texto ou HTML.
Abaixo está uma possível implementação dos métodos criar_rodadas! e criar_tabela!

```ruby
  def criar_tabela!
    classificacao.each_with_index do |classif, i|
      puts "#{i+1}. #{classif.equipe.nome} - #{classif.pontos} pontos"
    end
  end
```

| | Sigla | Time        | Pontos | Vitorias | Empates | Derrotas | Saldo de Gols | Gols Pro | Gols Contra |
|---|-------|-------------|--------|----------|---------|----------|---------------|----------|-------------|
| 1 | CAM   | Atletico-MG | 18     | 3        | 1       | 0        | 20            | 22       | 2           |
| 2 | VAS   | Vasco       | 12     | 1        | 3       | 2        | -4            | 4        | 8           |
Modifique o projeto para ter as informações necessárias para a geração da tabela

 def imprimir_tabela_terminal
    rodadas = @rodadas_ida + @rodadas_volta
    rows = []

    rodadas.each do |rodada|
      rows << :separator
      rows << ["RODADA #{rodada.numero}"]
      rows << :separator

      rodada.partidas.each do |partida|
        rows << [
          partida.mandante.sigla,
          partida.visitante.sigla,
        ]
      end
    end

    table = Terminal::Table.new :rows => rows
    puts table
  end