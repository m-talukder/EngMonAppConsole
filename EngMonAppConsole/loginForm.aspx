<%@ Page Title="" Language="C#" MasterPageFile="~/login.Master" AutoEventWireup="true" CodeBehind="loginForm.aspx.cs" Inherits="EngMonAppConsole.LoginForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        .auto-style2 {
            text-align: right;
            width: 85px;
            background: transparent;
            border: none;
            font-size: small;
            color: #ff0000;
           
        }

        .auto-style3 {
            text-align: left;
            vertical-align: middle;
            padding-left: 10px;
            padding-right: 10px;
            padding-bottom: 20px;
            
        }
    </style>

    <script src="Scripts/keyPress.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div id="Panel1" runat="server" class="loginBox">
    
        <asp:SqlDataSource ID="loginHostData" runat="server" ConnectionString="<%$ ConnectionStrings:EngMonAppReposConnectionString %>" SelectCommand="SELECT [HostName] FROM [Host]"></asp:SqlDataSource>
        
        <table style="width: 90%; margin-left: 10px; margin-right:10PX; margin-top: 20px">
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label2" runat="server" Text="Host"></asp:Label>
                </td>
                <td>

                    <asp:DropDownList ID="DrpdownhostList" runat="server" DataSourceID="loginHostData" DataTextField="HostName" DataValueField="HostName" Height="25px" Width="150px">
                    </asp:DropDownList>

                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label3" runat="server" Text="User name"></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtUserName" runat="server" Height="18px" Width="140px" ToolTip="Enter user name"></asp:TextBox>
                </td>

            </tr>
            <tr>

                <td class="auto-style3">
                    <asp:Label ID="Label4" runat="server" Text="Password"></asp:Label>
                </td>
                <td><strong>
                    <asp:TextBox ID="txtPassword" runat="server" Height="18px" TextMode="Password" Width="140px" onkeypress="isCapslock(event)" ToolTip="Enter password"></asp:TextBox>
                </strong></td>
            </tr>
            <tr style="text-align: right">

                <td class="auto-style3">
                    <input id="txtCapsMsg" type="text" aria-orientation="horizontal" style="text-align: right" class="auto-style2" /></td>
                <td ><strong>
                    <asp:Button ID="btnLogin" runat="server" BackColor="#A6B7D5" BorderColor="White" BorderStyle="Solid" Height="25px" OnClick="Button1_Click" Text="Login" Width="80px" Font-Bold="True" Font-Size="X-Small" ForeColor="Black"/>
                </strong></td>
            </tr>
            <tr>
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Label ID="Label1" runat="server" Style="text-align: center; color: #FF0000" Text="Label" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
        <br />
        <hr />
        <div style="text-align: center; height: 40px">
            <a href="help.aspx">Help</a><span> | </span><a href="mailto:mtalukder@mtalukder.net">Contact</a>
        </div>
    </div>
</asp:Content>
