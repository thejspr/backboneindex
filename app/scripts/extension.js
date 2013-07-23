var Extension = Backbone.Model.extend({
  descriptionHtml: function() {
    var converter = new Showdown.converter({ extensions: ['github'] });
    return converter.makeHtml(this.get('description'));
  }
});

var ExtensionList = Backbone.Collection.extend({
  model: Extension,
  url: 'data/extensions.json',
  filter: function(categories) {
    var result = [];

    _.each(App.allExtensions.models, function(extension){
      if (_.contains(categories, extension.get('category')))
        result.push(extension);
    });

    return new ExtensionList(result);
  }
});

var ExtensionView = Backbone.Marionette.ItemView.extend({
  model: Extension,
  template: _.template("<div class='extension'><h3><%= title %></h3><p><%= description %></p></div>"),
  serializeData: function() {
    return {
      "title": this.model.get('title'),
      "description": this.model.descriptionHtml()
    }
  }
});

var ExtensionsView = Backbone.Marionette.CollectionView.extend({
  el: "#extensions",
  itemView: ExtensionView,
  filter: function() {
    var categories = [];

    $('.category:checked').each(function(){
      categories.push($(this).val());
    });

    var extensions = new ExtensionList()
    this.collection = extensions.filter(categories);
    this.render();
  }
});
