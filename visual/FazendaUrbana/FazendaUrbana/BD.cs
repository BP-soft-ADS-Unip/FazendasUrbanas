using Npgsql;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;
using Npgsql.Replication.PgOutput.Messages;

namespace FazendaUrbana
{
    internal class BD
    {
        
        public string CmdSql {  get; set; }
        
        public int CrudStatus { get; set; } // 1-> create(insert), 2-> buscar(ler), 3-> editar

        //metodo construtor
        public BD(int tipo_query, string query)
        {
            CrudStatus = tipo_query;
            CmdSql = query;
            
        }    
            
        

        public void query(string Email,string Celular, String Nome, String Senha )
        {
            string connectionString = "Server=localhost;Port=5432;Database=fazendau;User ID=postgres;Password=9503;";
            NpgsqlConnection connection = new NpgsqlConnection(connectionString);
            
            connection.Open();
            int op = CrudStatus;
            NpgsqlCommand command = new NpgsqlCommand(CmdSql, connection);
            switch(op)
            {
                case 1:
                    command.Parameters.AddWithValue("@EMAIL", Email);
                    command.Parameters.AddWithValue("@celular", Celular);
                    command.Parameters.AddWithValue("@NOME", Nome);
                    command.Parameters.AddWithValue("@SENHA", Senha);

                    command.ExecuteNonQuery();

                    connection.Close();
                    break;
                case 2:
                    using (NpgsqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            // Acesse os dados da linha atual
                            Console.WriteLine(reader);
                            /*Console.WriteLine(reader["email"]);
                            Console.WriteLine(reader["celular"]);
                            Console.WriteLine(reader["nome"]);
                            Console.WriteLine(reader["senha"]);*/
                        }
                    }

                    break;
                default:
                    Console.WriteLine("Opção Inválida");
                    break;
              }

        
        }
/*
        
using (NpgsqlConnection connection = new NpgsqlConnection(connectionString))
{
    connection.Open();

    NpgsqlCommand command = new NpgsqlCommand("INSERT INTO PRODUTOR(EMAIL, CELULAR, NOME, SENHA)" +
        "VALUES (@EMAIL, @CELULAR, @NOME,@SENHA)", connection);

    command.Parameters.AddWithValue("@EMAIL", "BIA@UOL");
    command.Parameters.AddWithValue("@celular", "456897");
    command.Parameters.AddWithValue("@NOME", "beatriz");
    command.Parameters.AddWithValue("@SENHA", "12345");

    command.ExecuteNonQuery();

    connection.Close();

witch (CrudStatus)
            {
                case 1:
                    Insert(query);
                    break;
                case 2;
                    Buscar(query);
                    break;
                default:
                    Console.WriteLine("Opção Inválida");
                    break;
            }

}*/
    }
}
