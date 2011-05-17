class Game < ActiveRecord::Base
  attr_accessible # No accessible attributes
  after_initialize :set_defaults
  
  has_many :messages
  has_many :players
  has_many :pieces, :through => :players
  has_one :winner, :class_name => 'Player', :conditions => ['won_game = ?', true]
  
  validates :turns, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  validates :width, :height, :numericality => { :only_integer => true, :greater_than => 2 }
  
  def set_defaults
    if new_record?
      self.active = true
      self.turns = 0
      self.width = 5
      self.height = 6
    end
  end
end
