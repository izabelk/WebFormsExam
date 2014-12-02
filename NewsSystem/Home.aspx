<%@ Page Title="News" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="NewsSystem.Home" %>

<asp:Content ID="ContentBody" ContentPlaceHolderID="MainContent" runat="server">
    <h1><%: this.Title %></h1>
    <br />
    <h2>Most popular articles</h2>

    <asp:ListView runat="server" ID="ListViewArticles"
        DataKeyNames="Id" ItemType="NewsSystem.Models.Article"
        SelectMethod="ListViewArticles_GetData" GroupItemCount="1">
        <GroupTemplate>
            <div class="row">
                <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
            </div>
        </GroupTemplate>
        <ItemTemplate>
            <div class="col-md-12">
                <h2>
                    <asp:HyperLink runat="server"
                        NavigateUrl='<%# string.Format("~/ArticleDetails.aspx?id={0}", Item.Id) %>'
                        Text="<%#:Item.Title %>">
                    </asp:HyperLink>
                    <small><%#: Item.Category.Name %></small>
                </h2>
                <asp:Panel runat="server" ID="PanelArticleContent"><%#: GetSmallerContent(Item.Content) %></asp:Panel>
                <br />
                <p><%#: string.Format("Likes: {0}", Item.Likes) %></p>
                <p><i><%#: string.Format(@"by {0} created on: {1}", 
                                  Item.Author.UserName, Item.DateCreated ) %></i></p>
            </div>
        </ItemTemplate>
    </asp:ListView>

    <h2>All categories</h2>

     <asp:ListView runat="server" ID="ListViewCategories"
        DataKeyNames="Id" ItemType="NewsSystem.Models.Category"
        SelectMethod="ListViewCategories_GetData" GroupItemCount="2">
        <GroupTemplate>
            <div class="row">
                <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
            </div>
        </GroupTemplate>
        <ItemTemplate>
            <div class="col-md-6">
                <h2><%#: Item.Name %></h2>
                <asp:Listview runat="server" ID="ListViewBooks"
                    ItemType="NewsSystem.Models.Article"
                    DataSource="<%# GetThreeArticles(Item) %>">
                    <LayoutTemplate>
                        <ul>
                            <asp:PlaceHolder runat="server" ID="itemPlaceHolder"></asp:PlaceHolder>
                        </ul>
                    </LayoutTemplate>
                    <ItemTemplate>
                       <li>
                           <asp:HyperLink NavigateUrl='<%# string.Format("~/ArticleDetails.aspx?id={0}", Item.Id) %>' 
                               runat="server" 
                               Text='<%# string.Format(@"{0} by <i>{1}</i>", Item.Title, Item.Author.UserName) %>' />
                       </li>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        No articles.
                    </EmptyDataTemplate>
                </asp:Listview>
            </div>
        </ItemTemplate>
    </asp:ListView>

</asp:Content>
