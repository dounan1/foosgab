$(document).on('page:fetch', function() {
  $('#spinner').fadeIn();
});

$(document).on('page:change', function() {
  $('#spinner').fadeOut();
});