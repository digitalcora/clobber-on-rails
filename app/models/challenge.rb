class Challenge < ActiveRecord::Base
  attr_accessible :target_user_id
  
  belongs_to :user
  belongs_to :target_user, :class_name => 'User'
  # NOTE: "target" is a built-in Rails property and can't be the name of an association
  
  validates :user_id, :uniqueness =>
                        { :message => "Can't challenge more than one user at a time!" },
                      :existence => { :both => false }
  validates :target_user_id, :uniqueness =>
                               { :message => "That user is being challenged by someone else!" },
                             :existence => { :both => false }
end
