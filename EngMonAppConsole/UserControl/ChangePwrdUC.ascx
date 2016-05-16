<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ChangePwrdUC.ascx.cs" Inherits="EngMonAppConsole.UserControl.ChangePwrdUc" %>
<link href="../Content/Site.css" rel="stylesheet" />
<div class="contentSpan">
                <div class="headerDiv">Change Your Password</div>
                <asp:Panel ID="ChangePWrdPan" runat="server"  Height="300px">
                    &nbsp;&nbsp;
                       <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <br />
                    <table style="width: 100%;">
                        <tr>
                            <td class="auto-style4">User Name&nbsp;&nbsp;</td>

                            <td class="auto-style5">
                                <asp:TextBox ID="txtUnameChangePwrd" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style4">
                                <asp:Label ID="Label6" runat="server" Text="Old Password"></asp:Label>
                                &nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtOldPwrd" runat="server"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="auto-style4">New Password&nbsp;&nbsp;</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="TxtnewPwrd" runat="server"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="auto-style4">Confirm New Password&nbsp;&nbsp;</td>
                            <td class="auto-style5">
                                <asp:TextBox ID="txtConfirmNewPword" runat="server"></asp:TextBox>
                            </td>

                        </tr>
                        <tr>
                            <td class="auto-style4"></td>
                            <td class="auto-style5">

                                <asp:Button ID="btnChangePword" runat="server" OnClick="btnChangePword_Click" Text="Submit" />

                            </td>

                        </tr>
                    </table>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                       <br />
                    <br />
                    &nbsp;
                </asp:Panel>

            </div>
