class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards, :order => :position, :dependent => :destroy
  
  attr_accessible :name
  
  validates :name, :presence => true
  
  def shuffle
    random_positions = (1..(self.cards.count)).to_a.shuffle
    self.cards.all.each_with_index do |card, index|
      card.position = random_positions[index]
      card.save
    end
  end
  
end
