<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="EngMonAppConsole._Default" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Src="~/AdminControl.ascx" TagPrefix="uc1" TagName="AdminControl" %>

<script runat=server>
    protected string defautVal(string val)
    {
        if (val == null)
            return "0";
        else
            return val;
    }
</script>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <asp:HiddenField ID="hidtabhome" runat="server" />
    <div id="tabs">
        <ul>
            <li><a href="#HomeTab">Dashboard</a></li>
            <li><a href="#ProjectTab">Project</a></li>
            <li><a href="#JobRunTab">Job Run Data Activity</a></li>
            <li><a href="#AdminTab">Administration</a></li>
           <%-- <li><a href="#anotherTab">Test Tab</a></li>--%>
        </ul>
        <!--Home Tab start-->
        <div id="HomeTab">
            <asp:Timer ID="Timer1" runat="server" OnTick="Timer1_Tick" Enabled="True" Interval="5000"></asp:Timer>

            <div class="controlPanel">
               
                <asp:Label ID="Label1" runat="server" Text="Refresh Interval  "></asp:Label>
                <div class="dropdown1" style="width: 45px">
                <asp:DropDownList ID="drpDownValSelector" runat="server" AutoPostBack="true" OnSelectedIndexChanged="drpDownSecMinSelector_SelectedIndexChanged" ToolTip="Select refresh interval">
                    <asp:ListItem>1</asp:ListItem>
                    <asp:ListItem>2</asp:ListItem>
                    <asp:ListItem>3</asp:ListItem>
                    <asp:ListItem>4</asp:ListItem>
                    <asp:ListItem>5</asp:ListItem>
                    <asp:ListItem>10</asp:ListItem>
                    <asp:ListItem>15</asp:ListItem>
                    <asp:ListItem>20</asp:ListItem>
                    <asp:ListItem Selected="True">30</asp:ListItem>
                    <asp:ListItem>45</asp:ListItem>
                    <asp:ListItem>90</asp:ListItem>
                </asp:DropDownList></div>
                 <div class="dropdown1">
                <asp:DropDownList ID="drpDownSecMinSelector" runat="server" OnSelectedIndexChanged="drpDownSecMinSelector_SelectedIndexChanged" AutoPostBack="True" ToolTip="select second/minute/hour">
                    <asp:ListItem Value="sec" Selected="True">Second</asp:ListItem>
                    <asp:ListItem Value="min">Minute</asp:ListItem>
                    <asp:ListItem Value="hour">Hour</asp:ListItem>
                </asp:DropDownList>

                <asp:Label ID="lblMinSecMsg" runat="server" Font-Size="X-Small" ForeColor="#FF0066"></asp:Label>
