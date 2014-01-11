# -- dependencies --
#= require vendor/jquery
#= require vendor/showdown
#= require vendor/showdown-github
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/backbone.marionette
#
# -- application --
#= require app/app
#= require app/categories
#= require app/extensions

$(document).ready ->
  if ($(window).width() < 769)
    $('#sidebar').insertAfter($('.intro'))

  $('[data-toggle]').click ->
    selector = $(this).data('toggle')
    $(selector).slideToggle()
