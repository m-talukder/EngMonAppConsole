<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="AdminControl.ascx.cs" Inherits="EngMonAppConsole.AdminControl" %>
<%@ Register Src="~/UserControl/CreateNewUser.ascx" TagPrefix="uc1" TagName="CreateNewUser" %>
<%@ Register Src="~/UserControl/ChangePwrdUC.ascx" TagPrefix="uc1" TagName="ChangePwrdUC" %>
<%@ Register Src="~/UserControl/UserManagementUC.ascx" TagPrefix="uc1" TagName="UserManagementUC" %>

<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
<link href="Content/Site.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css" />
<style>
    .ui-widget-header {
        border: 0px solid #aaaaaa;
        background:transparent;
        color: #222222;
        font-weight: bold;
    }
    </style>
<asp:HiddenField ID="hidtab" runat="server" />
<input type="hidden" runat="server" id="currentTab" value="3"/>
<div id="innerTabs">
    <ul>
        <li><a href="#newUser">Create New Console User
            </a></li>
        <li><a href="#viewUser">User Management</a></li>
        <li><a href="#account">Account</a></li>
    </ul>
    <!--Create new user tab-->
    <div id="newUser">
        <uc1:CreateNewUser runat="server" ID="CreateNewUser" />
    </div>
    <!--User Management-->
    <div id="viewUser">
        <uc1:UserManagementUC runat="server" ID="UserManagementUC" />
    </div>
    <div id="account">
        <uc1:ChangePwrdUC runat="server" ID="ChangePwrdUC" />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $("#innerTabs").tabs({
            collapsible: true,
            active: document.getElementById('<%=hidtab.ClientID%>').value
            //beforeLoad: function (event, ui) {
            //    ui.jqXHR.error(function () {
            //        ui.panel.html("Couldn't load this tab. We'll try to fix this as soon as possible. If this wouldn't be a demo.");
        });
        });
</script>
<%--<script type="text/javascript">
    $(document).ready(function () {
  
        var setActiveTab = $get("<%=hidtab.ClientID%>").value;
    if (setActiveTab == 0) {
        $(".innerTabs").hide(); //Hide all content
        $("ul.tabs li:first").addClass("active").show(); //Activate first tab
        $(".innerTabs:first").show(); //Show first tab content
    } else {
        $(".innerTabs").hide();
        switch (setActiveTab) {
            case "#newUser":
                $("ul.tabs li:eq(0)").addClass("active").show(); $(".innerTabs:eq(0)").show();
                break;
            case "#viewUser":
                $("ul.tabs li:eq(1)").addClass("active").show(); $(".innerTabs:eq(1)").show();
                break;
            case "#account":
                $("ul.tabs li:eq(2)").addClass("active").show(); $(".innerTabs:eq(2)").show();
                break;
            
        }
    }
    //On Click Event
    $("ul.tabs li").click(function () {
        //debugger;
        $("ul.tabs li").removeClass("active"); //Remove any "active" class
        $(this).addClass("active"); //Add "active" class to selected tab
        $(".innerTabs").hide(); //Hide all tab content
        var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content
        $get("<%=hidtab.ClientID%>").value = activeTab; //Preserve Active Tab Even After PostBack
            $(activeTab).fadeIn(); //Fade in the active content
            return false;
        });

});
</script>--%>
