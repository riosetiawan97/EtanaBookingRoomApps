using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EtanaBookingRoomApps.Controllers
{
    public class LoginController : Controller
    {
        public ActionResult Index()
        {
            ViewBag.javascript = "Login.js";
            return View();
        }
        // GET: Login
        public ActionResult NoAccess()
        {
            return View();
        }
    }
}