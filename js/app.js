$(function(){
  var extensions = new ExtensionList();

  function init() {
    var extensionsView = new ExtensionView({model: extensions});
    extensionsView.render();
  }

  extensions.fetch({
    success: init
  });
});
