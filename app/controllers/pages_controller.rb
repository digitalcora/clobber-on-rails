class PagesController < ApplicationController
  before_filter :active_game_redirect

  def home
    if signed_in?
      respond_to do |format|
        format.html do
          @title = 'Game Lobby'
          @message = Message.new
          @messages = Message.where(:game_id => nil,
            :created_at => (DateTime.now - 5.minutes)..DateTime.now)
          @last_message_id = Message.last.id
        end
        
        format.js do
          @messages = Message.where('game_id is null and id > ?', params[:last_message].to_i)
        end
      end
      
      @users = User.online
      @sent_challenge = current_user.challenge
      @incoming_challenge = current_user.incoming_challenge
    end
  end
end
