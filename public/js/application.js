$(document).ready(function() {
  $(document).ready(function() {
  $('form').on('submit', function(e) {
    e.preventDefault();

    var num = Math.floor((Math.random()*3)+1)
    
    $('.tweet-display').html("<img src='ajax-loader.gif'>");
    $.post('/username', $(this).serialize()).done( function (response) {
      if (num === 3) {
        $('.tweet-display').html("Stop tweeting and go do your work!");
      }
      else {
        $('.tweet-display').html(response);
      }
    });
  });
});
});
