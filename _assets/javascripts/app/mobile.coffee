@moveSidebar = ->
  if ($(window).width() < 769)
    if $('#content #sidebar').length == 0
      $('#sidebar').insertAfter($('.intro'))
  else
    if $('#content #sidebar').length > 0
      $('#sidebar').insertBefore($('#content'))

$(window).resize(moveSidebar)

$(document).ready ->
  moveSidebar()

  $('[data-toggle]').click ->
    selector = $(this).data('toggle')
    $(selector).slideToggle()

