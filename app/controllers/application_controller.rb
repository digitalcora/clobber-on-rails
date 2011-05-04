class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :touch_user
  
  def touch_user
    current_user.touch if signed_in?
  end
end
