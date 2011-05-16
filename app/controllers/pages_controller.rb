class PagesController < ApplicationController
  before_filter :active_game_redirect

  def home
    if signed_in?
      @title = 'Game Lobby'
      @users = User.online
      @message = Message.new
      @messages = Message.where(:game_id => nil, :created_at => (Time.now - 1.day)..Time.now)
      @sent_challenge = current_user.challenge
      @incoming_challenge = current_user.incoming_challenge
    end
  end
end
