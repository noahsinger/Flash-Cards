
document.scale_card_content = ->
  # hide cards until resized
  $(".cards li .content, .big_card .content").each ->
    $(this).css( "visibility", "hidden" )

  font = new Font( )
  font.onerror = ->
    console.log "***************** font error *****************"

  font.onload = ->
    $(".cards li .content, .big_card .content").each ->
      # resize card content
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
textWidth = (element, font) ->
  size = element.css("font-size")
  width = font.measureText(element.text( ), parseInt(size)-8).width
  width


# fast but inaccurate, breaks rest_in_place
# textWidth = (element, font) -> 
#   console.log "---------finding width------------"
#   content = element.html( )												# get the text
#   console.log "content is #{content.replace( /[\n\t]/g, "")}"
#   wrapped = '<span>' + content + '</span>'				# wrap the text
#   console.log "wrapped is #{wrapped.replace( /[\n\t]/g, "")}"
#   element.html( wrapped )													# put the wrapped text into the element
#   width = element.find( 'span:first' ).width( )		# find the width of the wrapped text
#   console.log "width is #{width}"
#   element.html( content )													# put the original text back
#   console.log "----------------------------------"
#   width


scaleDown = (element, max_width, font) ->
	starting_font_size = element.css("font-size")

	current_text_width = textWidth( element, font )
	while( current_text_width > max_width )
		element.css( "font-size", parseInt(element.css("font-size")) - 1 )
		current_text_width = textWidth( element, font )

	console.log "\tstarting font size #{starting_font_size} changed to #{element.css("font-size")}"
		

$(document).ready ->
	document.scale_card_content( )
			
	
	
	
	
	
	
	
	
	
	
	
	
	