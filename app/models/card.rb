class Card < ActiveRecord::Base
  belongs_to :deck
  
  validate :content, :presence => true
end
