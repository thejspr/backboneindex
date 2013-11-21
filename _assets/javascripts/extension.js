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

    @.$('.category:checked').each ->
      categories.push($(@).val())

    extensions = new ExtensionList()
    @.collection = extensions.filter(categories)
    @.render()
