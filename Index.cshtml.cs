using Microsoft.AspNetCore.Mvc.RazorPages;
using System;

namespace YourNamespace.Pages
{
    public class IndexModel : PageModel
    {
        public string CurrentTime { get; private set; }

        public void OnGet()
        {
            CurrentTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }
    }
}
