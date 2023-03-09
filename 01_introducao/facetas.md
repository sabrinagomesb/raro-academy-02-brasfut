# Criando programas em Ruby

A forma mais comum de se criar um programa em Ruby é através de um arquivo de texto com a extensão `.rb`. Por exemplo, vamos criar um arquivo chamado `hello.rb` com o seguinte conteúdo:

```ruby
puts "Hello World!"
puts "It is now #{Time.now}"
```

Observer que a segunda string usa interpolação de variáveis. Isso significa que o Ruby vai substituir o conteúdo da expressa `Time.now` dentro da string. O resultado será algo como:

Para executar o programa, basta digitar o seguinte comando no terminal:

```
$ ruby hello.rb
```

```
Hello World!
It is now 2017-01-01 12:00:00 -0300
```

## Obtendo ajuda

Você pode usar o comando `ri` para obter ajuda sobre um determinado método. Por exemplo, para obter ajuda sobre o método `puts`:

```
$ ri puts
```

O resultado será algo como:

```
from gem daemons-1.4.1)
=== Implementation from SyslogIO
------------------------------------------------------------------------
  puts(*texts)

------------------------------------------------------------------------

Log a complete line

Similar to {#write} but appends a newline if not present.


(from gem cocoapods-1.11.3)
=== Implementation from CoreUI
------------------------------------------------------------------------
  puts(message)

------------------------------------------------------------------------
```

# Ruby é uma linguagem 100% orientada a objetos

Em Ruby, tudo é um objeto. Isso significa que você pode chamar métodos em qualquer coisa. Por exemplo, você pode chamar o método `puts` em um número:

```ruby
puts 1
```

O resultado será:

```
1
```

Você pode chamar o método `class` em um número:

```ruby
puts 1.class
```

O resultado será:

```
Fixnum
```

Você pode chamar o método `class` em um objeto:

```ruby
puts 1.class.class
```

O resultado será:

```
Class
```

Você pode chamar o método `class` em uma classe:

```ruby
puts 1.class.class.class
```

O resultado será:

```
Module
```

Você pode chamar o método `class` em um módulo:

```ruby
puts 1.class.class.class.class
```

O resultado será:

```
Class
```
# Tipos de Dados

Quando olhamos a memória fisicamente, podemos imaginá-la como uma grande tabela endereçada, onde cada endereço cabe uma quantidade fixa de informação. Suponhamos uma arquitetura de 8-bit e que cada posição de memória guarde 1 byte. O máximo de posições que seria possível ter na memória seria de 2^8 ou 256 posições. Se pudermos armazenar 1 byte em cada posição então o máximo de memória disponível seria de 256k. Fazendo a mesma analogia para uma arquitetura de 32 bits, podemos ter memórias de até 4.096 MiB.

Os tipos de dados são convenções para tornar transparente a complexidade de gerenciar blocos de tamanhos variáveis de memória e convertê-los para um outro contexto que não seja o binário. Mais uma abstração!

Suponha que uma linguagem de programação defina que os números inteiros são de 32 bits. Logo, é necessário alocar 4 posições de memória para cada número inteiro. Da mesma forma, um tipo Long tem 64 bits e ocupa 8 posições da memória. Fazer a gestão e otimização da alocação da memória é uma tarefa complexa que normalmente é feita pelos compiladores. Assim, o programador ganha mais uma camada de abstração para aumentar sua capacidade de resolver os problemas mais próximos de sua realidade do que da realidade da máquina.


## Sistema de Tipos em Ruby 

Em Ruby, os tipos de dados são definidos de forma dinâmica. Isso significa que não é necessário declarar o tipo de uma variável antes de usá-la. O tipo de uma variável é definido no momento em que ela recebe um valor.

```ruby
a = 1
a = "Hello World"
```

No exemplo acima, a variável `a` recebeu um valor do tipo `Integer` e depois recebeu um valor do tipo `String`. O tipo da variável `a` é definido no momento em que ela recebe um valor. Isso significa que podemos fazer coisas como:

```ruby
a = 1
a = "Hello World"
a = 1 + 2
a = "Hello" + "World"
```

Ruby é uma linguagem fortemente tipada. Isso significa que não é possível fazer operações com tipos incompatíveis. Por exemplo, não é possível somar um número inteiro com uma string. O exemplo abaixo irá gerar um erro:

```ruby
a = 1
a = "Hello World"
a = 1 + "2"
```

O exemplo acima irá gerar um erro do tipo `TypeError`:

