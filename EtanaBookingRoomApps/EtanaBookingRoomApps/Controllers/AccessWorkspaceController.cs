using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using EtanaBookingRoomApps.Models;
using EtanaBookingRoomApps.Services;

namespace EtanaBookingRoomApps.Controllers
{
    public class AccessWorkspaceController : Controller
    {
        public static String MainConnection = ConfigurationManager.ConnectionStrings["MainConnection"].ToString();
        // GET: AccessWorkspace
        public ActionResult Index(String Odec = "")
        {

                Result rr = new Result();

                try
                {
                    SqlConnection conn = new SqlConnection(MainConnection);
                    String sql = "LoginUser";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.Add("@NIP", Odec);
              
                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.HasRows)
                    {
                        while (dr.Read())
                        {
                            CookiesManager.createCookie(this, "Name", dr["FullName"].ToString());
                            CookiesManager.createCookie(this, "Code", dr["NIP"].ToString());
                            CookiesManager.createCookie(this, "Email", dr["Email"].ToString());
                            CookiesManager.createCookie(this, "Gender", dr["Sex"].ToString());
                            CookiesManager.createCookie(this, "Id", dr["Id"].ToString());
                            CookiesManager.createCookie(this, "Role", dr["isApprover"].ToString());
                              //Role = dr["Level"].ToString();
                            CookiesManager.createCookie(this, "IsLogin", "1");
                        }

                        rr.Message = "";
                        rr.Status = 1;
                        rr.Return = null;
                    }
                    else
                    {
                        rr.Message = "Periksa Kembali NIP Anda !";
                        rr.Status = 0;
                        rr.Return = null;
                    }

                    conn.Close();
                    conn.Dispose();
                    
                }
                catch (Exception ex)
                {

                    rr.Return = ex.Message;
                    rr.Status = 0;
                    rr.Message = ex.Message;
                }

            //return RedirectToAction("Index", "ListRooms");

            return new JsonResult()
            {
                Data = rr,
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };

        }

        public string XxxxDecrypt(string cipherText = "0")
        {
            try
            {
                string EncryptionKey = "@123Password";
                cipherText = cipherText.Replace(" ", "+");
                byte[] cipherBytes = Convert.FromBase64String(cipherText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateDecryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(cipherBytes, 0, cipherBytes.Length);
                            cs.Close();
                        }
                        cipherText = Encoding.Unicode.GetString(ms.ToArray());
                    }
                }
            }
            catch (Exception ex)
            {

                cipherText = "0";
            }


            return cipherText;

        }
        public ActionResult Logout()
        {
            CookiesManager.clearAllCookies(this);
            return RedirectToAction("Index", "Login");
        }

    }
}