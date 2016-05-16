using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.Entity.Infrastructure;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace EngMonAppConsole.UserControl
{
    public partial class CreateNewUser : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!Page.IsPostBack)
            LblUserCreated.Text = Session["CreateNewUserMsg"].ToString();

        }

        protected void btnCreateUser_Click(object sender, EventArgs e)
        {
            Session["tabid"] = "0";
            var uName = TxtUName.Text;
            var email = TxtEmail.Text;
            var pWord = TxtPassword.Text;
            StringBuilder errorMessages = new StringBuilder();

            var newUser = new ConsoleUser
                {
                    UserName = uName,
                    Email = email,
                    UserPassword = pWord,
                };

            try
            {
                using (var context = new ReposEntities())
                {
                    context.ConsoleUsers.Add(newUser);
                    context.SaveChanges();
                    Session["CreateNewUserMsg"] = "User: " + uName + " created successfully";
                    //LblUserCreated.Text = Session["CreateNewUserMsg"].ToString();
                    //send Email
                    Email.SendEmail(email, "",
                                    "<br/>ETL Engine Monitoring Console Login Information<br/> user name: " + uName +
                                    " <br/> password: will be sent in a seperate email<br/><br/> ETL Monitoring Console Admin",
                                    "ETL Monitoring Console");
                    Email.SendEmail(email, "",
                                    "<br/>ETL Engine Monitoring Console<br/> Password: " + pWord +
                                    "<br/><br/> ETL Monitoring Console Admin", "ETL Monitoring Console");

                }
            }
            catch (DbUpdateException ex)
            {
                Session["CreateNewUserMsg"] = "user name already exist / email address already used for another user";
                ;
                //LblUserCreated.Text = Session["CreateNewUserMsg"].ToString();
                
            }

            catch (Exception gEx)
            {
                Session["CreateNewUserMsg"] = gEx.Message;
                //LblUserCreated.Text = Session["CreateNewUserMsg"].ToString();
               
            }
            finally
            {
                Response.Redirect("~/Default.aspx#AdminTab");
            }

        }
    }
}