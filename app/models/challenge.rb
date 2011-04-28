class Challenge < ActiveRecord::Base
  attr_accessible :target_id
  
  belongs_to :user
  belongs_to :target, :class_name => 'User'
  
  validates :user, :presence => { :unique => true }
  validates :target, :presence => { :unique => true }
  
  def validate
    if not User.find_by_id(user_id)
      errors.add(:user_id, 'must be a valid user')
    end
    if not User.find_by_id(target_id)
      errors.add(:target_id, 'must be a valid user')
    end
  end
end
