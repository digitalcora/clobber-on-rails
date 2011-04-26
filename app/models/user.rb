require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :username, :password, :password_confirmation
  
  has_many :messages
  has_many :players
  has_many :games, :through => :players
  has_one :active_player,
    :class_name => 'Player', :conditions => ['active = ?', true]
  has_one :active_game,
    :through => :players, :source => :game, :conditions => ['games.active = ?', true]
  has_many :past_players,
    :class_name => 'Player', :conditions => ['active = ?', false]
  has_many :past_games,
    :through => :players, :source => :game, :conditions => ['games.active = ?', false]
  
  validates :username, :presence => true,
                       :uniqueness => { :case_sensitive => false },
                       :length => { :maximum => 16 }
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 8..128 }
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    pass_hash == encrypt(submitted_password)
  end
  
  def self.authenticate(username, submitted_password)
    user = find_by_username(username)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
    
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.pass_hash = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
end
