require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  test "decks have a shuffle method" do
    assert_respond_to Deck.first, :shuffle
  end
end
