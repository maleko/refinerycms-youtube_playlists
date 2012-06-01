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
});
