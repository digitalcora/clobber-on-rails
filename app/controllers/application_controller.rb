class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :touch_user
  
  TILE_SIZE = 100.0 # Floating point for nicer SVG
  
  def touch_user
    current_user.touch if signed_in?
  end
end
