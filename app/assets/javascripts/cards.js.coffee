# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

textWidth = (element) -> 
  text = element.text( )													#get the text
  wrapped = '<span>' + text + '</span>'						#wrap the text
  element.html( wrapped )													#put the wrapped text into the element
  width = element.find( 'span:first' ).width( )		#find the width of the wrapped text
  element.html( text )														#put the original text back
  width																						#return the width

$(document).ready ->
	buffer = 20

	$(".cards li .content").each ->
		parent_inner_width = $(this).parent( ).innerWidth( ) - parseInt($(this).parent( ).css("padding-left")) - parseInt($(this).parent( ).css("padding-right"))
		text_width = textWidth( $(this) )
		max_width = parent_inner_width - buffer;

		console.log "text: #{$.trim($(this).text( ))}, text width: #{text_width}, max width: #{max_width}"

		if text_width > max_width
			scaleDown( $(this), max_width )
			
scaleDown = (element, max_width) ->
	starting_font_size = element.css("font-size")

	current_text_width = textWidth( element )
	while( current_text_width > max_width )
		element.css( "font-size", parseInt(element.css("font-size")) - 1 )
		current_text_width = textWidth( element )
		
	console.log "starting font size #{starting_font_size} changed to #{element.css("font-size")}"
	
	
	
	
	
	
	
	
	
	
	
	
	