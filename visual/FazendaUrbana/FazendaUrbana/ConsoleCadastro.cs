using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FazendaUrbana
{
    internal class ConsoleCadastro: ICadastro
    {
        public void cadastrar(Produtor farm) 
        {
            farm.Email = Console.ReadLine();
            farm
        }

        public string put_email()
        {
            Console.WriteLine("Insira o email para cadastro: ");
            string email = Console.ReadLine();
            return email;
        }
    }
}
