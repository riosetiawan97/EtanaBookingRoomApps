
function ApproveModal(IdEncrypt) {
    $("#IdEncrypt").val(IdEncrypt)
}

$(document).ready(function () {

    $("#SubmitApproveModal").on("submit", function (e) {
        e.preventDefault();
        //alert("Tester")
        loading();


        $.ajax({
            url: baseUrl + "/Api/ApprovalRoom",
            type: "POST",
            data: {
                Note: $("#NoteApproval").val(),
                Status: $("#ApprovalSelect").val(),
                IdBookingRooms: $("#IdEncrypt").val(),
                Date: $("#Date").val()
            },
            success: function (data) {
                if (data.Status == "1") {
                    alertSuccess("Data Is Submitted", baseUrl + "/ListBooking?Type=3")
                } else {
                    alertError(data.Message)
                }
            }
        });

    });
    $(".btnMdlApprove").each(function () {
        var $this = $(this);
        $this.on("click", function () {
            var idBookingRoom = $(this).data('idbookingroom');
            $("#IdEncrypt").val(idBookingRoom);
            var date = $(this).data('date');
            var d = new Date(date.split("/").reverse().join("-"));
            var dd = d.getDate();
            var mm = d.getMonth() + 1;
            if (mm < 10) { mm = '0' + mm; }
            var yy = d.getFullYear();
            date = yy + "-" + mm + "-" + dd;
            $("#Date").val(date);
            $("#exampleModalLabel").html("Approval Booking Room")
            var myModal = new bootstrap.Modal(document.getElementById("ApproveModal"), {});
            myModal.show();
        });
    });

});