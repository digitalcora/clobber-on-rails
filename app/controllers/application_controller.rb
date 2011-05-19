class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :touch_user
  after_filter :flash_to_headers
  
  def flash_to_headers
    if request.xhr? and flash_message
      response.headers['X-Message'] = flash_message
      response.headers['X-Message-Type'] = flash_type
      flash.discard
    end
  end
  
  private
  
    def touch_user
      current_user.touch if signed_in?
    end
    
    def active_game_redirect
      if signed_in? and active_game?
        redirect_to active_game
      end
    end
    
    def flash_message  
      [:error, :warning, :notice, :success].each do |type|
        return flash[type] unless flash[type].blank?
      end
      return nil
    end
    
    def flash_type
      [:error, :warning, :notice, :success].each do |type|
        return type.to_s unless flash[type].blank?
      end
      return nil
    end
end
