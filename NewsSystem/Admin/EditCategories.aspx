<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="EditCategories.aspx.cs" Inherits="NewsSystem.Admin.EditCategories" %>

<asp:Content ID="ContentBody" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView runat="server" ID="ListViewCategories"
        ItemType="NewsSystem.Models.Category"
        SelectMethod="ListViewCategories_GetData"
        DeleteMethod="ListViewCategories_DeleteItem"
        UpdateMethod="ListViewCategories_UpdateItem"
        InsertMethod="ListViewCategories_InsertItem"
        DataKeyNames="Id">
        <LayoutTemplate>
            <table class="table table-hovered table-stripped" style="width: 400px">
                <tbody>
                    <tr>
                        <th class="text-center">
                            <asp:LinkButton runat="server" ID="LinkButtonCategoryName"
                                CommandName="Sort" CommandArgument="Name" Text="Sort By Name">
                            </asp:LinkButton>
                        </th>
                    </tr>
                    <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                    <tr>
                        <td>
                            <asp:DataPager runat="server" ID="DataPagerCategories"
                                PagedControlID="ListViewCategories" PageSize="5">
                                <Fields>
                                    <asp:NumericPagerField />
                                </Fields>
                            </asp:DataPager>
                            <asp:LinkButton runat="server" ID="LinkButtonInsert"
                                Text="Insert" CssClass="btn btn-primary pull-right" OnClick="LinkButtonInsert_Click">
                            </asp:LinkButton>
                        </td>
                </tbody>
            </table>
        </LayoutTemplate>
        <ItemTemplate>
            <tr>
                <td class="text-center"><%#:Item.Name %></td>
                <td class="text-center">
                    <asp:LinkButton runat="server" ID="LinkButtonEdit" CssClass="btn btn-primary"
                        Text="Edit" CommandName="Edit">
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="LinkButtonDelete" CssClass="btn btn-danger"
                        Text="Delete" CommandName="Delete">
                    </asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <EditItemTemplate>
            <tr>
                <td class="text-center">
                    <asp:TextBox runat="server" ID="TextBoxCategoryName" Text="<%#:BindItem.Name %>">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategoryName" runat="server"
                        ErrorMessage="Name is required!" ForeColor="Red" Font-Bold="true"
                        ControlToValidate="TextBoxCategoryName" Display="Dynamic"
                        Text="*">
                    </asp:RequiredFieldValidator>
                    <asp:ValidationSummary ID="ValidationSummaryName" runat="server" DisplayMode="SingleParagraph" />
                </td>
                <td class="text-center">
                    <asp:LinkButton runat="server" ID="LinkButtonUpdate" CssClass="btn btn-success"
                        Text="Save" CommandName="Update">
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="LinkButtonCancel" CssClass="btn btn-primary"
                        Text="Cancel" CommandName="Cancel" CausesValidation="false">
                    </asp:LinkButton>
                </td>
            </tr>
        </EditItemTemplate>
        <InsertItemTemplate>
            <tr>
                <td class="text-center">
                    <asp:TextBox runat="server" ID="TextBoxCategoryNameInsert" Text="<%#:BindItem.Name %>">
                    </asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorCategoryNameInsert" runat="server"
                        ErrorMessage="Name is required!" ForeColor="Red" Font-Bold="true"
                        ControlToValidate="TextBoxCategoryNameInsert" Display="Dynamic"
                        Text="*" >
                    </asp:RequiredFieldValidator>
                    <asp:ValidationSummary ID="ValidationSummaryName" runat="server" DisplayMode="SingleParagraph" />
                </td>
                <td class="text-center">
                    <asp:LinkButton runat="server" ID="LinkButtonInsert" CssClass="btn btn-success"
                        Text="Save" CommandName="Insert">
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="LinkButtonCancel" CssClass="btn btn-danger"
                        Text="Cancel" CommandName="Cancel" CausesValidation="false">
                    </asp:LinkButton>
                </td>
            </tr>
        </InsertItemTemplate>
    </asp:ListView>
    <asp:Label runat="server" ID="LabelFaults"></asp:Label>
</asp:Content>
