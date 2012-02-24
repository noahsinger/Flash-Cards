class User < ActiveRecord::Base
  has_secure_password
  
  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i}
  validates :password, :presence => :true, :on => :create
  
  after_create :build_reg_hash
  
  def build_reg_hash
    self.reg_hash = Digest::SHA256.hexdigest( self.email + self.id.to_s )
    self.save
  end
end
