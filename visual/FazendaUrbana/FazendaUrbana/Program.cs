// See https://aka.ms/new-console-template for more information
using System;
using System.ComponentModel.DataAnnotations;
using System.Globalization;
using Npgsql;


namespace FazendaUrbana
{
    class Program
    {
        static void Main(string[] args)
        {
            
                
            Produtor teste = new Produtor();
            teste.Email ="PAULOM@UNIP.BR"; //"MARCELINO@UNIP.BR";
            teste.Nome = "Paulo Modas";
            teste.Celular = "56369";
            teste.Senha = "abc";

            //string e_mail = "MARCELINO@UNIP.BR";
            IdbUser user = new PostgreDbUser();
            UserController bidu = new UserController(user);
            //teste = user.select(e_mail);
            bidu.save(teste);
            //teste.status();


             /*//teste2.Nome = "aparecido Paulo";
             //teste2.Email = "cidao_p@bol.com";
             //teste2.Celular = "9969822";
             //teste2.Senha = "1234";

            Propriedade farm = new Propriedade();
            farm.Rua = "Goias";
            farm.Numero = 12;
            farm.Bairro = "Campos Elisieos";
            farm.Cidade = "Serrana";
            farm.Estado = "MA";
            farm.Tipo = "HIDROPONIA";
            //farm.Email = "cidao@bol.com";
            farm.Tamanho = 33;

            

            foreach (string x in   teste2.lista_prod()) 
            {
                Console.WriteLine(x);
            }
            Console.WriteLine(teste2.lista_prod().Length);
            


            
                         teste.login();
                         //teste.status();
            //string comando_sql = "INSERT INTO PRODUTOR(EMAIL, NOME, CELULAR, SENHA) VALUES (@EMAIL, @NOME, @CELULAR, @SENHA)";
            string comando_sql = "INSERT INTO PROPRIEDADE(RUA, BAIRRO, CIDADE, ESTADO, TIPO, EMAIL_PROPRIETARIO, NUMERO, TAMANHO) VALUES (@RUA, @BAIRRO, @CIDADE, @ESTADO, @TIPO, @EMAIL_PROPRIETARIO, @NUMERO, @TAMANHO)";
            //string comando_sql = "SELECT * FROM produtor";
            BD teste = new BD(1, comando_sql);
            //teste.query(teste2.lista_prod());
            teste.query(farm.lista_faz(teste2.Email));*/






        }
    }

}
