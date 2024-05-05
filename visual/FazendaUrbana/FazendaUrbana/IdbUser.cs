using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace FazendaUrbana
{
    internal interface IdbUser
    {
        void insert(Produtor farm);
        Produtor select(string email);
    }
}
