using NewsSystem.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Entity;

namespace NewsSystem.Admin
{
    public partial class EditCategories : System.Web.UI.Page
    {
        public ApplicationDbContext context;

        public EditCategories()
        {
            this.context = new ApplicationDbContext();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.ListViewCategories.InsertItemPosition = InsertItemPosition.None;
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<Category> ListViewCategories_GetData()
        {
            return this.context.Categories.OrderBy(c => c.Id);
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListViewCategories_DeleteItem(int id)
        {
            var category = this.context.Categories.Include("Articles").FirstOrDefault(c => c.Id == id);

            if (category != null)
            {
                foreach (var article in category.Articles.ToList())
                {
                    context.Articles.Remove(article);
                }

                context.Categories.Remove(category);
                context.SaveChanges();
            }
        }

        public void ListViewCategories_InsertItem()
        {
            if (Page.IsValid)
            {
                var category = new Category();
                TryUpdateModel(category);
                if (ModelState.IsValid)
                {
                    context.Categories.Add(category);
                    context.SaveChanges();
                }
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ListViewCategories_UpdateItem(int id)
        {
            if (Page.IsValid)
            {
                Category category = null;
                category = context.Categories.FirstOrDefault(c => c.Id == id);
                if (category == null)
                {
                    // The item wasn't found
                    ModelState.AddModelError("", String.Format("Category with id {0} was not found", id));
                    return;
                }
                TryUpdateModel(category);
                if (ModelState.IsValid)
                {
                    context.SaveChanges();
                }
            }
        }

        protected void LinkButtonInsert_Click(object sender, EventArgs e)
        {
            this.ListViewCategories.InsertItemPosition = InsertItemPosition.LastItem;
        }
    }
}