```
TypeError: String can't be coerced into Fixnum
```

O erro acima significa que não é possível converter uma string em um número inteiro. O operador `+` não sabe como somar um número inteiro com uma string. O operador `+` só sabe como somar números inteiros com outros números inteiros.

## Tipos de Dados em Ruby

Ruby possui os seguintes tipos básico de dados:

* `Integer`: Números inteiros
* `Float`: Números de ponto flutuante
* `String`: Sequência de caracteres
* `Symbol`: Um tipo especial de string
* `Boolean`: Verdadeiro ou Falso
* `Nil`: Ausência de valor
* `Array`: Coleção de objetos
* `Hash`: Coleção de pares chave-valor
* `Range`: Intervalo de valores
* `Regexp`: Expressão regular

### Integer

Tipos Integer em Ruby são objetos da class Fixnum ou Bignum. O Fixnum representa números que cabem uma palavra da máquina menos 1 bit. Quando o Fixnum excede esse tamanho ele é convertido para um objeto da classe Bignum. O Bignum representa números inteiros arbitrariamente grandes.

```ruby
a = 1
a.class
a = 10000000000
a.class
```

O exemplo acima irá gerar a seguinte saída:

```
Fixnum
Bignum
```

Números inteiros podem ser representados em decimal, hexadecimal, octal ou binário. Os números hexadecimais começam com `0x` e os octais com `0`. Os números binários começam com `0b`.

```ruby
a = 0x10
a = 010
a = 0b10
```

Outras representações de números inteiros são:

```ruby
123456                    # Fixnum
123_456                   # Fixnum (underscore ignored)
-543                      # Negative Fixnum
123_456_789_123_345_789   # Bignum
0xaabb                    # Hexadecimal
0377                      # Octal
-0b1010                   # Binary (negated)
0b001_001                 # Binary
?a                        # character code
?A                        # upper case
?\C-a                     # control a = A - 0x40
?\C-A                     # case ignored for control chars
?\M-a                     # meta sets bit 7
?\M-\C-a                  # meta and control a
```

### Ponto Flutuante
Uma literal numérica com um ponto decimal é um número de ponto flutuante. Por exemplo:

```ruby
a = 1.0
a = .1234e2 
a = 1234e-2
```


### String

Ruby prove diversas maneiras de criar strings. As strings podem ser criadas usando aspas simples, duplas ou com aspas triplas. As aspas triplas são usadas para criar strings que ocupam mais de uma linha.

A forma de declarar uma string determina por exemplo a capacidade de interpolar variáveis dentro da string. Aspas simples não permitem interpolação de variáveis. Aspas duplas permitem interpolar variáveis. Aspas triplas permitem interpolar variáveis e também permitem quebra de linha.

```ruby
a = "Hello World"
a = 'Hello World'
a = "Hello #{a}"
a = %q{Hello World}
```

Ruby também permite a utilização de strings no formato HERE document. O HERE document é uma forma de criar strings que ocupam mais de uma linha. O HERE document é definido por uma linha que começa com `<<` seguido de um identificador. O identificador pode ser qualquer palavra ou símbolo. O HERE document termina quando o identificador é encontrado novamente.

```ruby
a = <<EOF
Hello World
EOF
```

Strings são armazenadas como sequências de bytes. Cada caractere ocupa um byte. O encoding padrão de strings em Ruby é UTF-8. Strings podem ser convertidas para outros encodings.

```ruby
a = "Hello World"
a.encoding
a = a.encode("ISO-8859-1")
a.encoding
```

Toda vez que uma literal de string é atribuída a uma variável, um novo objeto é criado. Isso significa que duas variáveis que apontam para a mesma string são duas variáveis diferentes.

```ruby
a = "Hello World"
b = a
a.object_id
b.object_id
```

Outros exemplo:

```ruby 
for i in 1..3
  print 'hello'.id, " "
end
```

### Ranges

Ranges são objetos que representam um intervalo de valores. Os valores de um range podem ser números, strings ou símbolos. Os valores de um range podem ser definidos de forma inclusiva ou exclusiva. Um range definido de forma inclusiva inclui o valor inicial e o valor final. Um range definido de forma exclusiva inclui o valor inicial e não inclui o valor final.

```ruby
a = (1..10)
a = (1...10)
a = ('a'..'z')
a = ('a'...'z')
```

Ranges podem ser usados para iterar sobre uma sequência de valores.

```ruby
(1..10).each do |i|
  puts i
end
```

