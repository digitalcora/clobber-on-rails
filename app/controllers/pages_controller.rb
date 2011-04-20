class PagesController < ApplicationController
  def home
    @title = 'Home'
    if signed_in?
      # Do signed in stuff here... Game.new?
    end
  end
end
