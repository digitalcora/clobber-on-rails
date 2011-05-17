class Player < ActiveRecord::Base
  attr_accessible # No accessible attributes
  after_initialize :set_defaults
  
  belongs_to :user
  belongs_to :game
  has_many :pieces
  
  validates :game_id, :existence => { :both => false }
  validates :user_id, :existence => { :both => false },
                      :uniqueness => { :scope => :game_id }
  validates :turn_order, :presence => true,
                         :uniqueness => { :scope => :game_id },
                         :numericality => { :only_integer => true, :greater_than => 0 }
  
  def set_defaults
    if new_record?
      self.active = true
      self.turn_up = false
      self.won_game = false
    end
  end
  
  def any_moves?
    self.pieces.each do |piece|
      return true if !piece.move_targets.empty?
    end
    return false
  end
end
