class Piece < ActiveRecord::Base
  attr_accessible :x, :y
  
  belongs_to :player
  has_one :game, :through => :player
  
  validates :player_id, :existence => { :both => false }
  validates :x, :y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
end
