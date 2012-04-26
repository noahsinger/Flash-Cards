
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


scaleDown = (element, max_width, font) ->
	starting_font_size = element.css("font-size")

	current_text_width = textWidth( element, font )
	while( current_text_width > max_width )
		element.css( "font-size", parseInt(element.css("font-size")) - 1 )
		current_text_width = textWidth( element, font )

	console.log "\tstarting font size #{starting_font_size} changed to #{element.css("font-size")}"


remove_left_margin_from_leading_cards = ->
	previous_top = 0
	$(".cards li, .decks li").each ->
		console.log "top: #{$(this).offset( ).top}"
		if $(this).offset( ).top != previous_top
			$(this).css( "margin-left", 0 );
		
		previous_top = $(this).offset( ).top
		

$(document).ready ->
	document.scale_card_content( )
	remove_left_margin_from_leading_cards( )		
	
	
	
	
	
	
	
	
	
	
	
	
	