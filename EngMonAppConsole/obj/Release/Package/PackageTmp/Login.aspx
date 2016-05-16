<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="EngMonAppConsole.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server" style="background-image: url('Images/body-part.gif');background-size:contain;">
    <div style="height:860px; width:1340px; display: block; vertical-align:middle; text-align:center">

        <asp:Panel ID="Panel1" runat="server" BackImageUrl="~/images/headerS.gif" BorderColor="White" BorderStyle="Solid" Height="221px" style="margin-left: 270px; text-align: center;" Width="373px" CssClass="bgstrach">
            <br />
            <br />
        <br />
            <span class="style2">&nbsp;&nbsp;&nbsp; User Name&nbsp; </span>&nbsp;
            <asp:TextBox ID="txtUserName" runat="server" Height="24px" Width="195px"></asp:TextBox>
        <br />
        <br />
            <span class="style3">&nbsp;&nbsp; </span><span class="style2">Password</span><span class="style3"> </span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>
            <asp:TextBox ID="txtPassword" runat="server" Height="24px" TextMode="Password" Width="195px"></asp:TextBox>
        <br />
        <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btnLogin" runat="server" BackColor="#8EB528" BorderColor="White" BorderStyle="Ridge" Height="28px" onclick="Button1_Click" style="margin-left: 33px" Text="Login" Width="90px" />
            &nbsp;&nbsp;&nbsp;
        <br />
        <br />
            </strong>
            <asp:Label ID="Label1" runat="server" Text="Label" Visible="False"></asp:Label>
        </asp:Panel>

    
       
       
    
    </div>
    </form>
</body>
</html>
