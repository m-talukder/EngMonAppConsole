using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using Microsoft.VisualBasic.Devices;
using Control = System.Windows.Forms.Control;

/************************************************************************************************************
 * Maintenance history- most recent top
 * 
 * 05/09/2013------Mohammed Talukder ------database operation changed to entity framework
 *                                         user's access time/date logged into database table: LoginRecord
 * 15/02/2013------Mohammed Talukder ------ First implemented
 * 
 ************************************************************************************************************/
namespace EngMonAppConsole
{
    public partial class LoginForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string hostName = DrpdownhostList.SelectedItem.ToString();
            string uName = txtUserName.Text;
            int authUid = -9999;
            string pWord = txtPassword.Text;
            string query = "select * from ConsoleUser where UserName='" + uName + "' AND UserPassword='" + pWord + "'";

            using (var context = new ReposEntities())
            {
                var uId =
                    context.GetUsers(userId => userId.UserName.Equals(uName) && userId.UserPassword.Equals(pWord))
                           .ToList();
                foreach (var o in uId)
                {
                    authUid = o.userId;
                }

                if (authUid != -9999)
                {
                    Session["Host"] = hostName;
                    Session["userName"] = txtUserName.Text;
                    string accessTimeUtc = DateTime.UtcNow.ToString();
                    //getLastLogin
                    var firstOrDefault = context.LoginRecords.Where(loginTime => loginTime.fk_CosoleUserID == authUid).OrderByDescending(time => time.acessTime).Select(x => new {p = x.acessTime ?? "Not Found"}).FirstOrDefault();
                    if (firstOrDefault != null)
                    {
                        var lastLoginTime =
                            firstOrDefault.p.ToString();

                        Session["lastLogin"] = lastLoginTime;
                    }
                    else
                    {
                        Session["lastLogin"] = "Not Found";
                    }

                    //write current login log
                    var newAccessLog = new LoginRecord
                        {
                        fk_CosoleUserID = authUid,
                        acessTime = accessTimeUtc,
                    };
                    context.LoginRecords.Add(newAccessLog);
                    context.SaveChanges();
                    Response.Redirect("~/Default.aspx");
                }
                else
                {
                    Label1.Visible = true;
                    Label1.Text = "Invalid username/password";
                }
            }
            //depreciated
            //SqlDataReader read = Class.DBConnection.readData(query);
            //if (read.HasRows)
            //{
            //    Session["Host"] = hostName;
            //    Session["userName"] =txtUserName.Text;
            //    while (read.Read())
            //    {
            //        uID = int.Parse(read["uID"].ToString());
            //        accessTimeUtc = DateTime.UtcNow.ToString();
            //        //
            //    }
            //    read.Close();


            //    //write access log in db
            //    var newAccessLog = new LoginRecord()
            //        {
            //            fk_CosoleUserID = uID,
            //            acessTime = accessTimeUtc,
            //        };
            //    using (var context = new EngMonAppReposEntities())
            //    {
            //        context.LoginRecords.Add(newAccessLog);
            //        context.SaveChanges();
            //    }
            //    Response.Redirect("~/Default.aspx");

            //}//End 
            //else
            //{
            //    Label1.Visible = true;
            //    Label1.Text = "Invalid username/password";
            //}

        }

        protected void txtPassword_TextChanged(object sender, EventArgs e)
        {

            //bool capsLockOn = Control.IsKeyLocked(Keys.CapsLock);
            //if (capsLockOn)
            //{
            //    txtPassword.ToolTip="CAPS Lock on";
            //    txtCapsMsg.Text = "CAPS lock ON";
            //}
        } //End event handler method for login button

        public void isCapsOn()
        {
            //bool capsLockOn = Control.IsKeyLocked(Keys.CapsLock);
            //if (capsLockOn)
            //{
            //    txtPassword.ToolTip = "CAPS Lock on";
            //    txtCapsMsg.Text = "CAPS lock ON";
            //}
        }
    }
    
}