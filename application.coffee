content = $('.content')
debugOn = true
debug = ->
	if debugOn then console.log arguments...

route = ->
	hash = location.hash or 'home'
	if hash.substr(0,2) is '#/' then hash = hash.substr 2

	debug 'routing to', hash

	$.ajax("pages/#{hash}.html").success (html) ->
		debug 'got page', html
		content.html html

$ ->
	$(window).hashchange -> route()
	route()
