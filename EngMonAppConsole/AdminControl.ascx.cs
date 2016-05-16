using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EngMonAppConsole
{
    public partial class AdminControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           // selected_tab.Value = Request.Form[selected_tab.UniqueID];
            hidtab.Value = (string) Session["tabid"];
            currentTab.Value = (string)Session["tabid"];
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           Console.WriteLine("postback");
        }
        

//private void SelectTab(int tabNumber) {
//            var script = string.Format(@"$(document).ready( function(){{ $('.tabs').tabs( 'select', {0} ); }});", --tabNumber);
//            ScriptHelper.RegisterHeadScriptBlock(typeof(System.Web.UI.Page), "TabSelector", script, true);
 
//        }
 }
}