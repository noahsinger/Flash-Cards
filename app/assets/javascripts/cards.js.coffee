
document.scale_card_content = ->
	# hide cards until resized
	$(".cards li .content, .big_card .content").each ->
		$(this).css( "visibility", "hidden" )
	
	font = new Font( )
	font.onerror = ->
		console.log "***************** font error *****************"

	font.onload = ->
		console.log "font #{font.fontFamily} loaded"
		$(".cards li .content, .big_card .content").each ->
			# resize card content
			max_width = 0
			if $(this).parent( ).parent( ).hasClass( "cards" )
				max_width = $(this).parent( ).width( ) #- parseInt($(this).parent( ).css("padding-right")) #- parseInt($(this).parent( ).css("padding-left")) # this is the card itself's inner width with padding
			else
				max_width = $(this).parent( ).width( ) - parseInt($(this).parent( ).css("padding-right")) - parseInt($(this).parent( ).css("padding-left")) # this is the card itself's inner width with padding
			
			text_width = textWidth( $(this), font ) # this is the .content div holding the text

			console.log "text: #{$.trim($(this).text( ))}, text width: #{text_width}, max width: #{max_width}"

			# weird hack, this was done to debug the text resizing problem and for some unknown reason it fixed the problem.  Now to figure out why...
			size_div = $("<div></div>")
			size_div.css( "border", "1px solid red" ).css( "width", max_width ).css( "visibility", "hidden" ).css( "height", 0 ).text( max_width )
			$(this).append(size_div)
			####

			if text_width > max_width
				scaleDown( $(this), max_width, font ) # resizing the text based on the .content div that holds the text
				console.log "\tnew text width is #{textWidth( $(this), font )}"
      
			$(this).css( "visibility", "visible" )
  
	font.fontFamily = "BloklettersBalpen"
	font.src = font.fontFamily


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

# doesn't seem to wait for css to load on webkit browsers
# $(document).ready ->
	# console.log "document ready"
	# document.scale_card_content( )

$(document).ready ->
	# hide cards until resized
	$(".cards li .content, .big_card .content").each ->
		$(this).css( "visibility", "hidden" )
		
$(window).load ->
	console.log "window loaded"
	document.scale_card_content( )