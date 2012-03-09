require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test "new cards should get a position" do
    deck = decks(:one)
    c = deck.cards.build( content: "test card" )
    c.save
    assert_not_nil c.position
  end
end
