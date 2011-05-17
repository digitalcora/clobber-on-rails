class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :touch_user
  
  private
  
    def touch_user
      current_user.touch if signed_in?
    end
    
    def active_game_redirect
      if signed_in? and active_game?
        redirect_to active_game
      end
    end
end
