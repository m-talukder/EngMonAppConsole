using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EngMonAppConsole
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;

        public EngMonAppConsole.Class.Host Host
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        public _Default _Default
        {
            get
            {
                throw new System.NotImplementedException();
            }
            set
            {
            }
        }

        protected void Page_Init(object sender, EventArgs e)
        {
            
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            lblUserName.Text = (string)Session["userName"];
            lblLastLogin.Text = ", Last Login: "+(string) Session["lastLogin"];
           // try
            //{
               // if (hostMenu.SelectedValue.ToString() == null)
                //{
                  // hostMenu.SelectedIndex = 1;
            if (Page.IsPostBack)
                Session["Host"] = hostMenu.SelectedValue;
            else
                hostMenu.SelectedValue = Session["Host"].ToString();
               // }
               // else
               // {
                 //   Session["Host"] = "unbound host";
               // }
           // }
            //catch (Exception ex)
           // {
               // Session["Host"] = "unbound Host";
           // }

            //hostMenu.SelectedItem.Text = "MOHSIN-TOSH";//Session["Host"].ToString();
           // hostMenu.SelectedIndex = hostMenu.Items.IndexOf(hostMenu.Items.FindByValue(Session["Host"].ToString()));
           // hostMenu.DataBinding += hostMenu_DataBinding;
            
        }

        void hostMenu_DataBinding(object sender, EventArgs e)
        {
            foreach (var item in hostMenu.Items)
            {
                if(item.Equals(Session["Host"]))
                    hostMenu.SelectedValue = Session["Host"].ToString();
            }
        }

        protected void hostMenu_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if (hostMenu.SelectedValue.ToString() != null)
                    Session["Host"] = hostMenu.SelectedItem.Text;
                else
                    Session["Host"] = "unbound host";
            }
            catch (Exception ex)
            {
                Session["Host"] = "unbound Host";
            }
            Response.Redirect("~/Default.aspx");

        }

        //protected void ButtonLogout_Click(object sender, EventArgs e)
        //{
        //    Session["lastLogin"] = "-9999";
        //    Session["userName"] = "visitor";
        //    Session["Host"] = "NULL";
        //    Session["job"] = "null";
        //    Session["project"] = "null";
        //    Session["jobID"] = "null";
        //    Response.Redirect("~/Default.aspx");
        //}

        protected void ButtonLogout_Click1(object sender, EventArgs e)
        {
            Session["lastLogin"] = "-9999";
            Session["userName"] = "visitor";
            Session["Host"] = "NULL";
            Session["job"] = "null";
            Session["project"] = "null";
            Session["jobID"] = "null";
            Response.Redirect("~/Default.aspx");

        }
    }
}