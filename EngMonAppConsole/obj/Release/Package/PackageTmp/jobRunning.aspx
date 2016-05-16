<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="jobRunning.aspx.cs" Inherits="EngMonAppConsole.jobRunning" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<body>
    <form id="form1" runat="server">

            <span id="homeRight" class="contentSpan">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="runningjob_list" AllowPaging="True" AllowSorting="True" Width="543px">
                    <Columns>
                        <asp:BoundField DataField="JobName" HeaderText="Job Name" SortExpression="JobName" />
                        <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" />
                        <asp:BoundField DataField="RunStartTime" HeaderText="Run Start Time" SortExpression="RunStartTime" />
                        <asp:BoundField DataField="StatusDescription" HeaderText="Status Description" SortExpression="StatusDescription" />
                    </Columns>
            </asp:GridView>
            <asp:SqlDataSource ID="runningjob_list" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT JobRunStatus.StatusDescription, JobRun.RunStartTime, Job.JobName, Project.ProjectName FROM JobRun INNER JOIN Job ON JobRun.fk_JobID = Job.JobID INNER JOIN JobRunStatus ON JobRun.fk_RunStatus = JobRunStatus.JobRunStatusID INNER JOIN Project ON Job.fk_ProjectID = Project.ProjectID INNER JOIN Host ON Project.fk_HostID = Host.HostID WHERE (JobRunStatus.JobRunStatusID = 3)"></asp:SqlDataSource>
            </span>



    <div>
    
    </div>
    </form>
</body>
</html>
