// See https://aka.ms/new-console-template for more information
using System;
using System.Globalization;
using Npgsql;
/*
string connectionString = "Server=localhost;Port=5432;Database=fazendau;User ID=postgres;Password=9503;";
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

}
*/
namespace FazendaUrbana
{
    class Program
    {
        static void Main(string[] args)
        {
             Produtor teste2 = new Produtor();
             teste2.Nome = "JOSE";
             teste2.Email = "jose@ui";
             teste2.Celular = "4569822";
             teste2.Senha = "1234";
            /*
                         teste.login();
                         //teste.status();*/
            //string comando_sql = "INSERT INTO PRODUTOR(EMAIL, CELULAR, NOME, SENHA) VALUES (@EMAIL, @CELULAR, @NOME, @SENHA)";
            string comando_sql = "SELECT * FROM produtor";
            BD teste = new BD(2, comando_sql);
            teste.query(teste2.Email, teste2.Celular, teste2.Nome, teste2.Senha);

            




        }
    }
}

