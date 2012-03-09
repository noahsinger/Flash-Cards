require 'test_helper'

class NextPrevTest < ActionDispatch::IntegrationTest
  test "middle card in deck should have a next and prev link" do
    get deck_card_path( decks(:one), cards(:three) )
    assert_select "a[href=#{deck_card_path(decks(:one), cards(:four))}]"
    assert_select "a[href=#{deck_card_path(decks(:one), cards(:one))}]"
  end
  
  test "last card in deck should not have next link" do
    get deck_card_path( decks(:one), cards(:three) )
    assert_select "a[href=#{deck_card_path(decks(:one), cards(:one))}]"
  end
  
  test "first card in deck should not have prev link" do
    get deck_card_path( decks(:one), cards(:three) )
    assert_select "a[href=#{deck_card_path(decks(:one), cards(:four))}]"
  end
end
