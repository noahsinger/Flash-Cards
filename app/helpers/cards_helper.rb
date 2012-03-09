module CardsHelper
  
  def link_to_next text, current_card
    unless current_card.last?
      link_to( text, deck_card_path( current_card.deck, current_card.lower_item ) )
    else
      ""
    end
  end
  
  def link_to_prev text, current_card
    unless current_card.first?
      link_to( text, deck_card_path( current_card.deck, current_card.higher_item ) )
    else
      ""
    end
  end
  
end
