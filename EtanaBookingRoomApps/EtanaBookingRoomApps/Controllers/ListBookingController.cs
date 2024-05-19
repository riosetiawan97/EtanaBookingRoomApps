using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using EtanaBookingRoomApps.Models;
namespace EtanaBookingRoomApps.Controllers
{
    public class ListBookingController : ApiController
    {
        public static String MainConnection = ConfigurationManager.ConnectionStrings["MainConnection"].ToString();
        // GET: ListBooking

        public List<SessionTimePerRoom> GetSessionBookingRoom() {
            List<SessionTimePerRoom> Res = new List<SessionTimePerRoom>();
            SqlConnection conn = new SqlConnection(MainConnection);
            String sql = "TransactionRooms";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@Param", "GetSessionBookingRoom");
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    SessionTimePerRoom st = new SessionTimePerRoom();
                    st.Id = dr["IdBookingRooms"].ToString();
                    st.start = dr["StartTime"].ToString();
                    st.end = dr["EndTime"].ToString();
                    Res.Add(st);
                }
            }
            conn.Close();
            conn.Dispose();
            return Res;


        }


        public List<ListBooking> ListBooking(String Param)
        {
            List<ListBooking> Res = new List<ListBooking>();
               SqlConnection conn = new SqlConnection(MainConnection);
            String sql = "[TransactionRooms]";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@Param", Param);
            cmd.Parameters.Add("@Code", Request.Cookies["Code"].Value);
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    ListBooking lb = new ListBooking();
                    lb.AdditionalInformation = dr["AdditionalInformation"].ToString();
                    lb.Date = dr["Date"].ToString();
                    lb.Id = dr["Id"].ToString();
                    lb.IsInternal = dr["IsInternal"].ToString() == "1" ? "Internal" : "External";
                    lb.RoomName = dr["RoomName"].ToString();
                    lb.StatusName = dr["StatusName"].ToString();
                    lb.TotalParticipant = dr["TotalParticipant"].ToString();
                    lb.IdEncrypt = Encrypt(dr["Id"].ToString());
                    lb.Session = dr["Session"].ToString();
                    Res.Add(lb);
                }
            }
            conn.Close();
            conn.Dispose();
            return Res;
        }
        
        public ActionResult Index(String Type="1")
        {
            ViewBag.GetMyBookingRoom = ListBooking("GetMyBookingRoom");
            ViewBag.GetMyHistoryBooking = ListBooking("GetMyHistoryBooking");
            ViewBag.GetPendingApproval = ListBooking("GetPendingApproval");
            ViewBag.GetSessionBookingRoom = GetSessionBookingRoom();
            ViewBag.Type = Type;
            ViewBag.javascript = "ListBooking.js";
            return View();
        }
    }
}