<%@ Page Title="Article Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ArticleDetails.aspx.cs" Inherits="NewsSystem.ArticleDetails" %>

<asp:Content ID="ContentBody" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel runat="server" ID="UpdatePanelLikes" UpdateMode="Always" ChildrenAsTriggers="true">
        <ContentTemplate>
            <asp:FormView runat="server" ID="FormViewArticleDetails"
                DataKeyNames="Id"
                ItemType="NewsSystem.Models.Article"
                SelectMethod="FormViewArticleDetails_GetItem">
                <ItemTemplate>
                    <asp:Panel runat="server" ID="PanelLikeButton" ItemType="NewsSystem.Models.Article">

                        <div class="like-control col-md-1">
                            <div>Likes</div>
                            <div>
                                <asp:LinkButton runat="server" ID="HyperLinkIncrease"
                                    CssClass="btn btn-default glyphicon glyphicon-chevron-up"
                                    NavigateUrl="#" OnClick="HyperLinkIncrease_Click">
                                </asp:LinkButton>
                                <asp:Label CssClass="like-value" runat="server"
                                    ID="LabelLikes" Text="<%#:BindItem.Likes %>"></asp:Label>
                                <asp:LinkButton runat="server" ID="HyperLinkDecrease"
                                    CssClass="btn btn-default glyphicon glyphicon-chevron-down"
                                    NavigateUrl="#" OnClick="HyperLinkDecrease_Click">
                                </asp:LinkButton>
                            </div>
                        </div>

                    </asp:Panel>
                    <h2>
                        <span><%#: Item.Title %></span>
                        <small style="color: lightgray"><%#: string.Format("Category: {0}", Item.Category.Name) %></small>
                    </h2>
                    <p>
                        <%#: Item.Content %>
                    </p>
                    <p>
                        <span><%#: string.Format("Author: {0}", Item.Author.UserName) %></span>
                        <span class="pull-right"><%#: Item.DateCreated %></span>
                    </p>
                </ItemTemplate>
            </asp:FormView>
        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>
