# -- dependencies --
#= require vendor/jquery
#= require vendor/showdown
#= require vendor/showdown-github
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/backbone.marionette

# -- application --

$ ->
  App = new Backbone.Marionette.Application()

# category
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
        @.$el.append(categoryTemplate)
      , @)
      @.$el.append('<a href="#" class="toggle">Show/hide all</a>')
    triggerUpdate: ->
      App.vent.trigger('filterExtensions')
    toggleCategories: ->
      $('.category').prop('checked', $('.category:not(:checked)').length)
      @.triggerUpdate()

# extensions
  class Extension extends Backbone.Model
    descriptionHtml: ->
      converter = new Showdown.converter({ extensions: ['github'] })
      return converter.makeHtml(@.get('description'))

  class ExtensionList extends Backbone.Collection
    model: Extension
    url: 'data/extensions.json'
    filter: (categories) ->
      result = []

      _.each(App.allExtensions.models, (extension) ->
        result.push(extension) if (_.contains(categories, extension.get('category')))
      )

      new ExtensionList(result)

  class ExtensionView extends Backbone.Marionette.ItemView
    model: Extension
    template: _.template("<div class='extension'><h3><%= title %></h3><p><%= description %></p></div>")
    serializeData: ->
      return {
        "title": @.model.get('title'),
        "description": @.model.descriptionHtml()
      }

  class ExtensionsView extends Backbone.Marionette.CompositeView
    el: "#extensions"
    template: _.template("<div class='extension-counter'><em><%= length %> plugins</em></div><div id='extension-list'></div>")
    itemView: ExtensionView
    templateHelpers: ->
      return {length: @.collection.length}
    filter: ->
      categories = []

      $('.category:checked').each ->
        categories.push($(@).val())

      extensions = new ExtensionList()
      @.collection = extensions.filter(categories)
      @.render()

# application
  categories = new CategoryList()
  extensions = new ExtensionList()

  initCategories = ->
    categoriesView = new CategoryView({collection: categories})
    categoriesView.render()

  extensionsView = new ExtensionsView({collection: extensions})

  initExtensions = ->
    App.allExtensions = extensions
    extensionsView.render()

  categories.fetch({ success: initCategories })
  extensions.fetch({ success: initExtensions })

  App.vent.on "filterExtensions", ->
    extensionsView.filter()
