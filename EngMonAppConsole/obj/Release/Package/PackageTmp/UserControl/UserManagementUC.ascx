<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserManagementUC.ascx.cs" Inherits="EngMonAppConsole.UserControl.UserManagementUc" %>

<link href="../Content/Site.css" rel="stylesheet" />
<link href="../Content/DataGridStyle.css" rel="stylesheet" />
<style type="text/css">
    .auto-style1 {
        border: 1px solid #868686;
        display: inline-block;
        vertical-align: top;
        text-align: left;
        width: 48%;
        height: 325px;
        margin: 5px;
        BACKGROUND-COLOR: White;
        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
        border-bottom-left-radius: 3px;
        border-bottom-right-radius: 3px;
        overflow: auto;
        scrollbar-arrow-color: green;
        scrollbar-base-color: white;
    }
</style>

<div class="auto-style1" style="width:98%; padding: 10px; height: auto">
    <asp:HiddenField ID="selected_tab" runat="server" />  
    <table style="width:100%; vertical-align: top">
        <tr style="vertical-align: top">
            <td style="width:48%">
    
    <asp:GridView ID="GridViewAllUsers" runat="server" AllowPaging="True" CssClass="gridview" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" OnRowDataBound="GridViewAllUsers_RowDataBound" OnSelectedIndexChanged="GridViewAllUsers_SelectedIndexChanged" DataKeyNames="userId" OnPageIndexChanging="GridViewAllUsers_PageIndexChanging" PageSize="20">
        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
        <SortedAscendingCellStyle BackColor="#F7F7F7" />
        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
        <SortedDescendingCellStyle BackColor="#E5E5E5" />
        <SortedDescendingHeaderStyle BackColor="#242121" />
    </asp:GridView>
            </td>
            <td>
                <asp:GridView ID="GridViewLoginHostory" runat="server" AllowPaging="True" CssClass="gridview" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal" PageSize="20">
                    <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                    <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                    <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F7F7F7" />
                    <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                    <SortedDescendingCellStyle BackColor="#E5E5E5" />
                    <SortedDescendingHeaderStyle BackColor="#242121" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            
        </tr>
        <tr>
            <td>
                <asp:TextBox ID="TextBoxDebug" runat="server" BorderStyle="None"></asp:TextBox>
            </td>
            <td>&nbsp;</td>
           
        </tr>
    </table>
    
</div>

