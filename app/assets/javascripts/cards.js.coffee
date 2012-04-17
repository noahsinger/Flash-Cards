
document.scale_card_content = ->
  $(".cards li .content, .big_card .content").each ->
    $(this).css( "display", "none" )

  font = new Font( )
  font.onload = -> 
    $(".cards li .content, .big_card .content").each ->
      max_width = $(this).parent( ).width( )
      text_width = textWidth( $(this), font )

      console.log "text: #{$.trim($(this).text( ))}, text width: #{text_width}, max width: #{max_width}"

      if text_width > max_width
        scaleDown( $(this), max_width, font )
        console.log "\tnew text width is #{textWidth( $(this), font )}"
      
      $(this).css( "display", "table-cell" )

  font.fontFamily = "BloklettersBalpen"
  font.src = font.fontFamily

		
textWidth = (element, font) ->
  size = element.css("font-size")
  width = font.measureText(element.text( ), parseInt(size)).width
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
			
	
	
	
	
	
	
	
	
	
	
	
	
	