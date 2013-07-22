require.config({
  paths: {
    zepto: '../bower_components/zepto/zepto',
    backbone: '../bower_components/backbone/backbone',
    underscore: '../bower_components/underscore/underscore',
    showdown: '../bower_components/showdown/compressed/showdown',
    showdowngithub: 'vendor/showdown-github'
  }
});

require(['zepto', 'showdown', 'showdowngithub', 'underscore',
        'backbone', 'extension', 'category', 'app'], function (app, $) {
  'use strict';
});
