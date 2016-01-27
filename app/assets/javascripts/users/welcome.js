$(function() {
  return $("form#sign_in_user, form#sign_up_user").bind("ajax:success", function(event, xhr, settings) {
    location.reload();
    return $(this).parents('.modal').modal('hide');
  }).bind("ajax:error", function(event, xhr, settings, exceptions) {
    var error_messages;
    error_messages = xhr.responseJSON['error'] ? "<div class='alert alert-danger'>" + xhr.responseJSON['error'] + "</div>" : xhr.responseJSON['errors'] ? '<div class="container-fluid">'+$.map(xhr.responseJSON["errors"], function(v, k) {
      return "<div class='row'><div class='alert alert-danger'>" + k + " " + v + "</div></div>";
    }).join("")+'</div>' : "<div class='alert alert-danger'>Unknown error</div>";
    BootstrapDialog.show({
      type: BootstrapDialog.TYPE_DANGER,
      title: 'Error',
      message: error_messages,
    });
    //return $(this).parents('.modal-content').children('.modal-footer').html(error_messages);
  });
});
