@BackboneIndex.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Extension extends Backbone.Model
    descriptionHtml: ->
      converter = new Showdown.converter({ extensions: ['github'] })
      return converter.makeHtml(@.get('description'))

  class Entities.ExtensionList extends Backbone.Collection
    model: Entities.Extension
    url: 'data/extensions.json'
    filter: (categories) ->
      result = []

      _.each(App.allExtensions.models, (extension) ->
        result.push(extension) if (_.contains(categories, extension.get('category')))
      )

      new ExtensionList(result)


@BackboneIndex.module "Views", (Views, App, Backbone, Marionette, $, _) ->

  class Views.ExtensionView extends Marionette.ItemView
    model: App.Entities.Extension
    template: _.template("<div class='extension'><h3><%= title %></h3><p><%= description %></p></div>")
    serializeData: ->
      return {
        "title": @.model.get('title'),
        "description": @.model.descriptionHtml()
      }

  class Views.ExtensionsView extends Marionette.CompositeView
    el: "#extensions"
    template: _.template("<div class='extension-counter'><em><%= length %> plugins</em></div><div id='extension-list'></div>")
    itemView: Views.ExtensionView
    templateHelpers: ->
      return {length: @.collection.length}
    filter: ->
      categories = []

      $('.category:checked').each ->
        categories.push($(@).val())

      extensions = new App.Entities.ExtensionList()
      @.collection = extensions.filter(categories)
      @.render()

