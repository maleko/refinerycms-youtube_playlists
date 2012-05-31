$(function() {
  $(document).on('click', 'a.activation_youtube_playlist', function(event) {
    event.preventDefault();
    var me = $(this);
    $.ajax({
      type: 'GET',
      url: this.href + '.json'
    }).success(function(data, textStatus) {
      me.replaceWith(data.html);
    }).error(function(jqXHR, textStatus, errorThrown) {
      console.warn("error '" + textStatus + "' with '" + errorThrown);
    });
  });

  $('ul.collapsible_menu').each(function(i, ul) {
    (first_li = $(this).children('li:first')).after(div=$("<div></div>"));

    $("<span class='arrow'>&nbsp;</span>").appendTo(first_li);

    if (($(this).children('li.selected')).length === 0) {
      div.hide();
      first_li.addClass("closed");
    }
    $(this).children('li:not(:first)').appendTo(div);

    first_li.find('> a, > span.arrow').click(function(e){
      e.preventDefault();
      $(this).parent().toggleClass("closed");
      $(this).parent().toggleClass("open");

      $(this).parent().next('div').animate({ opacity: 'toggle',height: 'toggle' }, 250, $.proxy(
        (function() { $(this).css('background-image', null); }), $(this)));
    });
  });
});
