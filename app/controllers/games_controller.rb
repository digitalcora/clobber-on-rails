class GamesController < ApplicationController
  def show
    @game = Game.find(params[:id])
  end
  
  def create
    
  end
end
