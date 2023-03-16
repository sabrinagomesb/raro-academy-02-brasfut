# Programação Orientada a Objetos

É um modelo de programação imperativa que consiste na abstração do mundo real por meio de classes e seus objetos.

>Instead of a bit-grinding processor raping and plundering data structures, we have a universe of well-behaved objects that courteously ask each other to carry out their various desires
>
> -- <cite>Dan Ingalls</cite>

Os objetos são compostos de atributos que representam seu estado e por métodos que representam seu comportamento.

Os objetos comunicam entre sí pela troca de mensagem. Os comportamentos alteram seu estado. 

Os objetos são definidos por classes. Uma classe define quais são os atributos e comportamentos que um objeto terá.

## Criando uma classe em Ruby

Em Ruby, uma classe é definida por utilizar a palavra chave 'class' e podemos usar métodos para definir o estado e comportamentos:

```ruby
class Musico
end
```
Os atributos da classe são representados por variáveis de instância e são prefixados com um `@`. Para se criar uma nova instância de uma classe utilizamos um método especial chamado `new`. Por padrão toda classe em Ruby tem um construtor vazio, mas podemos implementar o nosso próprio construtor definindo um método chamado 'initilize' na classe.

```ruby
class Musico
    def initialize(instrumento)
        @instrumento = instrumento
    end

    def tocar
        @instrumento.tocar
    end
end
```