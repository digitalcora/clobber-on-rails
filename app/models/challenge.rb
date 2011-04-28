class Challenge < ActiveRecord::Base
  attr_accessible :target_id
  
  belongs_to :user
  belongs_to :target, :class_name => 'User'
  
  validates :user_id, :uniqueness => true,
                      :existence => { :both => false }
  validates :target_id, :uniqueness => true,
                        :existence => { :both => false }
end
