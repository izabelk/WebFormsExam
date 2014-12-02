using NewsSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewsSystem
{
    public partial class ArticleDetails : System.Web.UI.Page
    {
        public ApplicationDbContext dbContext;

        public ArticleDetails()
        {
            this.dbContext = new ApplicationDbContext();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            var isAuthenticated = HttpContext.Current.User.Identity.IsAuthenticated;
            var likeControl = this.FormViewArticleDetails.FindControl("PanelLikeButton") as Panel;

            if (isAuthenticated)
            {
               if (likeControl != null)
               {
                   likeControl.Visible = true;
               }
            }
            else
            {
                if (likeControl != null)
                {
                    likeControl.Visible = false;
                }
            }
        }

        // The id parameter should match the DataKeyNames value set on the control
        // or be decorated with a value provider attribute, e.g. [QueryString]int id
        public NewsSystem.Models.Article FormViewArticleDetails_GetItem([QueryString("id")]int? id)
        {
            if (id == null)
            {
                Response.Redirect("~/");
            }

            var article = this.dbContext.Articles.FirstOrDefault(a => a.Id == id);
            return article;
        }

        protected void HyperLinkIncrease_Click(object sender, EventArgs e)
        {
            int id = int.Parse(Request.Params["id"]);
            var article = this.dbContext.Articles.Find(id);

            if (article != null)
            {
                article.Likes++;
                dbContext.SaveChanges();
            }

            var updatePanel = this.UpdatePanelLikes;

            if (updatePanel != null)
            {
                updatePanel.Update();
            }

        }

        protected void HyperLinkDecrease_Click(object sender, EventArgs e)
        {
            int id = int.Parse(Request.Params["id"]);
            var article = this.dbContext.Articles.Find(id);

            if (article != null)
            {
                if (article.Likes > 0)
                {
                    article.Likes--;
                    dbContext.SaveChanges();
                }
            }

            var updatePanel = this.UpdatePanelLikes;

            if (updatePanel != null)
            {
                updatePanel.Update();
            }
        }
    }
}