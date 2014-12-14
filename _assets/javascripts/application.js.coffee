# -- dependencies --
#= require vendor/jquery.min
#= require vendor/showdown
#= require vendor/showdown-github
#= require vendor/underscore-min
#= require vendor/backbone-min
#= require vendor/backbone.marionette.min

# -- application --
#= require app/app
#= require app/categories
#= require app/extensions
#= require app/mobile

#= require_self

$ ->
  BackboneIndex.start()
