
document.scale_card_content = ->
  $(".cards li .content, .big_card .content").each ->
    $(this).css( "visibility", "hidden" )

  font = new Font( )
  font.onload = -> 
    $(".cards li .content, .big_card .content").each ->
      max_width = $(this).parent( ).width( )
      text_width = textWidth( $(this), font )

      console.log "text: #{$.trim($(this).text( ))}, text width: #{text_width}, max width: #{max_width}"

      if text_width > max_width
        scaleDown( $(this), max_width, font )
        console.log "\tnew text width is #{textWidth( $(this), font )}"
      
      $(this).css( "visibility", "visible" )

  font.fontFamily = "BloklettersBalpen"
  font.src = font.fontFamily

# slow and accurate		
# textWidth = (element, font) ->
#   size = element.css("font-size")
#   width = font.measureText(element.text( ), parseInt(size)).width
#   width

# fast but inaccurate
textWidth = (element, font) -> 
  text = element.text( )													#get the text
  wrapped = '<span>' + text + '</span>'						#wrap the text
  element.html( wrapped )													#put the wrapped text into the element
  width = element.find( 'span:first' ).width( )		#find the width of the wrapped text
  element.html( text )														#put the original text back
  width


scaleDown = (element, max_width, font) ->
	starting_font_size = element.css("font-size")

	current_text_width = textWidth( element, font )
	while( current_text_width > max_width )
		element.css( "font-size", parseInt(element.css("font-size")) - 1 )
		current_text_width = textWidth( element, font )

	console.log "\tstarting font size #{starting_font_size} changed to #{element.css("font-size")}"


$(document).ready ->
	document.scale_card_content( )
			
	
	
	
	
	
	
	
	
	
	
	
	
	