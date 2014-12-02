using NewsSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NewsSystem
{
    public partial class Home : System.Web.UI.Page
    {
        public ApplicationDbContext dbContext;

        public Home()
        {
            this.dbContext = new ApplicationDbContext();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<NewsSystem.Models.Article> ListViewArticles_GetData()
        {
            return this.dbContext.Articles.OrderByDescending(a => a.Likes).Take(3);
        }

        public String GetSmallerContent(string content)
        {
            return content.Substring(0, 300) + "...";
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<NewsSystem.Models.Category> ListViewCategories_GetData()
        {
            return this.dbContext.Categories;
        }

        public IEnumerable<Article> GetThreeArticles(Category category)
        {
            return category.Articles.OrderByDescending(a => a.DateCreated).Take(3);
        }
    }
}