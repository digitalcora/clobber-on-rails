class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :touch_user, :get_help_content
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
    
    def get_help_content
      @help_content = HELP_CONTENT[controller_name + '#' + action_name] || HELP_CONTENT['fallback'] if not request.xhr?
    end
    
    def active_game_redirect
      if signed_in? and active_game?
        ajax_redirect_to active_game
      end
    end
    
    def ajax_redirect_to(resource)
      # FIXME - Can't take relative paths at the moment
      respond_to do |format|
        format.html { redirect_to resource }
        format.js { render :inline => "window.location = '#{url_for resource}';" }
      end
    end
    
    def ajax_redirect_back
      respond_to do |format|
        format.html { redirect_to :back }
        format.js { head :ok }
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
