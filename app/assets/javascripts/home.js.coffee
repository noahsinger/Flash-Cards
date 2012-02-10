# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$("#user_email").keyup ->
		email = $("#user_email").val( )
		
		if email.match /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
			# alert( email )
			$.get '/home/valid_user',
				"email=" + email
				(data) -> 
			 		# alert( data )
				"script"
		false