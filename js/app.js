var AppState  = Backbone.Model.extend({});
var appState = new AppState;

var categories = new CategoryList();
var extensions = new ExtensionList();

appState.set('categories', categories);
appState.set('extensions', extensions);

function initCategories() {
  var categoriesView = new CategoryView({model: categories});
  categoriesView.render();
}

function initExtensions() {
  var extensionsView = new ExtensionView({model: extensions});
  extensionsView.render();
}

categories.fetch({ success: initCategories });
extensions.fetch({ success: initExtensions });
