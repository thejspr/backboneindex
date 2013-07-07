var Extension = Backbone.Model.extend();

var ExtensionList = Backbone.Collection.extend({
  model: Extension,
  url: 'data/extensions.json'
});

var ExtensionView = Backbone.View.extend({
  el: "#extensions",
  template: _.template("<div class='extension'><h3><%= title %></h3><p><%= description %></p></div>"),
  render: function(eventName) {
    _.each(this.model.models, function(extension){
      var extensionTemplate = this.template(extension);
      $(this.el).append(extensionTemplate);
    }, this);

    return this;
  }
});

var extensions = new ExtensionList();
extensions.fetch();

var extensionsView = new ExtensionView({model: extensions});
extensionsView.render();