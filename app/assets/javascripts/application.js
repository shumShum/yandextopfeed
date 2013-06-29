//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  $('#options').on('change', '#options', function(e) {
    var choice = $(this)[0].value;
    $.ajax({
      url: 'out_by_time',
      type: 'GET',
      data: {time_option: choice},
      dataType: 'script',
      async: true,

      success: function(data, textStatus, jqXHR) {
        // console.log(data);
      },
      error: function(request, textStatus, errorThrown) {
        console.log(request);
        console.log(textStatus);
        console.log(errorThrown);
      }
    });
  });
});

