class Game < ActiveRecord::Base
  attr_accessible # No accessible attributes
  
  has_many :messages
  has_many :players
  has_many :pieces, :through => :players
end
