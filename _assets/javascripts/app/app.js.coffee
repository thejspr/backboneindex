@BackboneIndex = do (Marionette) ->

  App = new Marionette.Application()

  App.on "initialize:after", ->
    categories = new App.Entities.CategoryList()
    extensions = new App.Entities.ExtensionList()

    initCategories = ->
      categoriesView = new App.Views.CategoryView({collection: categories})
      categoriesView.render()

    extensionsView = new App.Views.ExtensionsView({collection: extensions})

    initExtensions = ->
      App.allExtensions = extensions
      extensionsView.render()

    categories.fetch({ success: initCategories })
    extensions.fetch({ success: initExtensions })

    filterView = new App.Views.FilterView()
    filterView.render()

    App.vent.on "categoriesChanged", ->
      extensionsView.filterByCategories()

    App.vent.on "filterChanged", ->
      extensionsView.filterByQuery()

  App

