# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

gvChartInit()
$ ->
  if ($('body.social').is('*'))
    $('.user_icon').hover (->
      $(@).next('p').show()
    ), ->
      $(@).next('p').hide()

    $('#chart').gvChart
      chartType: "LineChart"
      gvSettings:
        vAxis:
          title: ""

        hAxis:
          title: ""

        width: 900
        height: 600
    $('#gvChartDiv1').addClass('tab-pane')
    $('#data_table').tablefix height:500, fixRows:1
