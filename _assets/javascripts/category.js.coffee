class Category extends Backbone.Model

class CategoryList extends Backbone.Collection
  model: Category,
  url: 'data/categories.json'

class CategoryView extends Backbone.View
  events:
    'click .category': 'triggerUpdate',
    'click .toggle': 'toggleCategories'
  el: "#categories"
  template: _.template("<label class='checkbox'><input class='category' type='checkbox' value='<%= title %>' checked='checked'><%= title %></label>"),
  render: ->
    _.each(@.collection.models, (category) ->
      categoryTemplate = @.template(category.toJSON())
      $el.append(categoryTemplate)
    , @)
    $el.append('<a href="#" class="toggle">Show/hide all</a>')

    @
  triggerUpdate: ->
    App.vent.trigger('filterExtensions')
  toggleCategories: ->
    $('.category').prop('checked', $('.category:not(:checked)').length)
    @.triggerUpdate()
