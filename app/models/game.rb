class Game < ActiveRecord::Base
  attr_accessible # No accessible attributes
  after_initialize :set_active
  
  has_many :messages
  has_many :players
  has_many :pieces, :through => :players
  
  def set_active
    self.active = true
  end
end
