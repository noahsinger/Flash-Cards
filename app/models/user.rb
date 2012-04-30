class User < ActiveRecord::Base
  has_many :decks, :dependent => :destroy
  
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
  
  validates :email, presence: {message: "cannot be blank"}, :uniqueness => true, :format => {:with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i}
  validates :password, presence: {message: "cannot be blank"}, :on => :create
  
  after_create :build_reg_hash
  
  def build_reg_hash
    update_attribute( :reg_hash, Digest::SHA256.hexdigest( self.email + self.id.to_s ) )
    # self.reg_hash = Digest::SHA256.hexdigest( self.email + self.id.to_s )
    # self.save
  end
end
