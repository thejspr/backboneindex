require.config({
  paths: {
    zepto: '../bower_components/zepto/zepto',
    backbone: '../bower_components/backbone/backbone',
    underscore: '../bower_components/underscore/underscore',
    showdown: '../bower_components/showdown/src/showdown',
    showdowngithub: 'vendor/showdown-github'
  },
  shim: {
    bootstrap: {
      deps: ['zepto'],
      exports: 'zepto'
    }
  }
});

require(['zepto', 'showdown', 'showdowngithub', 'underscore', 'backbone', 'extension', 'category', 'app'], function (app, $) {
  'use strict';
});
