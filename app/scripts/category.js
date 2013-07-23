var Category = Backbone.Model.extend();

var CategoryList = Backbone.Collection.extend({
  model: Category,
  url: 'data/categories.json'
});

var CategoryView = Backbone.View.extend({
  events: {
    'click .category': 'triggerUpdate',
    'click .toggle': 'toggleCategories'
  },
  el: "#categories",
  template: _.template("<label class='checkbox'><input class='category' type='checkbox' value='<%= title %>' checked='checked'><%= title %></label>"),
  render: function() {
    _.each(this.collection.models, function(category){
      var categoryTemplate = this.template(category.toJSON());
      $(this.el).append(categoryTemplate);
    }, this);
    $(this.el).append('<a href="#" class="toggle">Show/hide all</a>');

    return this;
  },
  triggerUpdate: function(){
    App.vent.trigger('filterExtensions');
  },
  toggleCategories: function() {
    $('.category').prop('checked', $('.category:not(:checked)').length);
    this.triggerUpdate();
  }
});
