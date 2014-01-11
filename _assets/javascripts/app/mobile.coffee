@moveSidebar = ->
  if ($(window).width() < 769)
    if $('#content #sidebar').length == 0
      $('#sidebar').insertAfter($('.intro'))
  else
    if $('#content #sidebar').length > 0
      $('#sidebar').insertBefore($('#content'))

moveSidebar()

$(window).resize(moveSidebar)

$(document).ready ->
  $('[data-toggle]').click ->
    selector = $(this).data('toggle')
    $(selector).slideToggle()

