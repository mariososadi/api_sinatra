$(document).ready(function() {

  $( '#forma' ).submit( function(event) {
    event.preventDefault();
    userConfirmation();
  });

  $( '#forma2' ).submit( function(event) {
    event.preventDefault();
    sendingTweet();

  });



  function userConfirmation() {
    var x = document.getElementById("user").value;
    if ( x.length != 0 ) {
      handle = $('#forma').serialize();
      $.post('/fetch', handle, function(data) {     
        if (data === 'A') {
          $( location ).attr("href", x)        
        } else if (data === 'B'){
          $( location ).attr("href", x)
        } else{
          $(".container").empty();
          $(".container").append(data);
        }          
      });
    } else {
      $("#para").empty();
      $("#para").append("You cannot let this box empty. Please type a valid Twitter Username").css("color","red");   
    }
  }



  function sendingTweet() {
    var x = document.getElementById("tweet").value;
    if ( x.length != 0 ) {
      str = $('#forma2').serialize();
      $(".container").empty();
      $("body").css("background-color", "red");
      
      
      $.post('/tweet', str, function(data) {     
        $("body").css("background-color","white");
        $(".container").append(data);
        $("#para2").empty();
        $("#para2").append("NICE! YOUR TWEET IS ONLINE NOW!").css("color","green");
      });


    } else {
      $("#para2").empty();
      $("#para2").append("You cannot let this box empty. Please, tweet anything you like.").css("color","red");   
    }
  }




});
