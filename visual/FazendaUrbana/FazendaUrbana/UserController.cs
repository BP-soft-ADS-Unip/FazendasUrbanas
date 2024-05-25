using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FazendaUrbana
{
    internal class UserController
    {
        
        public IdbUser DB { get; set; }
        public ICadastro Cadastro { get; set; }
        public UserController(IdbUser db, ICadastro cadastro)
        {
            DB = db;
            Cadastro = cadastro;
        }


        public void save(Produtor farm)
        {
            Produtor farmi = DB.select(Cadastro.put_email());
            if (farmi.Email == null)
            {
                
            }

        }
        /*public void save(Produtor farm)
        {
            Produtor farmi = DB.select(farm.Email);
            if (farmi.Email == null)
            {
                DB.insert(farm);
                farm.status();

            }
            else
            {
                farmi.status();
            }
        }*/
    }
}
