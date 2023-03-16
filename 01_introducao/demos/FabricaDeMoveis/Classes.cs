namespace FabricaDeMoveis
{
    public class Movel
    {
        public virtual void produzir()
        {
            Console.WriteLine("Produzindo Movel");
        }
    }

    public class Cama : Movel
    {
        public override void produzir()
        {
            Console.WriteLine("Produzindo Cama");
        }

    }

    public class SofaCama : Cama
    {
        public override void produzir()
        {
            Console.WriteLine("Produzindo SofaCama");
        }

    }

    public class Cadeira : Movel { }
}