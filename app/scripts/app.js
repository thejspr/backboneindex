var AppState = Backbone.Model.extend({});
var appState = new AppState;

var categories = new CategoryList();
var extensions = new ExtensionList();

function initCategories() {
  var categoriesView = new CategoryView({collection: categories});
  categoriesView.render();
}

function initExtensions() {
  var extensionsView = new ExtensionView({collection: extensions});
  appState.set('extensionsView', extensionsView);
  extensionsView.render();
}

categories.fetch({ success: initCategories });
extensions.fetch({ success: initExtensions });
