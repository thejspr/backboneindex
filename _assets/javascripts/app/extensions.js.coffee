@BackboneIndex.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Extension extends Backbone.Model
    descriptionHtml: ->
      converter = new Showdown.converter({ extensions: ['github'] })
      return converter.makeHtml(@.get('description'))

  class Entities.ExtensionList extends Backbone.Collection
    model: Entities.Extension
    url: 'data/extensions.json'


@BackboneIndex.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.ExtensionView extends Marionette.ItemView
    model: App.Entities.Extension
    template: _.template("<h3><%= title %></h3><p><%= description %></p>")
    attributes: ->
      class: "extension #{@.displayClass()}"
    initialize: ->
      @.listenTo(@.model, 'change:hidden', this.setDisplay)
    displayClass: ->
      if @.model.get('hidden') then 'hidden' else ''
    setDisplay: ->
      if @.model.get('hidden')
        @.$el.addClass('hidden')
      else
        @.$el.removeClass('hidden')
    serializeData: ->
      "title": @.model.get('title'),
      "description": @.model.descriptionHtml()

  class Views.ExtensionsView extends Marionette.CompositeView
    el: "#extensions"
    template: _.template("<div class='extension-counter'><em><%= length %> plugins</em></div><div id='extension-list'></div>")
    itemView: Views.ExtensionView
    initialize: ->
      @.listenTo(this.collection, 'change', @.refreshCounter)
    refreshCounter: ->
      count = @.$el.find('.extension:not(.hidden)').length
      @.$el.find('.extension-counter > em').text("#{count} plugins")
    templateHelpers: ->
      return {length: @.collection.length}
    filterByCategories: ->
      categories = []
      $('.category:checked').each ->
        categories.push($(@).val())

      _.each @.collection.models, (extension) ->
        extension.set('hidden', !_.contains(categories, extension.get('category')))

