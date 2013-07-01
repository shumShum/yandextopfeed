//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  $('#options').on('change', '#time_options', function(e) {
    var time = $(this)[0].value;
    var text = $('#text_options')[0].value;
    out_by_options(time, text);
  });
});

$(function() {
  $('#options').on('change', '#text_options', function(e) {
    var text = $(this)[0].value;
    var time = $('#time_options')[0].value;
    out_by_options(time, text);
  });
});

function out_by_options(time, text){
  $.ajax({
    url: '/out_by_options',
    type: 'GET',
    data: {time_option: time, text_option: text},
    dataType: 'script',
    async: true,

    success: function(data, textStatus, jqXHR) {
      if (text != "") {
        $.each(text.split(', '), function(i, t) {
          $('li').highlight(t);
        });
      }
    },
    error: function(request, textStatus, errorThrown) {
      console.log(request);
      console.log(textStatus);
      console.log(errorThrown);
    }
  });
}

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


jQuery.fn.highlight = function(pat) {
 function innerHighlight(node, pat) {
  var skip = 0;
  if (node.nodeType == 3) {
   var pos = node.data.toUpperCase().indexOf(pat);
   if (pos >= 0) {
    var spannode = document.createElement('span');
    spannode.className = 'highlight';
    var middlebit = node.splitText(pos);
    var endbit = middlebit.splitText(pat.length);
    var middleclone = middlebit.cloneNode(true);
    spannode.appendChild(middleclone);
    middlebit.parentNode.replaceChild(spannode, middlebit);
    skip = 1;
   }
  }
  else if (node.nodeType == 1 && node.childNodes && !/(script|style)/i.test(node.tagName)) {
   for (var i = 0; i < node.childNodes.length; ++i) {
    i += innerHighlight(node.childNodes[i], pat);
   }
  }
  return skip;
 }
 return this.each(function() {
  innerHighlight(this, pat.toUpperCase());
 });
};

jQuery.fn.removeHighlight = function() {
 return this.find("span.highlight").each(function() {
  this.parentNode.firstChild.nodeName;
  with (this.parentNode) {
   replaceChild(this.firstChild, this);
   normalize();
  }
 }).end();
};
 

