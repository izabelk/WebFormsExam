<%@ Page Title="Edit Articles" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditArticles.aspx.cs" Inherits="NewsSystem.Admin.EditArticles" %>

<asp:Content ID="ContentBody" ContentPlaceHolderID="MainContent" runat="server">

    <asp:ListView runat="server" ID="ListViewArticles"
        ItemType="NewsSystem.Models.Article"
        SelectMethod="ListViewArticles_GetData"
        DeleteMethod="ListViewArticles_DeleteItem"
        UpdateMethod="ListViewArticles_UpdateItem"
        InsertMethod="ListViewArticles_InsertItem"
        DataKeyNames="Id">
        <LayoutTemplate>
            <div class="row">
                <asp:LinkButton runat="server" CssClass="col-md-2 btn btn-default"
                    ID="LinkButtonArticleTitle" CommandName="Sort"
                    CommandArgument="Title" Text="Sort By Title">
                </asp:LinkButton>
                <asp:LinkButton runat="server" CssClass="col-md-2 btn btn-default"
                    ID="LinkButtonArticleDate" CommandName="Sort"
                    CommandArgument="DateCreated" Text="Sort By Date">
                </asp:LinkButton>
                <asp:LinkButton runat="server" CssClass="col-md-2 btn btn-default"
                    ID="LinkButtonArticleCategoryName" CommandName="Sort"
                    CommandArgument="Category.Name" Text="Sort By Category">
                </asp:LinkButton>
                <asp:LinkButton runat="server" CssClass="col-md-2 btn btn-default"
                    ID="LinkButtonArticleLikes" CommandName="Sort"
                    CommandArgument="Likes" Text="Sort By Likes">
                </asp:LinkButton>
            </div>
            <div class="row">
                <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
            </div>
            <div class="row">
                <asp:DataPager runat="server" ID="DataPagerCategories"
                    PagedControlID="ListViewArticles" PageSize="5">
                    <Fields>
                        <asp:NumericPagerField />
                    </Fields>
                </asp:DataPager>
                <asp:LinkButton runat="server" ID="LinkButtonInsert"
                    Text="Insert New Article" CssClass="btn btn-primary pull-right" OnClick="LinkButtonInsert_Click">
                </asp:LinkButton>
            </div>
        </LayoutTemplate>
        <ItemTemplate>
            <div class="row">
                <h3>
                    <span><%#: Item.Title %></span>
                    <asp:LinkButton runat="server" ID="LinkButtonEdit" CssClass="btn btn-primary"
                        Text="Edit" CommandName="Edit">
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="LinkButtonDelete" CssClass="btn btn-danger"
                        Text="Delete" CommandName="Delete">
                    </asp:LinkButton>
                </h3>
                <p><%#:string.Format("Category: {0}", Item.Category.Name) %></p>
                <p><%#: GetSmallerContent(Item.Content)  %></p>
                <p><%#: string.Format("Likes: {0}", Item.Likes) %></p>
                <div>
                    <p>
                        <i><%#: string.Format(@"by {0} created on: {1}", 
                                  Item.Author.UserName, Item.DateCreated ) %></i>
                    </p>
                </div>
            </div>
        </ItemTemplate>
        <EditItemTemplate>
            <div class="row">
                <h3>
                    <asp:TextBox runat="server" ID="TextBoxTitleEdit" Text="<%#: BindItem.Title %>"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditTitle" runat="server"
                        ErrorMessage="Title is required!" Display="Dynamic" Text="*"
                        ForeColor="Red" Font-Bold="true"
                        EnableViewState="false"
                        ControlToValidate="TextBoxTitleEdit">
                    </asp:RequiredFieldValidator>
                    <asp:ValidationSummary runat="server" ID="ValidationSummaryTitle" />
                    <asp:LinkButton runat="server" ID="LinkButtonEdit" CssClass="btn btn-success"
                        Text="Save" CommandName="Update">
                    </asp:LinkButton>
                    <asp:LinkButton runat="server" ID="LinkButtonCancel" CssClass="btn btn-danger"
                        Text="Cancel" CommandName="Cancel" CausesValidation="false">
                    </asp:LinkButton>
                </h3>
                <asp:DropDownList runat="server" ID="DropDownListCategories" DataTextField="Name"
                    DataValueField="Id" ItemType="NewsSystem.Models.Category"
                    SelectedValue="<%#: BindItem.CategoryId %>"
                    SelectMethod="DropDownListCategories_GetData">
                </asp:DropDownList>
                <br />
                <br />
                <asp:TextBox runat="server" ID="TextBoxContentEdit" Width="100%" Height="100%" CssClass="overflow"
                    TextMode="MultiLine" Text="<%#:BindItem.Content %>"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEditContent" runat="server"
                    ErrorMessage="Content is required!" Display="Dynamic" Text="*"
                    ForeColor="Red" Font-Bold="true" 
                    EnableViewState="false"
                    ControlToValidate="TextBoxContentEdit">
                </asp:RequiredFieldValidator>
                <asp:ValidationSummary runat="server" ID="ValidationSummaryContentEdit" />
            </div>
        </EditItemTemplate>
        <InsertItemTemplate>
            <div class="row">
                <h3>Title:
                    <asp:TextBox runat="server" ID="TextBoxTitleInsert" Text="<%#: BindItem.Title %>"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorInsertTitle" runat="server"
                        ErrorMessage="Title is required!" Display="Dynamic"
                        EnableViewState="false" Text="*"
                        ForeColor="Red" Font-Bold="true"
                        ControlToValidate="TextBoxTitleInsert">
                    </asp:RequiredFieldValidator>
                    <asp:ValidationSummary runat="server" ID="ValidationSummaryTitle" />
                </h3>
                Category:
                <asp:DropDownList runat="server" ID="DropDownListCategories" DataTextField="Name"
                    DataValueField="Id" ItemType="NewsSystem.Models.Category"
                    SelectedValue="<%#: BindItem.CategoryId %>"
                    SelectMethod="DropDownListCategories_GetData">
                </asp:DropDownList>
                <br />
                <br />
                Content:
                <asp:TextBox runat="server" ID="TextBoxContentInsert"
                    TextMode="MultiLine" Text="<%#:BindItem.Content %>"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorInsertContent" runat="server"
                    ErrorMessage="Content is required!" EnableViewState="false"
                    Display="Dynamic" Text="*"
                    ForeColor="Red" Font-Bold="true"
                    ControlToValidate="TextBoxContentInsert">
                </asp:RequiredFieldValidator>
                <asp:ValidationSummary runat="server" ID="ValidationSummaryContentInsert" />
                <asp:LinkButton runat="server" ID="LinkButtonEdit" CssClass="btn btn-success"
                    Text="Save" CommandName="Insert">
                </asp:LinkButton>
                <asp:LinkButton runat="server" ID="LinkButtonCancelInsert" CssClass="btn btn-danger"
                    Text="Cancel" CommandName="Cancel" CausesValidation="false">
                </asp:LinkButton>
            </div>
        </InsertItemTemplate>
    </asp:ListView>

</asp:Content>