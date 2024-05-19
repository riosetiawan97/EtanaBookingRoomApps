
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
                IdBookingRooms: $("#IdEncrypt").val()
            },
            success: function (data) {
                if (data.Status == "1") {
                    alertSuccess("Data Is Submitted", baseUrl + "/ListBooking?Type=3")
                } else {
                    alertError(data.Message)
                }
            }
        })

    });

});