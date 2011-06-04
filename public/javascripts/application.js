$(document).ready(function() {
  // Try to focus any inputs that need focusing
  $('#session_username').focus();
  $('#user_username').focus();
  $('#message_content').focus();
  
  // Make message form clear on submission
  $('#new_message').live('ajax:beforeSend', function() {
    $('#message_content').val('').focus();
  });
  
  // Get rid of any flashes hanging around
  $('.flash').delay(4000).slideUp('', function(){$(this).remove();});
  
  // Add inline help handler
  $('#help_pane').hide();
  $('.help_link').click(function(e) {
    $('#help_pane').slideToggle();
    e.preventDefault();
  });
});

// Handle ajax responses with a flash attached
$(document).ajaxComplete(function(e, request, opts) {
  if (request.getResponseHeader('X-Message') != null) {
    var flash = $('<div class="flash ' +
      request.getResponseHeader('X-Message-Type') + '">' +
      request.getResponseHeader('X-Message') + '</div>');
    $('#flashes').append(flash);
    flash.hide().slideDown().delay(4000).slideUp('', function(){$(this).remove();});
  }
});