### Arrays

Arrays são coleções de objetos. Os objetos de um array podem ser de qualquer tipo. Os objetos de um array podem ser acessados através de seus índices. Os índices de um array começam em 0.

```ruby
a = [1, 2, 3]
a[0]
a[1]
a[2]
```

Arrays podem ser criados usando a sintaxe de colchetes ou usando a sintaxe de %w.

```ruby
a = [1, 2, 3]
a = %w{1 2 3}
```

Arrays podem ser iterados usando o método `each`.

```ruby
a = [1, 2, 3]
a.each do |i|
  puts i
end
```

### Hashes

Hashes são coleções de pares chave-valor. As chaves de um hash podem ser de qualquer tipo. Os valores de um hash podem ser de qualquer tipo. Os valores de um hash podem ser acessados através de suas chaves.

```ruby
a = { 'a' => 1, 'b' => 2, 'c' => 3 }
a['a']
a['b']
a['c']
```

Hashes podem ser criados usando a sintaxe de chaves ou usando a sintaxe de %w.

```ruby
a = { 'a' => 1, 'b' => 2, 'c' => 3 }
a = %w{a 1 b 2 c 3}
```

Hashes podem ser iterados usando o método `each`.

```ruby
a = { 'a' => 1, 'b' => 2, 'c' => 3 }
a.each do |k, v|
  puts "#{k} => #{v}"
end
```

Existe um único requisito para que um objeto possa ser usado como chave de um hash: o objeto deve implementar o método `hash`. O método `hash` deve retornar um número inteiro. O método `hash` é usado para calcular a posição de um objeto dentro de um hash.

### Symbols

Symbols são objetos imutáveis que representam um nome ou uma string. Symbols são criados usando o símbolo `:` seguido do nome do símbolo.

```ruby
a = :hello
a = :"hello world"
```

### Regexp

Regexp são objetos que representam expressões regulares. Regexp são criados usando a sintaxe de barra.

```ruby
a = /hello/
a = /hello world/
```
 Eles também podem ser criados com a sintaxe de %r.

```ruby
a = %r{hello}
a = %r{hello world}
```

## Tipos Abstratos de Dados

Normalmente, as linguagens de programação permitem que o programador crie seus próprios tipos a partir da composição dos tipos pré-existentes. Essas novas abstrações são chamadas de Tipos Abstratos de Dados, ou Tipos Definidos Pelo Usuário.

Ao criar novos tipos, o programador está fazendo abstrações mais próximas do problema que ele deseja resolver. Quando criamos uma classe, por exemplo, estamos definindo um novo tipo de dado que não existia por padrão na linguagem de programação.


# Funções e Procedimentos

Em ruby as funções são chamadas de métodos. Os métodos são definidos usando a palavra reservada `def`. O nome do método é seguido por uma lista de parâmetros entre parênteses. O corpo do método é definido entre chaves.

```ruby
def hello(name)
  puts "Hello #{name}"
end
```

O último valor de um método é o valor de retorno do método. O valor de retorno de um método pode ser definido usando a palavra reservada `return`.

```ruby
def hello(name)
  return "Hello #{name}"
end
```

O valor de retorno de um método pode ser omitido. Nesse caso, o valor de retorno do método é o valor da última expressão do método.

```ruby
def hello(name)
  "Hello #{name}"
end
```

Os caracteres ? e ! são convencionais para indicar que um método é um método de consulta ou um método de modificação. Um método de consulta retorna um valor booleano. Um método de modificação modifica o estado do objeto.

```ruby
def odd?(number)
  number % 2 == 1
end
```

```ruby
def increment!
  @number += 1
end
```

## Parâmetros

Os parâmetros de um método podem ser definidos com valores padrão. Quando um método é chamado sem passar um valor para um parâmetro, o valor padrão do parâmetro é utilizado.

```ruby
def hello(name = "World")
  puts "Hello #{name}"
end
```

### Lista de Argumentos de Tamanho Variável

Os parâmetros de um método podem ser definidos como lista de argumentos de tamanho variável. Quando um método é chamado, os argumentos de tamanho variável devem ser passados como uma lista de argumentos.

```ruby
def hello(*names)
  names.each do |name|
    puts "Hello #{name}"
  end
end
```

Dessa forma podemos chamar o método `hello` passando uma lista de argumentos ou um vetor.

```ruby
hello("Alice", "Bob", "Carol")
hello(["Alice", "Bob", "Carol"])
```
