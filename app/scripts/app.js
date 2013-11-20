(function(){
  var App = new Backbone.Marionette.Application();

  var categories = new CategoryList();
  var extensions = new ExtensionList();

  function initCategories() {
    var categoriesView = new CategoryView({collection: categories});
    categoriesView.render();
  }

  var extensionsView = new ExtensionsView({collection: extensions});

  function initExtensions() {
    App.allExtensions = extensions;
    extensionsView.render();
  }

  categories.fetch({ success: initCategories });
  extensions.fetch({ success: initExtensions });

  App.vent.on("filterExtensions", function(){
    extensionsView.filter();
  });
});
