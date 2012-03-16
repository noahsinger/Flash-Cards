class Card < ActiveRecord::Base
  belongs_to :deck

  attr_accessible :content
  
  acts_as_list :scope => :deck
  
  validate :content, :presence => true
end
