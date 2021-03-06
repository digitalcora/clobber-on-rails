require 'digest'

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :username, :password, :password_confirmation
  
  has_one :challenge
  has_one :incoming_challenge,
    :class_name => 'Challenge', :foreign_key => 'target_user_id'
  has_many :messages
  has_many :players
  has_many :games, :through => :players
  has_one :active_player,
    :class_name => 'Player', :conditions => ['active = ?', true]
  has_one :active_game,
    :through => :players, :source => :game, :conditions => ['games.active = ?', true]
  
  scope :online, lambda {
    where('updated_at > ?', 10.seconds.ago).
    order('username')
  }
  
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
  
  def wins
    self.players.where('won_game = ?', true).count
  end
  
  def losses
    # FIXME - Stupidly inefficient, needs caching
    count = 0
    self.games.each do |game|
      winner = game.players.where('won_game = ?', true).first
      count += 1 if winner and winner.user != self
    end
    return count
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
