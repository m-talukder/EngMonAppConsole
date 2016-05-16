using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EngMonAppConsole
{
    public partial class _Default : Page
    {
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
    
        protected void Page_Load(object sender, EventArgs e)
        {
           
            if ((Session["userName"].ToString()).Equals("visitor"))
            {
                
                Response.Redirect(url: "~/LoginForm.aspx");
            }
            else
            {
                hidtabhome.Value = "7";
                if (!Page.IsPostBack)
                {
                    Page.DataBind();

                }

            }
            if(!Page.IsPostBack)
            populateProjectTree();
           
        }

        private void populateProjectTree()
        {
            {
                /*
                * Fill the treeview control Root Nodes From Parent Table
                * and child nodes from ChildTables
                */

                /*
                * Create an SQL Connection to connect to you our database
                */
                string hostName = Session["Host"].ToString();

                SqlConnection SqlCon = Class.DBConnection.GetConnection();

                SqlCon.Open();

                /*
                * Query the database
                */

                SqlCommand SqlCmd = new SqlCommand("Select ProjectID, ProjectName,fk_HostID from Project, Host where Project.fk_HostID=Host.HostID AND(Host.HostName='"+hostName+"')", SqlCon);

                /*
                *Define and Populate the SQL DataReader
                */

                SqlDataReader Sdr = SqlCmd.ExecuteReader();

                /*
                * Dispose the SQL Command to release resources
                */

                SqlCmd.Dispose();

                /*
                * Initialize the string ParentNode.
                * We are going to populate this string array with our            ParentTable Records
                * and then we will use this string array to populate our TreeView1 Control with parent records
                */

                string[,] ParentNode = new string[100, 2];

                /*
                * Initialize an int variable from string array index
                */

                int count = 0;

                /*
                * Now populate the string array using our SQL Datareader Sdr.

                * Please Correct Code Formatting if you are pasting this code in your application.
                */

                while (Sdr.Read())
                {

                    ParentNode[count, 0] = Sdr.GetValue(Sdr.GetOrdinal("ProjectID")).ToString();
                    ParentNode[count++, 1] = Sdr.GetValue(Sdr.GetOrdinal("ProjectName")).ToString();

                }

                /*
                * Close the SQL datareader to release resources
                */

                Sdr.Close();

                /*
                * Now once the array is filled with [Parentid,ParentName]
                * start a loop to find its child module.
                * We will use the same [count] variable to loop through ChildTable
                * to find out the number of child associated with ParentTable.
                */

                for (int loop = 0; loop < count; loop++)
                {

                    /*
                    * First create a TreeView1 node with ParentName and than
                    * add ChildName to that node
                    */

                    TreeNode root = new TreeNode();
                    root.Text = ParentNode[loop, 1];
                    //root.Target = "_blank";

                   

                    /*
                    * Now that we have [ParentId] in our array we can find out child modules

                    */

                    SqlCommand Module_SqlCmd = new SqlCommand("Select JobName,fk_ProjectID from Job where fk_ProjectID =" + ParentNode[loop, 0], SqlCon);

                    SqlDataReader Module_Sdr = Module_SqlCmd.ExecuteReader();

                    while (Module_Sdr.Read())
                    {

                        // Add children module to the root node

                        TreeNode child = new TreeNode();

                        child.Text = Module_Sdr.GetValue(Module_Sdr.GetOrdinal("JobName")).ToString();
                        

                        //child.Target = "_blank";

                       // child.NavigateUrl = "Default.aspx#ProjectTab"; 

                        root.ChildNodes.Add(child);

                    }

                    Module_Sdr.Close();

                    // Add root node to TreeView
                    TreeView1.Nodes.Add(root);

                }

                /*
                * By Default, when you populate TreeView Control programmatically, it expends all nodes.
                */
                TreeView1.CollapseAll();
                
                //TreeView1.Height=300;
                SqlCon.Close();

            }
        }

        protected void ChartSummary_Load(object sender, EventArgs e)
        {

        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            HomeUpdatePanel.Update();
            DataList1.DataBind();
            GridRuningJob.DataBind();
            GridFailedJob.DataBind();
            gridDataStore.DataBind();

           
        }

        protected void drpDownSecMinSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            //read from value drop downype
            //convert to ms and store into timer interval variable 
            int val = int.Parse(drpDownValSelector.SelectedValue);
            string duration = drpDownSecMinSelector.SelectedValue.ToString();

            if (duration == "sec")
            {
                if (val < 5)
                {

                    lblMinSecMsg.Text = "minimum interval 5 sec";
                    lblMinSecMsg.Visible = true;

                    Timer1.Interval = 3000;
                    Timer1.Enabled = true;
                }
                else
                {
                    Timer1.Enabled = true;
                    lblMinSecMsg.Visible = false;
                    Timer1.Interval = val * 1000;
                    Timer1.Enabled = true;
                }
            }//end if sec

            if (duration == "min")
            {
                Timer1.Interval = val * 60 * 1000;
                Timer1.Enabled = true;
                Timer2.Interval = val * 60 * 1000;
                Timer2.Enabled = true;
            }
            if (duration == "hour")
            {
                Timer1.Interval = val * 60 * 60 * 1000;
                Timer1.Enabled = true;
                Timer2.Interval = val * 60 * 60 * 1000;
                Timer2.Enabled = true;
            }
        }

        protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
        {
            Session["job"] = TreeView1.SelectedNode.Value;
            projectTabAllJobRun.DataBind();
            LblJobName.Text = TreeView1.SelectedNode.Value;
            TreeView1.SelectedNode.NavigateUrl = ("Default.aspx#ProjectTab");

        }

        protected void projectTabAllJobRun_SelectedIndexChanged(object sender, EventArgs e)
        {
            //projectTabJobRunDetail.DataBind();
            //Label4.Text = projectTabAllJobRun.SelectedValue.ToString();
        }

        protected void ListView2_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void gridDataStore_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void GridFailedJob_RowDataBound(object sender, GridViewRowEventArgs e)
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
                        e.Row.Attributes.Add("onmouseout", String.Format("this.style.color='Black';this.style.backgroundColor='{0}';", "white"));
                        e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(GridFailedJob, "Select$" + e.Row.RowIndex.ToString()));
                        break;
                }
            }
            catch
            {
                //...throw
            }

        }

        protected void GridFailedJob_SelectedIndexChanged(object sender, EventArgs e)
        {
            more_content_failedJob.Style.Add("display", "block");
            //get jobRunId
            if (GridFailedJob.SelectedDataKey != null)
            {
                Session["jobRunId"] = GridFailedJob.SelectedDataKey.Value;
            }

            //get jobRunMessage
            string jrid = Session["jobRunId"].ToString();
            using (var context = new ReposEntities())
            {
                var jobRunMessage = context.JobRuns
                                           .Where(jr => jr.JobRunID.Equals(jrid))
                                           .Select(x => new
                                               {
                                                  RowIn=x.RowsIn,
                                                  RowOut=x.RowsOut,
                                                  ElapsedTime=x.RunDuration,
                                                  Message=x.ErrorMessage
                                               }).ToList();

                GridViewJobRunMessage.DataSource = jobRunMessage;
                GridViewJobRunMessage.DataBind();
            }
            hiddenDiv.Update();
            Timer1.Enabled = false;
        }

        protected void ButtonCloseAsp_Click(object sender, EventArgs e)
        {
            more_content_failedJob.Style.Add("display", "none");
        }

        protected void projectTabAllJobRun_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#93A3B0'; this.style.color='White'; this.style.cursor='pointer'");
            e.Row.Attributes.Add("onmouseout", String.Format("this.style.color='Black';this.style.backgroundColor='{0}';", "white"));
            e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(projectTabAllJobRun, "Select$" + e.Row.RowIndex.ToString()));
        }

        protected void gridDataStore_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#93A3B0'; this.style.color='White'; this.style.cursor='pointer'");
            e.Row.Attributes.Add("onmouseout", String.Format("this.style.color='Black';this.style.backgroundColor='{0}';", "white"));
            e.Row.Attributes.Add("onclick", Page.ClientScript.GetPostBackEventReference(gridDataStore, "Select$" + e.Row.RowIndex.ToString()));
        }



        #region evenHandler
        //protected void btnCreateUser_Click(object sender, EventArgs e)
        //{
        //    string uName = TxtUName.Text;
        //    string email = TxtEmail.Text;
        //    string pWord = TxtPassword.Text;

        //    string query = "insert into EngMonAppRepos.dbo.ConsoleUser(UserName,UserPassword,Email) values('" + uName + "','" + pWord + "','" + email + "')";

        //     int returnCode=Class.DBConnection.DataEntry(query);
        //    if(returnCode==1)
        //     LblUserCreated.Text = "User Created";
        //    else
        //        LblUserCreated.Text = "Error....";

        //    Response.Redirect("~/Default.aspx#AdminTab");
        //}

        //protected void btnChangePword_Click(object sender, EventArgs e)
        //{

        //}
        #endregion
    }
}
