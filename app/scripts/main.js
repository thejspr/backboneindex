require.config({
  paths: {
    jquery: '../bower_components/jquery/jquery',
    backbone: '../bower_components/backbone/backbone',
    underscore: '../bower_components/underscore/underscore',
    showdown: '../bower_components/showdown/src/showdown',
    showdowngithub: 'vendor/showdown-github',
    marionette: '../bower_components/marionette/lib/backbone.marionette'
  }
});

require(['jquery', 'showdown', 'underscore', 'showdowngithub',
        'backbone', 'marionette', 'extension', 'category', 'app']);
