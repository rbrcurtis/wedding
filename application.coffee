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

		if hash is 'guestbook'
			$.ajax('http://'+document.location.hostname+':8000').success (entries) ->
				for entry in entries
					$('.entries').append("<tr><td class='text'>#{clean(entry.text)}</td></tr><tr><td class='name'>by #{clean(entry.name)}</td></tr>")

$ ->
	$(window).hashchange -> route()
	route()


clean = (str) ->
	encodeURI(str).replace(/%20/g,' ')

window.signBook = ->
	message = $("#guest-book").serialize()
	debug 'sign', message
	$.ajax 'http://'+document.location.hostname+':8000', 
		type: 'POST'
		data: message
		success: -> route()