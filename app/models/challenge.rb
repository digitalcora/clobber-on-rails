class Challenge < ActiveRecord::Base
  attr_accessible :target_id
  
  belongs_to :user
  belongs_to :target_user, :class_name => 'User', :foreign_key => 'target_id'
  # NOTE: "target" is a built-in Rails property and can't be the name of an association
  
  validates :user_id, :uniqueness => true,
                      :existence => { :both => false }
  validates :target_id, :uniqueness => true,
                        :existence => { :both => false }
end
