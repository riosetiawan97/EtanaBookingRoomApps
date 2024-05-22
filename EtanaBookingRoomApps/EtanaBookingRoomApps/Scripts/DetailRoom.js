
function formatDate(date) {
    var d = new Date(date),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2)
        month = '0' + month;
    if (day.length < 2)
        day = '0' + day;

    return [year, month, day].join('-');
}

function showModal(Date) {
    var Date = formatDate(Date);
    $("#Date").val(Date)
    $("#exampleModalLabel").html("Booking Room Bevagen ")
    $.ajax({
        url: baseUrl + "/Api/GetSessioRoomApprovePerDay",
        data: {
            IdRoom: $("#IdRoom").val(),
            Date: $("#Date").val()
        },
        success: function (data) {
            //console.log("Data", data.Return[0].start);
            var Session = data.Return;

            $("#time1").attr("disabled", false);
            $("#time1").css({ "text-decoration": "", "color": "" });
            $("#time2").attr("disabled", false);
            $("#time2").css({ "text-decoration": "", "color": "" });
            $("#time3").attr("disabled", false);
            $("#time3").css({ "text-decoration": "", "color": "" });
            $("#time4").attr("disabled", false);
            $("#time4").css({ "text-decoration": "", "color": "" });
            $("#time5").attr("disabled", false);
            $("#time5").css({ "text-decoration": "", "color": "" });
            $("#time6").attr("disabled", false);
            $("#time6").css({ "text-decoration": "", "color": "" });
            $("#time7").attr("disabled", false);
            $("#time7").css({ "text-decoration": "", "color": "" });
            $("#time8").attr("disabled", false);
            $("#time8").css({ "text-decoration": "", "color": "" });
            $("#time9").attr("disabled", false);
            $("#time9").css({ "text-decoration": "", "color": "" });
            if (Session.length > 0) {
                for (let i = 0; i < Session.length; ++i) {
                    if (data.Return[i].start == "08:00:00") {
                        $("#time1").attr("disabled", "disabled");
                        $("#time1").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "09:00:00") {
                        $("#time2").attr("disabled", "disabled");
                        $("#time2").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "10:00:00") {
                        $("#time3").attr("disabled", "disabled");
                        $("#time3").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "11:00:00") {
                        $("#time4").attr("disabled", "disabled");
                        $("#time4").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "13:00:00") {
                        $("#time5").attr("disabled", "disabled");
                        $("#time5").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "14:00:00") {
                        $("#time6").attr("disabled", "disabled");
                        $("#time6").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "15:00:00") {
                        $("#time7").attr("disabled", "disabled");
                        $("#time7").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "16:00:00") {
                        $("#time8").attr("disabled", "disabled");
                        $("#time8").css({ "text-decoration": "line-through", "color": "red" });
                    }
                    else if (data.Return[i].start == "17:00:00") {
                        $("#time9").attr("disabled", "disabled");
                        $("#time9").css({ "text-decoration": "line-through", "color": "red" });
                    }

                }
            }
        }
    })
    var myModal = new bootstrap.Modal(document.getElementById("exampleModal"), {});
    myModal.show();


    //document.onreadystatechange = function () {
    //    myModal.show();
    //};
}


$(document).ready(function () {

    $.ajax({
        url: baseUrl + "/Api/GetSessioPerRoom",
        data: {
            IdRoom: $("#IdRoom").val()
        },
        success: function (data) {
            //console.log("Data",data)
            if (data.Status == "1") {
                var Obj = [];
                //var ObjectDate = {};
                for (var i = 0; i < data.Return.length; i++) {
                    Obj.push({
                        'start': data.Return[i].start,
                        'end': data.Return[i].end,
                        'title': 'Meeting'
                    })
                }
                console.log("Data", Obj)

                var calendarEl = document.getElementById('calendar');
                const d = new Date();
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth'
                    },
                    initialDate: formatDate(d),
                    navLinks: true, // can click day/week names to navigate views
                    selectable: true,
                    selectMirror: true,
                    select: function (arg) {
                        showModal(arg.start)
                        calendar.unselect()
                    },
                    eventClick: function (arg) {
                    },
                    editable: true,
                    dayMaxEvents: true, // allow "more" link when too many events
                    events: Obj
                });
                calendar.render();
            } else {
                alertError(data.Message)
            }
        }
    })

    $("#SubmitBookingRooms").on("submit", function (e) {
        e.preventDefault();
        //alert("Tester")
        loading();

        var Session = $("#Session").val();
        var IdBookingRooms1 = "";
        var IdSessionTime1 = "";

        $.ajax({
            url: baseUrl + "/Api/InsertBookingRoom",
            type: "POST",
            data: {
                Date: $("#Date").val(),
                TotalParticipant: $("#TotalParticipant").val(),
                IsInternal: $("#IsInternal").val(),
                AdditionalInformation: $("#AdditionalInformation").val(),
                Id: $("#IdRoom").val()
            },
            success: function (data) {
                if (data.Status == "1") {
                    IdBookingRooms1 = data.Message;
                    for (let i = 0; i < Session.length; ++i) {
                        if (Session[i] == "1") {
                            var StartTime1 = "08:00:00";
                            var EndTime1 = "09:00:00";
                        }
                        else if (Session[i] == "2") {
                            var StartTime1 = "09:00:00";
                            var EndTime1 = "10:00:00";
                        }
                        else if (Session[i] == "3") {
                            var StartTime1 = "10:00:00";
                            var EndTime1 = "11:00:00";
                        }
                        else if (Session[i] == "4") {
                            var StartTime1 = "11:00:00";
                            var EndTime1 = "12:00:00";
                        }
                        else if (Session[i] == "5") {
                            var StartTime1 = "13:00:00";
                            var EndTime1 = "14:00:00";
                        }
                        else if (Session[i] == "6") {
                            var StartTime1 = "14:00:00";
                            var EndTime1 = "15:00:00";
                        }
                        else if (Session[i] == "7") {
                            var StartTime1 = "15:00:00";
                            var EndTime1 = "16:00:00";
                        }
                        else if (Session[i] == "8") {
                            var StartTime1 = "16:00:00";
                            var EndTime1 = "17:00:00";
                        }
                        else if (Session[i] == "9") {
                            var StartTime1 = "17:00:00";
                            var EndTime1 = "18:00:00";
                        }
                        $.ajax({
                            url: baseUrl + "/Api/InsertSessionTime",
                            type: "POST",
                            data: {
                                StartTime: StartTime1,
                                EndTime: EndTime1,
                                Id: $("#IdRoom").val()
                            },
                            success: function (data) {
                                if (data.Status == "1") {
                                    IdSessionTime1 = data.Message;
                                    $.ajax({
                                        url: baseUrl + "/Api/InsertSessionBookingRoom",
                                        type: "POST",
                                        data: {
                                            IdBookingRooms: IdBookingRooms1,
                                            IdSessionTime: IdSessionTime1
                                        }
                                    });
                                }
                            }
                        });
                    }
                    currLoc = $(location).attr('href');
                    alertSuccess("Data Is Submitted", currLoc)
                } else {
                    alertError(data.Message)
                }
            }
        });
    })





});



