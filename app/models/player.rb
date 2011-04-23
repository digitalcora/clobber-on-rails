class Player < ActiveRecord::Base
  attr_accessible # No accessible attributes
  
  belongs_to :user
  belongs_to :game
  has_many :pieces
end
