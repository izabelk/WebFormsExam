using NewsSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace NewsSystem.Admin
{
    public partial class EditArticles : System.Web.UI.Page
    {
        public ApplicationDbContext dbContext;

        public EditArticles()
        {
            this.dbContext = new ApplicationDbContext();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.ListViewArticles.InsertItemPosition = InsertItemPosition.None;
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<NewsSystem.Models.Article> ListViewArticles_GetData()
        {
            return this.dbContext.Articles.OrderBy(a => a.Id);
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListViewArticles_DeleteItem(int id)
        {
            var article = this.dbContext.Articles.FirstOrDefault(a => a.Id == id);

            if (article != null)
            {
                this.dbContext.Articles.Remove(article);
                this.dbContext.SaveChanges();
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListViewArticles_UpdateItem(int id)
        {
            //if (Page.IsValid)
            //{
                Article article = null;
                article = this.dbContext.Articles.FirstOrDefault(a => a.Id == id);

                if (article == null)
                {
                    // The item wasn't found
                    ModelState.AddModelError("", String.Format("Article with id {0} was not found", id));
                    return;
                }
                TryUpdateModel(article);
                if (ModelState.IsValid)
                {
                    this.dbContext.SaveChanges();
                }
            //}
        }

        public void ListViewArticles_InsertItem()
        {
            //if (Page.IsValid)
            //{
                var article = new Article()
                {
                    DateCreated = DateTime.Now,
                    AuthorId = HttpContext.Current.User.Identity.GetUserId()
                };

                TryUpdateModel(article);
                if (ModelState.IsValid)
                {
                    this.dbContext.Articles.Add(article);
                    this.dbContext.SaveChanges();
                }
            //}
        }

        protected void LinkButtonInsert_Click(object sender, EventArgs e)
        {
            this.ListViewArticles.InsertItemPosition = InsertItemPosition.LastItem;
        }

        public String GetSmallerContent(string content)
        {
            if (content.Length < 300)
            {
                return content;
            }
            else
            {
                return content.Substring(0, 300) + "...";
            }
        }

        public IQueryable<Category> DropDownListCategories_GetData()
        {
            return this.dbContext.Categories.OrderBy(c => c.Name);
        }

    }
}