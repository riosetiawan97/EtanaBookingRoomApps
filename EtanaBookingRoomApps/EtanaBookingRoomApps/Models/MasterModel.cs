using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EtanaBookingRoomApps.Models
{
    public class MasterModel
    {
    }

    public class ListBooking {

        public string Id { get; set; }
        public string Date { get; set; }
        public string TotalParticipant { get; set; }

        public string IsInternal { get; set; }

        public string AdditionalInformation { get; set; }
        public string StatusName { get; set; }

        public string RoomName { get; set; }

        public string IdEncrypt { get; set; }
        public string Session { get; set; }



    }

    public class Result
    {

        public int Status { get; set; }
        public string Message { get; set; }
        public object Return { get; set; }
    }



    public class SessionTimePerRoom {

        public string title { get; set; }
        public string start { get; set; }
        public string end { get; set; }

        public string Id { get; set; }

        public string Date { get; set; }


    }

    public class SessionTime {

        public string IdRooms { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }

        public string Id { get; set; }

        public string Booked { get; set; }

        public string IdSessionTime { get; set; }

    }

    public class Rooms {

        public string IdEncrypt { get; set; }
        public string Id { get; set; }
        public string RoomName { get; set; }
        public string RoomTime { get; set; }
        public string RoomMaxPerson { get; set; }
        public string RoomLocation { get; set; }

    }

    public class RoomFacilities {

        public string RoomFacilityName { get; set; }

        public string RoomFacilityColor { get; set; }

        public string RoomId { get; set; }

    }


    public class SessioRoomApprovePerDay
    {
        public string IdRooms { get; set; }
        public string start { get; set; }
        public string end { get; set; }
        public string Date { get; set; }


    }


}