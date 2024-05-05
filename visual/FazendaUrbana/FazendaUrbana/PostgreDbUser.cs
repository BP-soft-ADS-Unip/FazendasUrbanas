using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Npgsql;

namespace FazendaUrbana
{
    internal class PostgreDbUser : IdbUser
    {
        public string conexao()
        {
            string connectionString = "Server=localhost;Port=5432;Database=fazendau;User ID=postgres;Password=9503;";
            return connectionString;

        }

        public void insert(Produtor farm)
        {

            NpgsqlConnection connection = new NpgsqlConnection(conexao());
            connection.Open();
            NpgsqlCommand command = new NpgsqlCommand("INSERT INTO PRODUTOR (email, nome, celular, senha) VALUES (@email, @nome, @celular, @senha)", connection);
            
            command.Parameters.AddWithValue("@email", farm.Email);
            command.Parameters.AddWithValue("@nome", farm.Nome);
            command.Parameters.AddWithValue("@celular", farm.Celular);
            command.Parameters.AddWithValue("@senha", farm.Senha);

            command.ExecuteNonQuery();

            connection.Close();


        }

        public Produtor select(string email)
        {
            string cmdsql = $"SELECT * FROM PRODUTOR WHERE EMAIL = '{email}';";
            NpgsqlConnection connection = new NpgsqlConnection(conexao());
            NpgsqlCommand command = new NpgsqlCommand(cmdsql, connection);
            connection.Open();
            Produtor fazendeiro = new Produtor();

            using (NpgsqlDataReader reader = command.ExecuteReader())
            {
                while (reader.Read())
                {

                    fazendeiro.Email = reader["email"].ToString();
                    fazendeiro.Nome = reader["nome"].ToString();
                    fazendeiro.Celular = reader["celular"].ToString();
                    fazendeiro.Senha = reader["senha"].ToString();

                    


                }
            }
            return fazendeiro;
        }
    }
}   
