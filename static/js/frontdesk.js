$(function (event) {

    // $("#").click(function () {
    //     console.log("You are still on the homepage");
    //     window.location.href = "frondeskhomepage.html";
    // });

    $(".tablinks").click(function (event) {
        var currentTabID = $(this).attr('href');
        $(currentTabID).show().siblings().hide();
        $(this).parent('li').addClass('active').siblings().removeClass('active');
        event.preventDefault();
    });


    // var tabcontent = $(".tab-pane");
    // console.log(tabcontent);
    // for (var index = 0; index < tabcontent.length; index++) {
    //     tabcontent[index].style.display = "none";
    // }

    // var tablinks = $(".tablinks");
    // console.log(tablinks);
    // for (var index = 0; index < tablinks.length; index++) {
    //     tablinks[index].class = tablinks[index].class.replace(" active", "");
    // }

    // event.currentTarget.class += " active";
});