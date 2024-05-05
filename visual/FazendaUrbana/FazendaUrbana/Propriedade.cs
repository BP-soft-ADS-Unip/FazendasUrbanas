using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace FazendaUrbana
{
    internal class Propriedade
    {

        public string Rua { get; set; }
        public int Numero { get; set; }
        public string Bairro { get; set; }
        public string Cidade { get; set; }
        public string Estado { get; set; }

        public string Tipo { get; set; }
        //public string Email {get; set; }
        public int Tamanho {  get; set; }
        

        public void Cadastrar_Prop()
        {
            Console.WriteLine();
        }

        public string[] lista_faz(string email)// lista de cada atributo com sua instanciação(valor) e o último é a quantidade de atributos de tipo inteiro
        {
            string[] lista = new string[]{ "rua", Rua, "bairro", Bairro, "cidade", Cidade, "estado", Estado, "tipo", Tipo, "email_proprietario", email, "numero", Numero.ToString(), "tamanho", Tamanho.ToString(), "2" };
            return lista;
        }
    }
}
