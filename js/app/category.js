var Category = Backbone.Model.extend();

var CategoryList = Backbone.Collection.extend({
  model: Category,
  url: 'data/categories.json'
});

var CategoryView = Backbone.View.extend({
  events: {
    'click .category': 'updateList'
  },
  el: "#categories",
  template: _.template("<label class='checkbox'><input class='category' type='checkbox' value='<%= title %>' checked='checked'><%= title %></label>"),
  render: function() {
    _.each(this.model.models, function(category){
      var categoryTemplate = this.template(category.attributes);
      $(this.el).append(categoryTemplate);
    }, this);

    return this;
  },
  updateList: function(){
    var categories = [];

    $('.category:checked').each(function(){
      categories.push($(this).val());
    });

    var extensions = appState.get('extensions').models;
    var result = queryEngine.createCollection(extensions).findAll({category: {$in: categories}});
    new ExtensionView({model: result}).render();
  }
});
