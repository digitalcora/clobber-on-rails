class PagesController < ApplicationController
  def home
    if signed_in?
      @title = 'Game Lobby'
      @messages = Message.where(:game_id => nil, :created_at => (Time.now - 1.day)..Time.now)
    end
  end
end
