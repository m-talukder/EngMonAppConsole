using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EngMonAppConsole.Class
{
    public class Host
    {
        string hostName;

        public string HostName
        {
            get { return hostName; }
            set { hostName = value; }
        }

        public EngMonAppConsole.LoginForm loginForm
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public Host(string hostName)
        {
            this.hostName = hostName;
        }
    }
}