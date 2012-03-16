class Card < ActiveRecord::Base
  belongs_to :deck

  attr_accessible :content
  
  acts_as_list :scope => :deck
  
  validates :content, :presence => true, :uniqueness => true
end
