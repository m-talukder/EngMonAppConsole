using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using EngMonAppConsole;

namespace EngMonAppConsole
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterOpenAuth();
         
           

        }

        void Application_End(object sender, EventArgs e)
        {
            //  Code that runs on application shutdown

        }

        void Application_Error(object sender, EventArgs e)
        {
            // Code that runs when an unhandled error occurs

        }

        void Session_Start(object sender, EventArgs e)
        {
            Session["lastLogin"] = "-9999";
            Session["userName"] = "visitor";
            Session["Host"] = "NULL";
            Session["job"] = "Job_2";
            Session["project"] = "null";
            Session["jobID"] = "null";
            Session["CreateNewUserMsg"] = "";
            Session["uID"] = "-999";
            Session["tabid"] = "0";
            Session["tabidhome"] = "1";
            Session["jobRunId"]="9999";
        }

    }
}
