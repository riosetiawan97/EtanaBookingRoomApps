$(document).ready(function () {
    $("#SubmitLogin").on("submit", function (e) {
        e.preventDefault();
        $.ajax({
            url: baseUrl + "/AccessWorkspace/Index",
            data: {
                Odec: $("#InputNIP").val()
            },
            success: function (data) {
                console.log(data);
                if (data.Status == 1) {
                    Swal.fire({
                        icon: 'success',
                        title: 'Ok...',
                        text: 'Berhasil Login'
                    }).then((result) => window.location.href = "/")
                }
                else
                {
                    Swal.fire({
                        icon: 'error',
                        title: 'Oops...',
                        text: data.Message
                    }).then((result) => window.location.href = "/Login")
                }
            }
        })
    });
});