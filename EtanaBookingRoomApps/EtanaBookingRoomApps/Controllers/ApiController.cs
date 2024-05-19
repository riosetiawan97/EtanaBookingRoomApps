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
using Newtonsoft.Json;

namespace EtanaBookingRoomApps.Controllers
{
    public class ApiController : Controller
    {
        // GET: Api
        public static String MainConnection = ConfigurationManager.ConnectionStrings["MainConnection"].ToString();

        public string Encrypt(string clearText = "0")
        {
            try
            {
                string EncryptionKey = "@123Password";
                byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (MemoryStream ms = new MemoryStream())
                    {
                        using (CryptoStream cs = new CryptoStream(ms, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                        {
                            cs.Write(clearBytes, 0, clearBytes.Length);
                            cs.Close();
                        }
                        clearText = Convert.ToBase64String(ms.ToArray());
                    }
                }
            }
            catch (Exception ex)
            {

                clearText = "0";
            }

            return clearText;


        }


        public string Decrypt(string cipherText = "0")
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



        public void InsertSessionBookingRoom(
            String IdBookingRooms = "",
            String IdSessionTime = ""
            ) {

            SqlConnection conn = new SqlConnection(MainConnection);
            String sql = "[TransactionRooms]";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@Param", "InsertSessionBookingRoom");
            cmd.Parameters.Add("@IdBookingRooms", IdBookingRooms);
            cmd.Parameters.Add("@IdSessionTime", IdSessionTime);
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            conn.Dispose();
        }



        public ActionResult LoopInsertSessionBookingRoom(String obj)
        {
            Result rr = new Result();
            try
            {
                dynamic dynJson = JsonConvert.DeserializeObject(obj);
                foreach (var item in dynJson)
                {

                    InsertSessionBookingRoom(
item.IdBookingRooms.ToString(),
item.IdSessionTime.ToString()
);

                    rr.Status = 1;
                    rr.Message = "success";
                    rr.Return = null;

                }
            }
            catch (Exception ex)
            {

                rr.Status = 0;
                rr.Message = ex.Message;
                rr.Return = null;
            }
            return new JsonResult()
            {
                Data = rr,
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };

        }


        public ActionResult ApprovalRoom(
            String Note = "",
            String Status = "",
            String IdBookingRooms = ""
            ) {
            Result rr = new Result();
            try
            {
                SqlConnection conn = new SqlConnection(MainConnection);
                String sql = "[TransactionRooms]";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Param", "ApprovalRoom");
                cmd.Parameters.Add("@Code", Request.Cookies["Code"].Value);
                cmd.Parameters.Add("@Note", Note);
                cmd.Parameters.Add("@Status", Status);
                cmd.Parameters.Add("@IdBookingRooms", Decrypt(IdBookingRooms));
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                conn.Dispose();
                rr.Status = 1;
                rr.Message = "Success";
            }
            catch (Exception ex)
            {

                rr.Status = 0;
                rr.Message = ex.Message;
            }
            return new JsonResult()
            {
                Data = rr,
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };

        }


        public ActionResult GetSessionTimePerDay(String IdRoom = "", String Date ="")
        {
            Result rr = new Result();
            try
            {
                List<SessionTime> Res = new List<SessionTime>();
                SqlConnection conn = new SqlConnection(MainConnection);
                String sql = "TransactionRooms";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Param", "GetSessionTimePerDay");
                cmd.Parameters.Add("@IdRoom", Decrypt(IdRoom));
                cmd.Parameters.Add("@Date", Date);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        SessionTime st = new SessionTime();
                        st.EndTime = dr["EndTime"].ToString();
                        st.IdRooms = dr["IdRooms"].ToString();
                        st.StartTime = dr["StartTime"].ToString();
                        st.Id = dr["Id"].ToString();
                        st.IdSessionTime = dr["IdSessionTime"].ToString();
                        Res.Add(st);
                    }
                }

                conn.Close();
                conn.Dispose();
                rr.Status = 1;
                rr.Return = Res;
            }
            catch (Exception ex)
            {

                rr.Status = 0;
                rr.Message = ex.Message;
            }
            return new JsonResult()
            {
                Data = rr,
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };



        }



        public ActionResult GetSessioPerRoom(String IdRoom="") {
            Result rr = new Result();
            try
            {
                List<SessionTimePerRoom> Res = new List<SessionTimePerRoom>();
                SqlConnection conn = new SqlConnection(MainConnection);
                String sql = "[TransactionRooms]";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Param", "GetSessioPerRoom");
                cmd.Parameters.Add("@IdRoom", Decrypt(IdRoom));
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        SessionTimePerRoom st = new SessionTimePerRoom();
                        st.start = dr["StartTime"].ToString();
                        st.end = dr["EndTime"].ToString();
                        st.Id = dr["Id"].ToString();
                        st.Date = dr["Date"].ToString();
                        Res.Add(st);

                    }
                }
                conn.Close();
                conn.Dispose();
                rr.Status = 1;
                rr.Message = "Success";
                rr.Return = Res;

            }
            catch (Exception ex)
            {

                rr.Status = 0;
                rr.Message = ex.Message;
            }
            return new JsonResult()
            {
                Data = rr,
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }


        public ActionResult InsertBookingRoom(
            String Date = "",
            String TotalParticipant = "",
            String IsInternal = "",
            String AdditionalInformation = "",
            String Id = ""
            ) {
            Result rr = new Result();
            try
            {
                SqlConnection conn = new SqlConnection(MainConnection);
                String sql = "[TransactionRooms]";
                SqlCommand cmd = new SqlCommand(sql,conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Param", "InsertBookingRooms");
                cmd.Parameters.Add("@Date", Date);
                cmd.Parameters.Add("@TotalParticipant", TotalParticipant);
                cmd.Parameters.Add("@IsInternal", IsInternal);
                cmd.Parameters.Add("@AdditionalInformation", AdditionalInformation);
                cmd.Parameters.Add("@Code", Request.Cookies["Code"].Value);
                cmd.Parameters.Add("@IdRoom", Decrypt(Id) );
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    while (dr.Read())
                    {
                        rr.Message = dr["Id"].ToString();
                    }
                }
                conn.Close();
                conn.Dispose();
                rr.Status = 1;


            }
            catch (Exception ex)
            {

                rr.Status = 0;
                rr.Message = ex.Message;
            }
            return new JsonResult()
            {
                Data = rr,
                MaxJsonLength = Int32.MaxValue,
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };



        }



        //public ActionResult Index()
        //{
        //    return View();
        //}
    }
}