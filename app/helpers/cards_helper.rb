module CardsHelper
  
  def link_to_next text, current_card
    unless current_card.last?
      link_to( text, deck_card_path( current_card.deck, current_card.lower_item ), class: "next arrow_links", remote: true )
    else
      '<span class="arrow_links next"></span>'.html_safe
    end
  end
  
  def link_to_prev text, current_card
    unless current_card.first?
      link_to( text, deck_card_path( current_card.deck, current_card.higher_item ), class: "prev arrow_links", remote: true )
    else
      '<span class="arrow_links prev"></span>'.html_safe
    end
  end
  
end
