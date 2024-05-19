
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
        console.log($("#Session").val())

    })





});



