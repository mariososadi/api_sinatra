$(document).ready(function() {

  $( '#forma' ).submit( function(event) {
    event.preventDefault();
    userConfirmation();
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

});
