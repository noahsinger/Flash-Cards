# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	javascript_check( );
	document.search_for_email( )
	
document.search_for_email = ->
	ignore_keys = [16,17,18,27,37,38,39,40,91,93]
	
	$("#email").keyup (event) ->
		email = $("#email").val( )
		# console.log "result: #{event.which} is ignored, #{event.which in ignore_keys}"
		if email.match /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
			unless event.which in ignore_keys
				document.show_spinner( )
				$.get '/home/valid_user',
					"email=" + email
					(data) -> 
				 		# alert( data )
					"script"
				false
		else
			# console.log "invalid email, additional fields current opacity: #{$("#additional_fields").css( "opacity" )}"
			# console.log "hidding additional fields"
			document.hide_additional_fields( )
		
javascript_check = ->
	$("#home_index form").css "display", "block"
	$("#noscript").css "display", "none"

document.show_spinner = ->
	if $("#spinner").css("visibility") == "hidden"
		$("#spinner").css("opacity", 0)
		$("#spinner").css("visibility","visible")
		$("#spinner").animate({opacity: 1}, 250)
		
document.hide_spinner = ->
	if $("#spinner").css("visibility") == "visible"
		$("#spinner").animate {opacity: 0}, 250, ->
			$("#spinner").css( "visibility", "hidden" )
			
document.show_additional_fields = ->
	if $("#additional_fields").css("visibility") == "hidden"
		$("#additional_fields").css("opacity", 0)
		$("#additional_fields").css("visibility","visible")
		$("#additional_fields").animate({opacity: 1}, 250)
		
document.hide_additional_fields = ->
	if $("#additional_fields").css("visibility") == "visible"
		$("#additional_fields").animate {opacity: 0}, 250, ->
			$("#additional_fields").css( "visibility", "hidden" )