using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace NewsSystem.Models
{
    public class Like
    {
        public int Id { get; set; }

        [Required]
        public int Value { get; set; }

    }
}