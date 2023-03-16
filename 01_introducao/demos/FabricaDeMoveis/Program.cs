
using FabricaDeMoveis;

Movel meuMovel = new Movel();
Cama minhaCama = new Cama();
SofaCama meuSofaCama = new SofaCama();

meuMovel.produzir();
minhaCama.produzir();
meuSofaCama.produzir();

meuMovel = minhaCama;

Object cadeira = new Cadeira();
meuMovel.produzir();
minhaCama.produzir();

minhaCama = (Cama)cadeira;
