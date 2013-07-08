var Category = Backbone.Model.extend();

var CategoryList = Backbone.Collection.extend({
  model: Category,
  url: 'data/categories.json'
});

var CategoryView = Backbone.View.extend({
  el: "#categories",
  template: _.template("<label class='checkbox'><input type='checkbox' value='<%= title %>' checked='checked'><%= title %></label>"),
  render: function() {
    _.each(this.model.models, function(category){
      var extensionTemplate = this.template(extension.toAttributes());
      $(this.el).append(extensionTemplate);
    }, this);

    return this;
  }
});
