# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	document.search_for_email( )
	
document.search_for_email = ->
	ignore_keys = [16,17,18,27,37,38,39,40,91,93]
	
	$("#email").keyup (event) ->
		email = $("#email").val( )
		# console.log( "result: #{event.which} is ignored, #{event.which in ignore_keys}" )
		if email.match /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
			unless event.which in ignore_keys
				show_spinner( )
				$.get '/home/valid_user',
					"email=" + email
					(data) -> 
				 		# alert( data )
					"script"
				false		
		
show_spinner = ->
	if $("#spinner").css("visibility") == "hidden"
		$("#spinner").css("opacity", 0)
		$("#spinner").css("visibility","visible")
		$("#spinner").animate({opacity: 1}, 250)

		
		
		
		
		
		
		
		
		