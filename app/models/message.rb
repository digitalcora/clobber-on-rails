class Message < ActiveRecord::Base
  attr_accessible :content
  
  belongs_to :user
  belongs_to :game
  
  validates :user_id, :presence => true
  validates :content, :presence => true,
                      :length => { :maximum => 250 }
  def validate
    unless game_id.nil? or Game.find_by_id(game_id)
      errors.add(:game_id, 'must be nil or a valid game')
    end
  end
end
