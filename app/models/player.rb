class Player < ActiveRecord::Base
  attr_accessible # No accessible attributes
  after_initialize :set_active
  
  belongs_to :user
  belongs_to :game
  has_many :pieces
  
  def set_active
    self.active = true
  end
end
