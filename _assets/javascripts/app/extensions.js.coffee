@BackboneIndex.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Extension extends Backbone.Model
    descriptionHtml: ->
      converter = new Showdown.converter({ extensions: ['github'] })
      return converter.makeHtml(@.get('description'))
    hidden: ->
      @.get('hiddenByCategory') || @.get('hiddenByFilter')

  class Entities.ExtensionList extends Backbone.Collection
    model: Entities.Extension
    url: 'data/extensions.json'


@BackboneIndex.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.ExtensionView extends Marionette.ItemView
    model: App.Entities.Extension
    template: _.template("<div class='pull-right label label-pink'><%= category %></div><h3><%= title %></h3><p><%= description %></p>")
    attributes: ->
      class: "extension #{@.displayClass()}"
    initialize: ->
      @.listenTo(@.model, 'change', @.setDisplay)
    displayClass: ->
      if @.model.hidden() then 'hidden' else ''
    setDisplay: ->
      if @.model.hidden()
        @.$el.addClass('hidden')
      else
        @.$el.removeClass('hidden')
    serializeData: ->
      "title": @.model.get('title'),
      "description": @.model.descriptionHtml(),
      "category": @.model.get('category')

  class Views.ExtensionsView extends Marionette.CompositeView
    el: "#extensions"
    template: _.template("<div class='extension-counter'><em><%= length %> plugins</em></div><div id='extension-list'></div>")
    itemView: Views.ExtensionView
    initialize: ->
      @.listenTo(@.collection, 'change', @.refreshCounter)
    refreshCounter: ->
      count = @.$el.find('.extension:not(.hidden)').length
      @.$el.find('.extension-counter > em').text("#{count} plugins")
    templateHelpers: ->
      return {length: @.collection.length}
    filterByQuery: ->
      regex = new RegExp($('#query').val(), 'i')
      _.each @.collection.models, (extension) ->
        hide = extension.get('title').search(regex) == -1 && extension.get('description').search(regex) == -1
        extension.set('hiddenByFilter', hide)
    filterByCategories: ->
      categories = []
      $('.category:checked').each ->
        categories.push($(@).val())

      _.each @.collection.models, (extension) ->
        extension.set('hiddenByCategory', !_.contains(categories, extension.get('category')))

