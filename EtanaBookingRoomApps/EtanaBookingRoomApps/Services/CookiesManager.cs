using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace EtanaBookingRoomApps.Services
{
    public class CookiesManager
    {
        public static int createCookie(Controller controller, string key, string value)
        {
            HttpCookie newCookie = new HttpCookie(key);
            newCookie.Value = value;
            controller.ControllerContext.HttpContext.Response.Cookies.Add(newCookie);

            return 1;
        }

        public static int changeValue(Controller controller, string key, string value)
        {
            int returnOpt = -1;
            if (controller.ControllerContext.HttpContext.Response.Cookies[key] != null)
            {
                controller.ControllerContext.HttpContext.Response.Cookies[key].Value = value;
                returnOpt = 1;
            }
            return returnOpt;
        }
        public static string getValue(Controller controller, string key, bool redirectIfNotFound, string defaultValue)
        {
            string returnVal = "";
            if (controller.ControllerContext.HttpContext.Response.Cookies[key] == null)
            {
                if (redirectIfNotFound)
                {
                    //redirectToLogOff(controller);                
                }
                returnVal = defaultValue;
            }
            else
            {

                returnVal = controller.ControllerContext.HttpContext.Response.Cookies[key].Value;

            }
            return returnVal;
        }

        public static int clearCookie(Controller controller, string key)
        {

            HttpContextWrapper httpContext = new HttpContextWrapper(HttpContext.Current);
            HttpResponseBase _response = httpContext.Response;

            HttpCookie cookie = new HttpCookie(key)
            {
                Expires = DateTime.Now.AddDays(-1) // or any other time in the past
            };
            _response.Cookies.Set(cookie);
            return 1;
        }

        public static int clearAllCookies(Controller controller)
        {

            string[] cookies = controller.Request.Cookies.AllKeys;
            foreach (string cookie in cookies)
            {
                controller.Response.Cookies[cookie].Expires = DateTime.Now.AddDays(-1);
            }

            return 1;
        }
    }
}