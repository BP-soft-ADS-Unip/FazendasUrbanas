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
        public UserController(IdbUser db)
        {
            DB = db;
        }


        public void save(Produtor farm)
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
        }
    }
}
