//= require rails-ujs
//= require turbolinks
//= require jquery
//= require popper
//= require bootstrap
//= require_tree .

$(function() {
  let kill_item3 = function() {
    $('#item3').addClass('disabled').removeClass('active');
    $('#edit_building').removeClass('show active');
    
    if ($(this)[0].id === 'create_building') {
      $( ".has-error" ).remove();
    }
  };

  $('#item1').on('click', kill_item3);
  $('#item2').on('click', kill_item3);
});