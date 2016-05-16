<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CreateNewUser.ascx.cs" Inherits="EngMonAppConsole.UserControl.CreateNewUser" %>
<link href="../Content/Site.css" rel="stylesheet" />
<style>
    .alignR {
        text-align: right;
    }

    .alignL {
        text-align: left;
    }
    .fontStyle {
        color: #800000;
        font-size: x-small;
    }
</style>
<div class="contentSpan">
    <asp:Panel ID="Createuser" runat="server" Height="300px">
        <table style="width: 100%;">
            <tr>
                <td class="alignR">User Name</td>
                <td class="alignL">
                    <asp:TextBox ID="TxtUName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorUserName" runat="server" ControlToValidate="TxtUName" ErrorMessage="Enter User Name" CssClass="fontStyle"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="alignR">Email</td>
                <td class="alignL">
                    <asp:TextBox ID="TxtEmail" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ControlToValidate="TxtEmail" ErrorMessage="Enter Email" CssClass="fontStyle"></asp:RequiredFieldValidator>
                </td>

            </tr>
            <tr>
                <td class="alignR">Password</td>
                <td class="alignL">
                    <asp:TextBox ID="TxtPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldPwrdValidator" runat="server" ControlToValidate="TxtPassword" ErrorMessage="Enter Password" CssClass="fontStyle"></asp:RequiredFieldValidator>
                </td>

            </tr>
            <tr>
                <td class="alignR">Confirm Password</td>
                <td class="alignL">
                    <asp:TextBox ID="TextPWordConfirm" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:CompareValidator ID="conformPwrdValidator" runat="server" ControlToCompare="TxtPassword" ControlToValidate="TextPWordConfirm" ErrorMessage="Password do not matches" CssClass="fontStyle"></asp:CompareValidator>
                </td>

            </tr>
            <tr>
                <td></td>
                <td>

                    <asp:Button ID="btnCreateUser" runat="server" OnClick="btnCreateUser_Click" Text="Submit" />

                    <br />
                    <asp:Label ID="LblUserCreated" runat="server"></asp:Label>

                </td>

            </tr>
        </table>

        <br />

    </asp:Panel>
</div>
