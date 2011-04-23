class Piece < ActiveRecord::Base
  attr_accessible :x, :y
  
  belongs_to :player
end
