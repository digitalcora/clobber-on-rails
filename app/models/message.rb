class Message < ActiveRecord::Base
  attr_accessible :content
  default_scope order(:created_at)
  
  belongs_to :user
  belongs_to :game
  
  validates :user_id, :existence => { :allow_nil => true, :both => false }
  validates :game_id, :existence => { :allow_nil => true, :both => false }
  validates :content, :presence => true,
                      :length => { :maximum => 250 }
end