</div>
            </div>
            <asp:UpdateProgress AssociatedUpdatePanelID="HomeUpdatePanel" runat="server">
                <ProgressTemplate>
                    <!-- nice gif loading animation -->

                    Loading...
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:UpdatePanel ID="HomeUpdatePanel" UpdateMode="Conditional" RenderMode="Inline" runat="server">

                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Timer1" />
                </Triggers>
                <ContentTemplate>

                    <div id="HomeTopL" class="contentSpan">
                        <div class="headerDiv">Job Run Summary</div>

                        <div class="contentSpanInnerL">
                            <asp:SqlDataSource ID="home_summary_Chart" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>"
                                SelectCommand="SELECT JobRunStatus.StatusDescription, JobRunStatus.JobRunStatusID, COUNT(JobRun.JobRunID) AS total 
                                    FROM JobRun INNER JOIN JobRunStatus ON JobRun.fk_RunStatus = JobRunStatus.JobRunStatusID INNER JOIN Job ON JobRun.fk_JobID = Job.JobID INNER JOIN Project ON Job.fk_ProjectID = Project.ProjectID INNER JOIN Host ON Project.fk_HostID = Host.HostID 
                                    WHERE (JobRunStatus.JobRunStatusID != 3) AND (Host.HostName = @Host) GROUP BY JobRunStatus.StatusDescription, JobRunStatus.JobRunStatusID"
                                ProviderName="<%$ ConnectionStrings:EngMonAppReposConnectionString.ProviderName %>">
                                <SelectParameters>
                                    <asp:SessionParameter
                                        Name="Host"
                                        SessionField="Host" />
                                </SelectParameters>
                            </asp:SqlDataSource>

                            <asp:Chart ID="ChartSummary" runat="server" DataSourceID="home_summary_Chart" OnLoad="ChartSummary_Load" AlternateText="Chart Loading......" ToolTip="Summary Chart" Height="280px" Palette="None" PaletteCustomColors="0, 192, 192; 192, 0, 0">
                                <Series>
                                    <asp:Series Name="Series1" XValueMember="StatusDescription" YValueMembers="total" IsValueShownAsLabel="True">
                                    </asp:Series>
                                </Series>
                                <ChartAreas>
                                    <asp:ChartArea Name="ChartArea1">
                                        <AxisY Enabled="True">
                                            <MajorGrid LineColor="White" />
                                        </AxisY>
                                        <AxisX>
                                            <MajorGrid Enabled="False" LineColor="DarkGray" />
                                        </AxisX>
                                        <AxisX2 Enabled="False">
                                            <MajorGrid Enabled="False" />
                                            <MajorTickMark Enabled="False" />
                                        </AxisX2>
                                        <AxisY2 Enabled="False" IsLogarithmic="True" IsMarksNextToAxis="False" LineColor="White">
                                            <MajorGrid Enabled="False" />
                                            <MajorTickMark Enabled="False" />
                                        </AxisY2>
                                    </asp:ChartArea>
                                </ChartAreas>

                            </asp:Chart>
                        </div>

                        <div class="contentSpanInnerR">

                            <asp:SqlDataSource ID="running_chart" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="
                    SELECT JobRunStatus.StatusDescription, JobRunStatus.JobRunStatusID, COUNT(JobRun.JobRunID) AS total 
                    FROM JobRun INNER JOIN JobRunStatus ON JobRun.fk_RunStatus = JobRunStatus.JobRunStatusID WHERE  JobRunStatus.JobRunStatusID=3
                    GROUP BY JobRunStatus.StatusDescription, JobRunStatus.JobRunStatusID"></asp:SqlDataSource>
                            </strong>
                                <asp:DataList ID="DataList1" runat="server" DataKeyField="JobRunStatusID" DataSourceID="running_chart" ShowFooter="False">
                                    <HeaderStyle Font-Bold="False" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" ForeColor="Navy" />
                                    <HeaderTemplate>
                                        <strong>Running</strong>
                                    </HeaderTemplate>
                                    <ItemStyle Font-Bold="True" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    <ItemTemplate>
                                        <div style="height: 45px; width: 45px; background-color: red">
                                            <asp:Label ID="totalLabel" runat="server" Style="font-weight: 700; font-size: xx-large; color: #fff" Text='<%#Eval("total")%>' />
                                        </div>
                                    </ItemTemplate>
                                </asp:DataList>
                        </div>
                    </div>

                    <div id="homeTopR" class="contentSpan" style="text-align: left">
                        <div class="headerDiv">Current Job Run</div>
                        <asp:SqlDataSource ID="runningjob_list" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT JobRunStatus.StatusDescription, JobRun.RunStartTime, Job.JobName, Project.ProjectName FROM JobRun INNER JOIN Job ON JobRun.fk_JobID = Job.JobID INNER JOIN JobRunStatus ON JobRun.fk_RunStatus = JobRunStatus.JobRunStatusID INNER JOIN Project ON Job.fk_ProjectID = Project.ProjectID INNER JOIN Host ON Project.fk_HostID = Host.HostID WHERE (JobRunStatus.JobRunStatusID = 3) AND (Host.HostName = @HostID) order by JobRun.RunStartTime desc">
                            <SelectParameters>
                                <asp:SessionParameter Name="HostID" SessionField="Host" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:GridView ID="GridRuningJob" HorizontalAlign="Center" runat="server" AutoGenerateColumns="False" DataSourceID="runningjob_list" AllowPaging="True" AllowSorting="True" Width="400px" CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="gridview">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="JobName" HeaderText="Job Name" SortExpression="JobName" NullDisplayText="No Job Runnng" />
                                <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" NullDisplayText="&quot;null&quot;"></asp:BoundField>
                                <asp:BoundField DataField="RunStartTime" HeaderText="Run Start Time" SortExpression="RunStartTime" NullDisplayText="&quot;null&quot;"></asp:BoundField>
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle Font-Bold="True" />
                            <PagerStyle BackColor="#D0D1D7" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                    </div>
                    <asp:Timer ID="Timer2" runat="server" Enabled="True" Interval="5000"></asp:Timer>
                    <%--<asp:Label ID="TimeLabel" runat="server" />
                    <asp:Label ID="LblHost" runat="server" Text="Host"></asp:Label>--%>

                    <div>
                        <br>
                        <!-- Home/Dashboard bottom-->
                        <div id="homeBottomL" class="contentSpan">
                            <div class="headerDiv">
                                Failed Job Run
                            </div>
                            <asp:SqlDataSource ID="home_failedJobData" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>"
                                SelectCommand="SELECT JobRun.RunStartTime, Job.JobName, Project.ProjectName, JobRun.RunEndTime, JobRun.JobRunID FROM JobRun INNER JOIN Job ON JobRun.fk_JobID = Job.JobID INNER JOIN JobRunStatus ON JobRun.fk_RunStatus = JobRunStatus.JobRunStatusID INNER JOIN Project ON Job.fk_ProjectID = Project.ProjectID INNER JOIN Host ON Project.fk_HostID = Host.HostID WHERE (JobRunStatus.JobRunStatusID = 2) AND (Host.HostName = @Host) ORDER BY JobRun.RunEndTime DESC">
                                <SelectParameters>
                                    <asp:SessionParameter Name="Host" SessionField="Host" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <div class="auto-style2">
                                <asp:GridView ID="GridFailedJob" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="3" DataSourceID="home_failedJobData" HorizontalAlign="Center" Width="400px" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" DataKeyNames="JobRunID" OnRowDataBound="GridFailedJob_RowDataBound" OnSelectedIndexChanged="GridFailedJob_SelectedIndexChanged" CssClass="gridview">
                                    <Columns>
                                        <asp:BoundField DataField="JobName" HeaderText="Job Name" SortExpression="JobName" />
                                        <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" />
                                        <asp:BoundField DataField="RunEndTime" HeaderText="Run End Time" SortExpression="RunEndTime" />
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <HeaderStyle Font-Bold="True" />
                                    <PagerSettings PageButtonCount="5" />
                                    <PagerStyle HorizontalAlign="Right" BorderStyle="None" />
                                    <RowStyle ForeColor="#000066" HorizontalAlign="Left" VerticalAlign="Top" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#00547E" />
                                </asp:GridView>
                            </div>
                        </div>
                        <div id="homeBottomR" class="contentSpan">
                            <div class="headerDiv">ETL System Information</div>
                            <asp:FormView ID=FormView1 HorizontalAlign=Center runat="server" CellPadding="4" DataSourceID="Home_SystemInfo" ForeColor="#333333">
                                <EditItemTemplate>
                                    Host Name:
                                    <asp:TextBox ID="HostNameTextBox" runat="server" Text='<%# Bind("HostName") %>' />
                                    <br />
                                    OS:
                                    <asp:TextBox ID="OSTextBox" runat="server" Text='<%# Bind("OS") %>' />
                                    <br />
                                    Memory:
                                    <asp:TextBox ID="MemoryTextBox" runat="server" Text='<%# Bind("Memory") %>' />
                                    <br />
                                    Physical Address:
                                    <asp:TextBox ID="PhysicalAddressTextBox" runat="server" Text='<%# Bind("PhysicalAddress") %>' />
                                    <br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </EditItemTemplate>
                                <EditRowStyle BackColor="#7C6F57" />
                                <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                                <InsertItemTemplate>
                                    Host Name:
                                    <asp:TextBox ID="HostNameTextBox" runat="server" Text='<%# Bind("HostName") %>' />
                                    <br />
                                    OS:
                                    <asp:TextBox ID="OSTextBox" runat="server" Text='<%# Bind("OS") %>' />
                                    <br />
                                    Memory:
                                    <asp:TextBox ID="MemoryTextBox" runat="server" Text='<%# Bind("Memory") %>' />
                                    <br />
                                    PhysicalAddress:
                                    <asp:TextBox ID="PhysicalAddressTextBox" runat="server" Text='<%# Bind("PhysicalAddress") %>' />
                                    <br />
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <strong>Host Name:</strong>
                                    <asp:Label ID="HostNameLabel" runat="server" Text='<%# Bind("HostName") %>' />
                                    <br />
                                    <br />
                                    <strong>Physical Address: </strong>
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("PhysicalAddress") %>' />
                                    &nbsp;<br />
                                    <br />
                                    <strong>System: </strong>
                                    <asp:Label ID="OSLabel" runat="server" Text='<%# Bind("OS") %>' />
                                    <br />
                                    <br />
                                    <strong>Memory: </strong>
                                    <asp:Label ID="MemoryLabel" runat="server" Text='<%# Bind("Memory") %>' />
                                    &nbsp;MB<br />
                                    <br />
                                    <%-- <strong>PhysicalAddress: </strong>
                                    <asp:Label ID="PhysicalAddressLabel" runat="server" Text='<%# Bind("PhysicalAddress") %>' />
                                    &nbsp;<br />--%>
                                </ItemTemplate>
                                <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                                <RowStyle BackColor="#E3EAEB" />
                            </asp:FormView>
                            <asp:SqlDataSource ID="Home_SystemInfo" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT [HostName], [OS], [Memory], [PhysicalAddress] FROM [Host] WHERE ([HostName] = @HostName)">
                                <SelectParameters>
                                    <asp:SessionParameter Name="HostName" SessionField="Host" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <!--Home Tab div ends-->
        <!--Project Tab-->
        <div id="ProjectTab">
            <asp:UpdatePanel ID=UpdatePanel1 runat="server">
                <ContentTemplate>
                    <%--<div class="controlPanel">
                        Project Repository<asp:ImageButton ID="ImageButton1" runat="server" Height="20px" ImageUrl="~/Images/refresh.png" Width="30px" />
                    </div>--%>
                    <div id="projectTabL" class="projectTree" style="overflow: auto">
                        <div id="projectTreeHead" class="projectTreeHeader">
                            Project Repository
                            <%--<asp:ImageButton ID="ImageButton1" runat="server" Style="position: relative; top: 0px" AlternateText="Refresh" BackColor="#A4B5D1" BorderStyle="None" Height="25px" ImageAlign="Top" ImageUrl="~/Images/refresh1.png" Width="25px" />--%>
                        </div>
                        <asp:TreeView ID=TreeView1 Height="300px" runat="server" ImageSet="WindowsHelp" LineImagesFolder="~/TreeLineImages" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged">
                            <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
                            <LeafNodeStyle HorizontalPadding="5px" NodeSpacing="0px" />
                            <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
                            <ParentNodeStyle Font-Bold="False" VerticalPadding="0px" />
                            <RootNodeStyle Font-Bold="True" />
                            <SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" ForeColor="#5555DD" />
                        </asp:TreeView>
                    </div>

                    <div id="PrjectTabR" class="projectDetailNode">
                        <div class="ProjectDetailHeader">
                            All job Run for
                            <asp:Label ID="LblJobName" runat="server" Font-Bold="true"></asp:Label>
                        </div>
                        <div id="projectRAllJobRun" class="auto-style3">
                            <asp:GridView ID="projectTabAllJobRun" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="projectJobRunDetails" CellPadding="0" GridLines="None" CellSpacing="1" DataKeyNames="JobRunID" HorizontalAlign="Center" Width="550px" OnSelectedIndexChanged="projectTabAllJobRun_SelectedIndexChanged" CssClass="gridview" PageSize="9" OnRowDataBound="projectTabAllJobRun_RowDataBound">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="RunStartTime" HeaderText="Run Start" SortExpression="RunStartTime" />
                                    <asp:BoundField DataField="RunEndTime" HeaderText="Run End" SortExpression="RunEndTime" />
                                    <asp:BoundField DataField="StatusDescription" HeaderText="Status" SortExpression="StatusDescription" />
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle Font-Bold="True" HorizontalAlign="Right" />
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                                <PagerSettings PageButtonCount="8" />
                                <PagerStyle HorizontalAlign="Right" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Left" VerticalAlign="Top" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>
                        </div>

                        <%--<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>--%>

                        <asp:SqlDataSource ID="projectJobRunDetails" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>"
                            SelectCommand="SELECT Job.JobName, JobRun.JobRunID, JobRun.RunStartTime, JobRun.RunEndTime, JobRunStatus.StatusDescription, JobRun.RowsOut, JobRun.RowsIn FROM JobRun 
                            INNER JOIN Job ON JobRun.fk_JobID = Job.JobID INNER JOIN JobRunStatus ON JobRun.fk_RunStatus = JobRunStatus.JobRunStatusID 
                            INNER JOIN Project ON Job.fk_ProjectID = Project.ProjectID INNER JOIN Host ON Project.fk_HostID = Host.HostID WHERE (Job.JobName = @JobName) order by  JobRun.RunStartTime desc">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TreeView1" DefaultValue="" Name="JobName" PropertyName="SelectedValue" DbType="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                        <div id="projectTabRBottom" class=projectDetailInnerBottom style="overflow: auto">
                            <div class="ProjectDetailHeader">Job Run Detail</div>
                            <%-- <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>--%>
                            <asp:ListView ID="ListView1" runat="server" DataSourceID="ProjectTab_Bottom_JobRunDetail" EnableTheming="True">
                                <AlternatingItemTemplate>
                                    <td runat="server" style="background-color: #FFF8DC;">Run Duration:
                                        <asp:Label ID="RunDurationLabel" runat="server" Text='<%# Eval("RunDuration") %>' />
                                        <br />
                                        Rows In:
                                        <asp:Label ID="RowsInLabel" runat="server" Text='<%# Eval("RowsIn") %>' />
                                        <br />
                                        Rows Out:
                                        <asp:Label ID="RowsOutLabel" runat="server" Text='<%# Eval("RowsOut") %>' />
                                        <br />
                                        Message:
                                        <asp:Label ID="ErrorMessageLabel" runat="server" Text='<%# Eval("ErrorMessage") %>' ForeColor="Red" />
                                        <br />
                                        Status:
                                        <asp:Label ID="StatusDescriptionLabel" runat="server" Text='<%# Eval("StatusDescription") %>' />
                                        <br />
                                        Data Store:
                                        <asp:Label ID="DataStoreNameLabel" runat="server" Text='<%# Eval("DataStoreName") %>' />
                                        <br />
                                        isSource:
                                        <asp:Label ID="isSourceLabel" runat="server" Text='<%# Eval("isSource") %>' />
                                        <br />
                                        isTarget:
                                        <asp:Label ID="isTargetLabel" runat="server" Text='<%# Eval("isTarget") %>' />
                                        <br />
                                    </td>
                                </AlternatingItemTemplate>
                                <EditItemTemplate>
                                    <td runat="server" style="background-color: #008A8C; color: #FFFFFF;">Run Duration:
                                        <asp:TextBox ID="RunDurationTextBox" runat="server" Text='<%# Bind("RunDuration") %>' />
                                        <br />
                                        Rows In:
                                        <asp:TextBox ID="RowsInTextBox" runat="server" Text='<%# Bind("RowsIn") %>' />
                                        <br />
                                        Rows Out:
                                        <asp:TextBox ID="RowsOutTextBox" runat="server" Text='<%# Bind("RowsOut") %>' />
                                        <br />
                                        Message:
                                        <asp:TextBox ID="ErrorMessageTextBox" runat="server" Text='<%# Bind("ErrorMessage") %>' ForeColor="Red" />
                                        <br />
                                        Status:
                                        <asp:TextBox ID="StatusDescriptionTextBox" runat="server" Text='<%# Bind("StatusDescription") %>' />
                                        <br />
                                        Data Store:
                                        <asp:TextBox ID="DataStoreNameTextBox" runat="server" Text='<%# Bind("DataStoreName") %>' />
                                        <br />
                                        isSource:
                                        <asp:TextBox ID="isSourceTextBox" runat="server" Text='<%# Bind("isSource") %>' />
                                        <br />
                                        isTarget:
                                        <asp:TextBox ID="isTargetTextBox" runat="server" Text='<%# Bind("isTarget") %>' />
                                        <br />
                                        <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" />
                                    </td>
                                </EditItemTemplate>
                                <EmptyDataTemplate>
                                    <table style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;">
                                        <tr>
                                            <td>No data was returned.</td>
                                        </tr>
                                    </table>
                                </EmptyDataTemplate>
                                <InsertItemTemplate>
                                    <td runat="server" style="">Run Duration:
                                        <asp:TextBox ID="RunDurationTextBox" runat="server" Text='<%# Bind("RunDuration") %>' />
                                        <br />
                                        Rows In:
                                        <asp:TextBox ID="RowsInTextBox" runat="server" Text='<%# Bind("RowsIn") %>' />
                                        <br />
                                        Rows Out:
                                        <asp:TextBox ID="RowsOutTextBox" runat="server" Text='<%# Bind("RowsOut") %>' />
                                        <br />
                                        Message:
                                        <asp:TextBox ID="ErrorMessageTextBox" runat="server" Text='<%# Bind("ErrorMessage") %>' ForeColor="Red" />
                                        <br />
                                        Status:
                                        <asp:TextBox ID="StatusDescriptionTextBox" runat="server" Text='<%# Bind("StatusDescription") %>' />
                                        <br />
                                        Data Store:
                                        <asp:TextBox ID="DataStoreNameTextBox" runat="server" Text='<%# Bind("DataStoreName") %>' />
                                        <br />
                                        isSource:
                                        <asp:TextBox ID="isSourceTextBox" runat="server" Text='<%# Bind("isSource") %>' />
                                        <br />
                                        isTarget:
                                        <asp:TextBox ID="isTargetTextBox" runat="server" Text='<%# Bind("isTarget") %>' />
                                        <br />
                                        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                                        <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Clear" />
                                    </td>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <td runat="server" style="background-color: #DCDCDC; color: #000000;">RunDuration:
                                        <asp:Label ID="RunDurationLabel" runat="server" Text='<%# Eval("RunDuration") %>' />
                                        <br />
                                        Rows In:
                                        <asp:Label ID="RowsInLabel" runat="server" Text='<%# Eval("RowsIn") %>' />
                                        <br />
                                        Rows Out:
                                        <asp:Label ID="RowsOutLabel" runat="server" Text='<%# Eval("RowsOut") %>' />
                                        <br />
                                        Message:
                                        <asp:Label ID="ErrorMessageLabel" runat="server" Text='<%# Eval("ErrorMessage") %>' ForeColor="Red" />
                                        <br />
                                        Status:
                                        <asp:Label ID="StatusDescriptionLabel" runat="server" Text='<%# Eval("StatusDescription") %>' />
                                        <br />
                                        Data Store:
                                        <asp:Label ID="DataStoreNameLabel" runat="server" Text='<%# Eval("DataStoreName") %>' />
                                        <br />
                                        isSource:
                                        <asp:Label ID="isSourceLabel" runat="server" Text='<%# Eval("isSource") %>' />
                                        <br />
                                        isTarget:
                                        <asp:Label ID="isTargetLabel" runat="server" Text='<%# Eval("isTarget") %>' />
                                        <br />
                                    </td>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table runat="server" border="1" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;">
                                        <tr id="itemPlaceholderContainer" runat="server">
                                            <td id="itemPlaceholder" runat="server"></td>
                                        </tr>
                                    </table>
                                    <div style="text-align: center; background-color: #CCCCCC; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                    </div>
                                </LayoutTemplate>
                                <SelectedItemTemplate>
                                    <td runat="server" style="background-color: #008A8C; font-weight: bold; color: #FFFFFF;">RunDuration:
                                        <asp:Label ID="RunDurationLabel" runat="server" Text='<%# Eval("RunDuration") %>' />
                                        <br />
                                        RowsIn:
                                        <asp:Label ID="RowsInLabel" runat="server" Text='<%# Eval("RowsIn") %>' />
                                        <br />
                                        RowsOut:
                                        <asp:Label ID="RowsOutLabel" runat="server" Text='<%# Eval("RowsOut") %>' />
                                        <br />
                                        ErrorMessage:
                                        <asp:Label ID="ErrorMessageLabel" runat="server" Text='<%# Eval("ErrorMessage") %>' />
                                        <br />
                                        StatusDescription:
                                        <asp:Label ID="StatusDescriptionLabel" runat="server" Text='<%# Eval("StatusDescription") %>' />
                                        <br />
                                        DataStoreName:
                                        <asp:Label ID="DataStoreNameLabel" runat="server" Text='<%# Eval("DataStoreName") %>' />
                                        <br />
                                        isSource:
                                        <asp:Label ID="isSourceLabel" runat="server" Text='<%# Eval("isSource") %>' />
                                        <br />
                                        isTarget:
                                        <asp:Label ID="isTargetLabel" runat="server" Text='<%# Eval("isTarget") %>' />
                                        <br />
                                    </td>
                                </SelectedItemTemplate>
                            </asp:ListView>
                            <asp:SqlDataSource ID="ProjectTab_Bottom_JobRunDetail" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>"
                                SelectCommand="SELECT JobRun.RunDuration, JobRun.RowsIn, JobRun.RowsOut, JobRun.ErrorMessage, JobRunStatus.StatusDescription, DataLocation.DataStoreName, JobRunDataLocation.isSource, JobRunDataLocation.isTarget FROM JobRun INNER JOIN JobRunStatus ON JobRun.fk_RunStatus = JobRunStatus.JobRunStatusID INNER JOIN JobRunDataLocation ON JobRun.JobRunID = JobRunDataLocation.JobRunID INNER JOIN DataLocation ON JobRunDataLocation.DataLocatorID = DataLocation.locationID WHERE (JobRun.JobRunID = @JobRunID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="projectTabAllJobRun" Name="JobRunID" PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
        <!--JobRun Tab-->
        <div id="JobRunTab">

            <%-- <div class="controlPanel">Data Store Activity</div>--%>
            <asp:UpdatePanel ID=UpdatePanel2 runat="server">
                <ContentTemplate>
                    <div id="DataTabL" class="dataLeftPan" style="overflow: auto">
                        <div id="dataStoreHead" class="projectTreeHeader">
                            Data store
                         </div>
                        <div style="padding:10px">
                        <asp:GridView ID=gridDataStore runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="locationID" DataSourceID="dataTab_DataStores" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gridDataStore_SelectedIndexChanged" OnRowDataBound="gridDataStore_RowDataBound">
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                            <Columns>
                                <asp:BoundField DataField="DataStoreName" HeaderText="Sort" SortExpression="DataStoreName" ShowHeader="False" />
                            </Columns>
                            <EditRowStyle BackColor="#999999" />
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="White" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <SortedAscendingCellStyle BackColor="#E9E7E2" />
                            <SortedAscendingHeaderStyle BackColor="#506C8C" />
                            <SortedDescendingCellStyle BackColor="#FFFDF8" />
                            <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="dataTab_DataStores" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT locationID, DataStoreName FROM DataLocation WHERE (DataStoreName &lt;&gt; 'NULL') ORDER BY DataStoreName"></asp:SqlDataSource>
                    </div>
                        </div>
                    <div id="dataTabR" class="dataRightPan">
                        <div class="ProjectDetailHeader">
                            Data Extracted&nbsp;
                            <asp:Label ID="LblDataRead" runat="server" Font-Bold="True"></asp:Label>
                        </div>
                        <div id="dataRTop" class="DataTop">
                            <asp:GridView ID=GridDataRead runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="DataRead" ForeColor="#333333" GridLines="None" HorizontalAlign="Center" Width="550px" PageSize="9" CssClass="gridview">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" />
                                    <asp:BoundField DataField="JobName" HeaderText="Job Name" SortExpression="JobName" />
                                    <asp:BoundField DataField="RowsIn" HeaderText="Rows Extracted" SortExpression="RowsIn" />
                                    <asp:BoundField DataField="RunStartTime" HeaderText="Time" SortExpression="RunStartTime" />
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle Font-Bold="True" HorizontalAlign="Right" />
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Right" VerticalAlign="Middle" />
                                <PagerStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="DataRead" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT Job.JobName, JobRun.RowsIn, JobRun.RowsOut, JobRunDataLocation.DataLocatorID, JobRun.RunStartTime, DataLocation.DataStoreName, DataLocation.locationID, JobRunDataLocation.JobRunID, Job.JobID, JobRun.JobRunID AS Expr1, JobRun.fk_JobID, Job.fk_ProjectID, Project.ProjectName FROM Job INNER JOIN JobRun ON Job.JobID = JobRun.fk_JobID INNER JOIN JobRunDataLocation ON JobRun.JobRunID = JobRunDataLocation.JobRunID INNER JOIN DataLocation ON JobRunDataLocation.DataLocatorID = DataLocation.locationID INNER JOIN Project ON Job.fk_ProjectID = Project.ProjectID WHERE (JobRunDataLocation.isSource = 1) AND (JobRunDataLocation.DataLocatorID = @LcationID) ORDER BY JobRun.RunStartTime DESC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gridDataStore" Name="LcationID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                        <div class="ProjectDetailHeader">
                            Data Loaded&nbsp;
                            <asp:Label ID="LblDataWrite" runat="server" Font-Bold="True"></asp:Label>
                        </div>
                        <div id="dataRBottom" class="DataBottom">
                            <asp:GridView ID=GridDataWrite runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataSourceID="dataWriteQuery" GridLines="None" HorizontalAlign="Center" Width="600px" PageSize="9" CssClass="gridview">
                                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                <Columns>
                                    <asp:BoundField DataField="ProjectName" HeaderText="Project" SortExpression="ProjectName" />
                                    <asp:BoundField DataField="JobName" HeaderText="Job Name" SortExpression="JobName" />
                                    <asp:BoundField DataField="RowsOut" HeaderText="Rows loaded" SortExpression="RowsOut" />
                                    <asp:BoundField DataField="RunStartTime" HeaderText="Time" SortExpression="RunStartTime" />
                                </Columns>
                                <EditRowStyle BackColor="#999999" />
                                <FooterStyle Font-Bold="True" />
                                <HeaderStyle Font-Bold="True" HorizontalAlign="Right" />
                                <PagerStyle HorizontalAlign="Right" VerticalAlign="Top" />
                                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="dataWriteQuery" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT Job.JobName, JobRun.RowsOut, JobRunDataLocation.DataLocatorID, JobRun.RunStartTime, DataLocation.DataStoreName, DataLocation.locationID, JobRunDataLocation.JobRunID, Job.JobID, JobRun.JobRunID AS Expr1, JobRun.fk_JobID, Job.fk_ProjectID, Project.ProjectName, JobRunDataLocation.isTarget FROM Job INNER JOIN JobRun ON Job.JobID = JobRun.fk_JobID INNER JOIN JobRunDataLocation ON JobRun.JobRunID = JobRunDataLocation.JobRunID INNER JOIN DataLocation ON JobRunDataLocation.DataLocatorID = DataLocation.locationID INNER JOIN Project ON Job.fk_ProjectID = Project.ProjectID WHERE (JobRunDataLocation.DataLocatorID = @LcationID) AND (JobRunDataLocation.isTarget = 1) ORDER BY JobRun.RunStartTime DESC">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gridDataStore" Name="LcationID" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

      <%--     <!--Hiddendiv-->
            <div id="more_content_failedJob" runat="server" class="popupSqr" style="display: none; top:40%; background-color: rgb(60,17,160); z-index: 1003">
            <div class="closeDiv">
                <input id="ButtonClose" type="button" value="X" onclick="Toggle('more_content_failedJob')"
                     />  
                  
            </div>
          <div>
              
          </div>
          </div>--%>
        <!--Report Tab-->
        <div id="AdminTab">
            <%-- <div class="controlPanel">Adminstration</div>--%><%--<div id="adminTabPan" class="adminPan">--%>
            <uc1:AdminControl runat="server" id="AdminControl" />
        </div>
        <!-----ENdReport Tab---->
        <%--<div id="anotherTab">
            <div id="Div1" class="projectTree" style="overflow: auto">

                <asp:SqlDataSource ID="ProjectTree" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT Project.ProjectName, Job.JobName FROM Host INNER JOIN Project ON Host.HostID = Project.fk_HostID INNER JOIN Job ON Project.ProjectID = Job.fk_ProjectID WHERE (Host.HostName = 'MOHSIN-TOSH')"></asp:SqlDataSource>
                <asp:DataList ID="DataList2" runat="server" DataSourceID="ProjectTree" RepeatColumns="1" RepeatLayout="Flow" ShowFooter="False" ShowHeader="False">
                    <ItemTemplate>
                        ProjectName:
                           <asp:Label ID="ProjectNameLabel" runat="server" Text='<%# Eval("ProjectName") %>' />
                        <br />
                        JobName:
                           <asp:Label ID="JobNameLabel" runat="server" Text='<%# Eval("JobName") %>' />
                        <br />
                        <br />
                    </ItemTemplate>
                </asp:DataList>

            </div>

            <div id="Div2" class="projectDetailNode">

                <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
            </div>
        </div>--%>
     
    </div>
    <asp:UpdatePanel ID="hiddenDiv" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
         <!--Hiddendiv-->
           <div id="more_content_failedJob" runat="server" ClientIDMode="Static" class="popupSqr" style="display: none; top:70%;z-index: 1003">
            <div class="closeDiv">
                <input id="ButtonClosehiddiv" type="button" class="btnClose" value="X" onclick="Toggle('more_content_failedJob')" />  
                </div>
                <div>
                <asp:GridView ID="GridViewJobRunMessage" runat="server" CssClass="gridview" Width="380px"></asp:GridView>
                  </div>
            </div>
            </ContentTemplate>
        </asp:UpdatePanel>
