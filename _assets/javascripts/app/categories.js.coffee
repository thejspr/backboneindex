@BackboneIndex.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Category extends Backbone.Model

  class Entities.CategoryList extends Backbone.Collection
    model: Entities.Category,
    url: 'data/categories.json'


@BackboneIndex.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.CategoryView extends Backbone.View
    events:
      'click .category': 'triggerUpdate',
      'click .toggle': 'toggleCategories'
    el: "#categories"
    template: _.template("<label class='checkbox'><input class='category' type='checkbox' value='<%= title %>' checked='checked'><%= title %></label>"),
    render: ->
      _.each(@.collection.models, (category) ->
        categoryTemplate = @.template(category.toJSON())
        @.$el.append(categoryTemplate)
      , @)
      @.$el.append('<a href="#" class="toggle">Show/hide all</a>')
    triggerUpdate: ->
      App.vent.trigger('categoriesChanged')
    toggleCategories: ->
      $('.category').prop('checked', $('.category:not(:checked)').length)
      @.triggerUpdate()

  class Views.FilterView extends Backbone.View
    events:
      'input': 'triggerUpdate',
    el: "#filter .filter"
    triggerUpdate: ->
      query = @.$el.val()
      App.vent.trigger('filterChanged') unless query.length < 3

