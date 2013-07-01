//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  $('#options').on('change', '#time_options', function(e) {
    var choice = $(this)[0].value;
    $.ajax({
      url: '/out_by_time',
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

$(function() {
  $('#options').on('change', '#text_options', function(e) {
    var text = $(this)[0].value;
    console.log(text);
  });
});

$(function() {
  $('#options').on('click', '#load_feeds', function(e) {
    var choice = $('#time_options')[0].value;
    $.ajax({
      url: '/feeds/put_feeds',
      type: 'GET',
      data: {time_option: choice},
      dataType: 'script',
      async: true,

      success: function(data, textStatus, jqXHR) {
        // console.log(data);
      },
      error: function(request, textStatus, errorThrown) {
        console.log(textStatus);
        console.log(errorThrown);
      }
    });
  });
});

// $(function() {
//   $('#feed-item').on('click', '#destroy_feed', function(e) {
//     console.log();
//   });
// });   