</asp:Content>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="HeadContent">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
        <link href="Content/DataGridStyle.css" rel="stylesheet" />
      <link href="Content/Popup.css" rel="stylesheet" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#tabs").tabs({
                beforeLoad: function (event, ui) {
                    ui.jqXHR.error(function () {
                        ui.panel.html("Couldn't load this tab. We'll try to fix this as soon as possible. If this wouldn't be a demo.");
                    });
                }
            });

        });
 
    </script>
    
    <script>
  
        function Toggle(divid) {
            var ele = document.getElementById(divid);
            if (ele.style.display == "block") {
                ele.style.display = "none";
                document.getElementById('Timer1').disabled = false;
            } else {
              ele.style.display = "block";
                ele.focus();
            }
        }
    </script>
  
    <style>
        .ui-widget-header {
        border: 1px solid #aaaaaa;
        background:#008a8c;
        color: #222222;
        font-weight: bold;
    }
             .auto-style3
        {
            display: block;
            text-align: center; /*margin-left:5px;*/
            vertical-align: top;
            text-align: left;
            width: 100%;
            height: 360px;
            BORDER-RIGHT: #868686 1px solid;
            BORDER-TOP: #868686 1px solid;
            BORDER-BOTTOM: #868686 1px solid;
            BACKGROUND-COLOR: White;
            border-left-style: none;
            border-left-color: inherit;
            border-left-width: medium;
        }
    </style>
  
</asp:Content>


