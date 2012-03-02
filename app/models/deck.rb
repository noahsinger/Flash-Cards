class Deck < ActiveRecord::Base
  belongs_to :user
  has_many :cards, :dependent => :destroy
  
  validate :name, :presence => true
end
