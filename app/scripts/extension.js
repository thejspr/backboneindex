var Extension = Backbone.Model.extend({
  descriptionHtml: function() {
    var converter = new Showdown.converter({ extensions: ['github'] });
    return converter.makeHtml(this.get('description'));
  },
  toAttributes: function() {
    return {title: this.get('title'), description: this.descriptionHtml()};
  }
});

var ExtensionList = Backbone.Collection.extend({
  model: Extension,
  url: 'data/extensions.json'
});

var ExtensionView = Backbone.View.extend({
  el: "#extensions",
  template: _.template("<div class='extension'><h3><%= title %></h3><p><%= description %></p></div>"),

  initialize: function() {
    this.originalCollection = $.extend({}, this.collection);
    this.collection.on('reset', this.render, this);
  },

  render: function() {
    $(this.el).empty();
    _.each(this.collection.models, function(extension){
      var extensionTemplate = this.template(extension.toAttributes());
      $(this.el).append(extensionTemplate);
    }, this);

    return this;
  }
});
