#= require jquery
#= require jquery_ujs
#= require headroom
#= require turbolinks
#= require foundation
#= require epic
#= require disqus_rails
#= require disablescroll
#= require velocity
#= require_self
$ ->
  $(document).foundation();

ready = ->
  $('.main-nav').headroom()

  addScrollBinds = ->
    if $('.image-container').length
      blockScroll = false

      $('.image-container').headroom(
        onNotTop: ->
          $('.image-container').trigger "change"
        onTop: ->
          $('.image-container').trigger "change"
      )
    # $('.image-container').on 'webkitTransitionEnd', (event) ->
    #   unless $('.image-container').is('.headroom--top')
    #     $('body, html').animate({
    #         scrollTop: 1
    #       }, 0)
    #     # blockScroll = false
    #   else
    #     # blockScroll = true

    $(window).unbind('scroll')

    $(window).bind 'scroll', (e) ->
      # if blockScroll
      #   $('body, html').animate({
      #     scrollTop: 1
      #   }, 0)
      #   e.preventDefault()

    $('.image-container').on 'change', ->
      unless $(@).is('.headroom--top')
        $(@).velocity
          marginBottom: '-500'
          opacity: '0.2'
          translateY: "-100%"
          scale: 0.9
        ,
          delay: false
          duration: 1200
          easing: [0.7,0,0.3,1]
          begin: ->
            $('.image-container').velocity("stop")
            blockScroll = true
            disable_scroll()
          complete: ->
            blockScroll = false
            enable_scroll()
      else
        $(@).velocity
          marginBottom: '0'
          opacity: '1'
          translateY: "0%"
          scale: 1
        ,
          delay: false
          duration: 1200
          easing: [0.7,0,0.3,1]
          begin: ->
            $('.image-container').velocity("stop")
            blockScroll = true
            disable_scroll()
          complete: ->
            blockScroll = false
            enable_scroll()

  addScrollBinds()

  $('.menu').on 'click', (e) ->
    e.preventDefault()
    $('#perspective').addClass "animate"
    return false
  $('.container').on 'click', (e) ->
    if $('#perspective').is('.animate')
      $('#perspective').removeClass "animate"
      e.preventDefault()

  $('a').on 'ajax:success', (evt, data, status, xhr) ->
    addScrollBinds()
    $link = $(@)
    $('.wrapper').fadeOut "fast", ->
      $(@).html(data).ready ->
        $('.wrapper').fadeIn "slow", ->
          $(@).parents('#perspective').removeClass("animate")
          $('.image-container').headroom
            onNotTop: ->
              $('.image-container').trigger "change"
            onTop: ->
              $('.image-container').trigger "change"

          addScrollBinds()
          history.pushState({}, '', $link.attr('href')) unless $link.attr('href') is location.href

  loadPage = (href) ->
    $('.wrapper').load href, ->
      addScrollBinds()

  $(window).on "popstate", ->
    loadPage(location.href)

$(document).ready(ready)
$(document).on('page:load', ready)