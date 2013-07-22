require.config({
  paths: {
    zepto: '../bower_components/zepto/zepto',
    backbone: '../bower_components/backbone/backbone',
    underscore: '../bower_components/underscore/underscore',
    showdown: '../bower_components/showdown/src/showdown',
    showdowngithub: 'vendor/showdown-github'
  }
});

require(['zepto', 'showdown', 'underscore', 'showdowngithub',
        'backbone', 'extension', 'category', 'app']);
