class Piece < ActiveRecord::Base
  attr_accessible :x, :y
  
  belongs_to :player
  has_one :game, :through => :player
  
  validates :player_id, :existence => { :both => false }
  validates :x, :y, :numericality => { :only_integer => true, :greater_than_or_equal_to => 0 }
  
  def move_targets
    move_targets = []
    [[0, -1], [0, 1], [-1, 0], [1, 0]].each do |offset|
      target_piece = self.game.pieces.where('x = ? and y = ? and player_id != ?',
        self.x + offset[0], self.y + offset[1], self.player.id).first
      move_targets << target_piece if !target_piece.nil?
    end
    return move_targets
  end
end
