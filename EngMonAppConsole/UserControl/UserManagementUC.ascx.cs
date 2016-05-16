using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EngMonAppConsole.UserControl
{

    public partial class UserManagementUc : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            Session["tabidhome"] = "4";

            if (!IsPostBack)
            {
                GetAllUsers();
                LoadLoginHistory();
            }
        }

        private void GetAllUsers()
        {
            using (var context = new ReposEntities())
            {
                var userList =
                    context.GetUsers(userId => !userId.UserName.Equals(""))
                           .ToList();
                GridViewAllUsers.DataSource = userList;
                // GridViewAllUsers.DataKeyNames=userList[]
                //GridViewAllUsers.
                if(!IsPostBack)
                GridViewAllUsers.DataBind();
            }
        }

        protected void GridViewAllUsers_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (GridViewAllUsers.SelectedDataKey != null)
            {
                Session["tabid"] = "1";
                Session["uID"] = GridViewAllUsers.SelectedDataKey.Value;
                LoadLoginHistory();
                Response.Redirect("~/Default.aspx#AdminTab");
            }
        }

        private void LoadLoginHistory()
        {
            int userId = int.Parse(Session["uID"].ToString());
            TextBoxDebug.Text = userId.ToString();
            try
            {
                using (var context = new ReposEntities())
                {
                    var logHistory = context.LoginRecords
                                            .Where(a => a.fk_CosoleUserID == userId)
                                            .Select(x => new
                                            {
                                                LoginTime = x.acessTime
                                            }).ToList();

                    GridViewLoginHostory.DataSource = logHistory;
                    GridViewLoginHostory.DataBind();
                }
            }
            catch (Exception ex)
            {

            }

        }

        protected void GridViewAllUsers_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                switch (e.Row.RowType)
                {
                    case DataControlRowType.Header:
                        //...
                        break;
                    case DataControlRowType.DataRow:
                        e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#93A3B0'; this.style.color='White'; this.style.cursor='pointer'");
                        //if (e.Row.RowState == DataControlRowState.Alternate)
                        //{
                        //    e.Row.Attributes.Add("onmouseout", String.Format("this.style.color='Black';this.style.backgroundColor='{0}';", GridViewAllUsers.AlternatingRowStyle.BackColor.ToArgb()));
                        //}
                        //else
                        //{
                        e.Row.Attributes.Add("onmouseout", String.Format("this.style.color='Black';this.style.backgroundColor='{0}';", "white"));
                        // }
                        // e.Row.Attributes.Add("onClick", GridViewAllUsers_SelectedIndexChanged(sender, e));
                        e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(GridViewAllUsers, "Select$" + e.Row.RowIndex.ToString()));
                        break;
                }
            }
            catch
            {
                //...throw
            }

        }

        protected void GridViewAllUsers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {

            GridViewAllUsers.PageIndex = e.NewPageIndex;
            GridViewAllUsers.DataBind();
          

        }


    }
}