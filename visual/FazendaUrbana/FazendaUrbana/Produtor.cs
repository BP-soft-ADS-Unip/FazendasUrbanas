using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FazendaUrbana
{
	internal class Produtor
	{
		public string Email { get; set; }
		public string Nome { get; set; }
		public string Celular { get; set; }
		public string Senha { get; set; }

		public void status()
			{
				Console.WriteLine("Nome: {0}", Nome);
				Console.WriteLine("Email: {0}", Email);
				Console.WriteLine("Celular: {0}", Celular);
			}

		public int login()
		{
			int i = 0;
			while (i < 3)
			{
                Console.WriteLine("Entre com Email: ");
				string email = Console.ReadLine();
				if (Email.Equals(email))
				{
                    Console.WriteLine("Entre com a senha");
					break;
                }
				else
				{
					Console.WriteLine("Erro!!!!\nEmail inexistente!!!");
					i++;
				}
			}
			if (i == 3)
				return 0;
			i = 0;
			while (i < 3)
			{
				string senha = Console.ReadLine();
				if (Senha.Equals(senha))
				{
					Console.WriteLine("Você está Logado");
					this.status();
					break;
				}
				else
				{
					Console.WriteLine("Senha Incorreta");
					i++;
				}
			}
			if (1 == 3)
				Console.WriteLine("Login Cancelado!!!");
			return 1;
				
			
				
            
			
		}


	}

	
}


