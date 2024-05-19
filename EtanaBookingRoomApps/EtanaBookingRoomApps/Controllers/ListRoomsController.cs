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
    public class ListRoomsController : ApiController
    {
        public static String MainConnection = ConfigurationManager.ConnectionStrings["MainConnection"].ToString();
        // GET: ListRooms







        public List<SessionTime> GetSessionTime(String Id="") {
            List<SessionTime> Res = new List<SessionTime>();
            SqlConnection conn = new SqlConnection(MainConnection);
            String sql = "TransactionRooms";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@Param", "GetSessionTimePerRoom");
            cmd.Parameters.Add("@IdRoom", Decrypt(Id));
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
                    Res.Add(st);
                }
            }

            conn.Close();
            conn.Dispose();
            return Res;


        }


        public List<Rooms> GetRooms(String Id="",String Param="") {
            List<Rooms> Res = new List<Rooms>();
            SqlConnection conn = new SqlConnection(MainConnection);
            String sql = "TransactionRooms";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@Param", Param);
            cmd.Parameters.Add("@IdRoom", Decrypt(Id));
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    Rooms ro = new Rooms();
                    ro.IdEncrypt = Encrypt(dr["Id"].ToString());
                    ro.Id = dr["Id"].ToString();
                    ro.RoomLocation = dr["Location"].ToString() ;
                    ro.RoomMaxPerson = dr["MaxPerson"].ToString();
                    ro.RoomName = dr["Name"].ToString();
                    ro.RoomTime = dr["Time"].ToString();
                    Res.Add(ro);
                }
            }
            conn.Close();
            conn.Dispose();
            return Res;
        }

        public List<RoomFacilities> GetRoomFacilities(String Id = "", String Param = "")
        {
            List<RoomFacilities> Res = new List<RoomFacilities>();
            SqlConnection conn = new SqlConnection(MainConnection);
            String sql = "TransactionRooms";
            SqlCommand cmd = new SqlCommand(sql, conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("@Param", Param);
            cmd.Parameters.Add("@IdRoom", Decrypt(Id));
            conn.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows)
            {
                while (dr.Read())
                {
                    RoomFacilities ro = new RoomFacilities();
                    ro.RoomId = dr["Id"].ToString();
                    ro.RoomFacilityColor = dr["Color"].ToString();
                    ro.RoomFacilityName = dr["Name"].ToString();
                    Res.Add(ro);
                }
            }
            conn.Close();
            conn.Dispose();
            return Res;
        }

        public ActionResult Index()
        {
            if (Request.Cookies["IsLogin"] == null)
            {
                return RedirectToAction("Index", "Login");
            }
            ViewBag.GetRooms = GetRooms("", "GetAllRoom");
            ViewBag.GetRoomFacilities = GetRoomFacilities("", "GetRoomFacilities");

            return View();
        }


        public List<SessionTimePerRoom> GetSessioPerRoom(String IdRoom = "")
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
                        Res.Add(st);

                    }
                }
                conn.Close();
                conn.Dispose();

            return Res;
        }



        public ActionResult Detail(String Id) {
            if (Request.Cookies["IsLogin"] == null)
            {
                return RedirectToAction("Index", "Login");
            }
            ViewBag.GetSessionTime = GetSessionTime(Id);
            ViewBag.GetRooms = GetRooms(Id, "GetDetailRoom");
            ViewBag.GetRoomFacilities = GetRoomFacilities(Id, "GetRoomFacilitiesbyIdRoom");

            ViewBag.GetSessioPerRoom = GetSessioPerRoom(Id);
            ViewBag.javascript = "DetailRoom.js";
            return View();
        }
    }
}